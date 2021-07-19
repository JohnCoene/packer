LINES=$(wc -l <<PATH>>/*.js)

for LINE in $LINES
do
	if [ $LINE -gt 1 ]
		then
		echo "JavaScript files not minified, run packer::bundle_prod()"
		exit 1
	fi
done
