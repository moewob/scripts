cd rom
crave pull out/target/product/garnet/*.zip
mv *.zip ../
cd ../
./gdrive files upload --parent 0AERIbw7xyKdyUk9PVA *.zip
rm *.zip
