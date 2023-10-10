PROJECT_ROOT=$(pwd)
BRANCH=android-14.0.0_r2-td

patch() {
	cd $1
	git reset HEAD --hard
	git remote add trebledroid $2
	git fetch trebledroid
	git merge trebledroid/$BRANCH --no-edit
	cd $PROJECT_ROOT
}

patch frameworks/opt/telephony https://github.com/TrebleDroid/platform_frameworks_opt_telephony
patch frameworks/native https://github.com/TrebleDroid/platform_frameworks_native
patch build/target https://github.com/TrebleDroid/platform_build
patch system/core https://github.com/TrebleDroid/platform_system_core
patch system/bpf https://github.com/TrebleDroid/platform_system_bpf
patch frameworks/base https://github.com/TrebleDroid/platform_frameworks_base
patch system/sepolicy https://github.com/TrebleDroid/platform_system_sepolicy
patch packages/modules/Connectivity https://github.com/TrebleDroid/platform_packages_modules_Connectivity
patch external/selinux https://github.com/TrebleDroid/platform_external_selinux
patch packagrs/modules/vndk https://github.com/TrebleDroid/platform_packages_modules_vndk
patch system/vold https://github.com/TrebleDroid/platform_system_vold
patch system/nfc https://github.com/TrebleDroid/platform_system_nfc
patch system/netd https://github.com/TrebleDroid/platform_system_netd
patch system/linkerconfig https://github.com/TrebleDroid/platform_system_linkerconfig
patch system/extras https://github.com/TrebleDroid/platform_system_extras
patch packages/modules/Bluetooth https://github.com/TrebleDroid/platform_packages_modules_bluetooth
patch packages/apps/Settings https://github.com/TrebleDroid/platform_packages_apps_settings
patch hardware/interfaces https://github.com/TrebleDroid/platform_hardware_interfaces
patch frameworks/opt/net/ims https://github.com/TrebleDroid/platform_frameworks_opt_net_ims
patch frameworks/libs/net https://github.com/TrebleDroid/platform_frameworks_libs_net
patch frameworks/av https://github.com/TrebleDroid/platform_frameworks_av
patch bootable/recovery https://github.com/TrebleDroid/platform_bootable_recovery
patch bionic https://github.com/TrebleDroid/platform_bionic

echo End
