
rm product.img
mksquashfs addon-work/product/ product.img -comp xz

[ -d isoboot_source_alma ]cp -p product.img isoboot_source_alma/images/
[ -d isoboot_source_rocky ]cp -p product.img isoboot_source_rocky/images/
