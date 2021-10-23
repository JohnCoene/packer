RESULT=$(Rscript -e "packer:::are_minified('<<PATH>>')")
if [ $RESULT -gt 0 ]
	then
	echo 'JavaScript files not minified, run packer::bundle_prod()'
fi
exit $RESULT
