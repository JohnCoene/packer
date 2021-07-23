FILES=$(ls <<PATH>>/*.js)

for FILE in $FILES
do
  LINES=$(wc -l $FILE)
  read -ra LINE <<<"$LINES"
  echo $LINE
        if [ $LINE -gt 1 ]
                then
                echo "JavaScript files not minified, run packer::bundle_prod()"
                exit 1
        fi
done