ossufix=alma
osname=AlmaLinux

#create working directory
[ -d isoboot_source_$ossufix ]||mkdir -p isoboot_source_$ossufix

# Extract the official AlmaLinux ISO contents into workging directory
xorriso -osirrox on -indev ./${osname}-9.8-x86_64-boot.iso -extract / isoboot_source_$ossufix/
