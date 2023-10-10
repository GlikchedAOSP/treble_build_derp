#!/bin/bash

#
# Copyright (C) 2023 glikched
#
# SPDX-License-Identifier: GNU General Public License v3.0
#

PROJECT_ROOT="$(pwd)"
BUILDBOT_ROOT="$(pwd)/buildbot"
PROJECT_NAME=DerpFest-AOSP
PROJECT_VERSION=14
PROJECT_MANIFEST_URL="https://github.com/$PROJECT_NAME/manifest"
DEVICE=treble

start() {
	echo '+-----------------+'
	echo '|     BuildBot    |'
	echo '|        by       |'
	echo '|     glikched    |'
	echo '+-----------------+'
	echo
	echo "--! Building on Kernel:"
	echo "--> [$(uname -r)]"
	echo
	echo "--> Building for $DEVICE"
}

repoinit() {
	if [ ! -d .repo ]; then
        	echo "--> Initializing workspace"
        	repo init -u $PROJECT_MANIFEST_URL -b $PROJECT_VERSION
		###
        	echo
		###
        	echo "--> Preparing local manifest"
        	mkdir -p .repo/local_manifests
		cd .repo/local_manifests
        	cp $BUILDBOT_ROOT/manifest.xml .
		cd $PROJECT_ROOT
	      	echo
	fi
}

reposync() {
	if [ ! -d .repo ]; then
		echo "--!! ERROR !!: Something went wrong during repoinit() function"
		exit
	else
		echo "--> Syncing repos"
		repo sync -c --force-sync --no-clone-bundle --no-tags -j$(nproc --all)
		echo
	fi
}

generatetrees() {
	echo "--> Generating makefiles"
	cd device/phh/treble
	git reset HEAD --hard
	cp $BUILDBOT_ROOT/derp.mk .
	bash generate.sh derp
	cd ../../..
	echo
}

setupenviorment() {
	echo "--> Setting up build environment"
	source build/envsetup.sh &>/dev/null
	mkdir $BUILDBOT_ROOT/builds
	echo
}

build() {
	echo "--> Building $DEVICE_arm64_bvN"
	lunch treble_arm64_bvN-userdebug
	make -j$(nproc --all) installclean
	make -j$(nproc --all) systemimage
	mv $OUT/system.img $PROJECT_ROOT/builds/system-treble_arm64_bvN.img
	echo
}

START=$(date +%s)

start
#repoinit
#reposync
#generatetrees
#bash $BUILDBOT_ROOT/apply-patches.sh
setupenviorment
build

END=$(date +%s)
ELAPSEDM=$(($(($END-$START))/60))
ELAPSEDS=$(($(($END-$START))-$ELAPSEDM*60))

echo
echo "--> Buildbot completed in $ELAPSEDM minutes and $ELAPSEDS seconds."
echo
