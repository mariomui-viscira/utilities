#! /bin/bash
#dependencies 
# brew install imagemagick
# brew install ghostscript

inputFile='';

optsCount=0;
while getopts ":i:h" opt; do
  case ${opt} in
    i ) # process option a
      inputFile=$OPTARG;
      if [ ${#OPTARG} -gt 0 ];then
        echo "Beginning to process $OPTARG"
      else
        echo "Please provide arguments";
        exit;
      fi;
      ;;
    h ) 
      echo "Usage: cmd [-i]";
      echo "
        Place scripts inside png/svg folder.
        ./createicon i [inputfile]
        This will create a folder with the name of your input file with mac and win icons.
      "
      exit;
      ;;
  esac
done

# if [ ${#*} -ne 1 ];then
#   echo "Error: requires 1 arguments"
#   exit;
# fi;

imageFilename=$inputFile;
#temporary file for the fallback image
file1024x1024="file1024x1024.png";
## no op when file does not exist.

#convert a bigger file to 1024.
if [ ! -f $imageFilename ]; then
  echo 'File does not exist, please specify.';
  exit;
else
  echo "File exists: processing...${imageFilename}";
  #resize input into 1024 base png.
  convert -background none -resize 1024x1024 "$inputFile" "$file1024x1024";

fi;

#imageFilename is has been rewritten. marcus.svg is now marcus
[[ $imageFilename =~ (^[^\.]+) ]] && imageFilename=${BASH_REMATCH[1]};



  # convert into 256 mb icon file for windows

imageIconset="$imageFilename".iconset;
#marcus.iconset


mkdir $imageIconset;
mkdir $imageFilename;

# convert $file1024x1024 --background none -scale 256 "${imageFilename}x256.ico";

sips -z 16 16 "$file1024x1024" --out "$imageIconset"/icon_16x16.png
sips -z 32 32 $file1024x1024 --out $imageIconset/icon_16x16@2x.png
sips -z 32 32 $file1024x1024 --out $imageIconset/icon_32x32.png
sips -z 64 64 $file1024x1024 --out $imageIconset/icon_32x32@2x.png
sips -z 128 128 $file1024x1024 --out $imageIconset/icon_128x128.png
sips -z 256 256 $file1024x1024 --out $imageIconset/icon_128x128@2x.png
sips -z 256 256 $file1024x1024 --out $imageIconset/icon_256x256.png
sips -z 512 512 $file1024x1024 --out $imageIconset/icon_256x256@2x.png
sips -z 512 512 $file1024x1024 --out $imageIconset/icon_512x512.png
cp $file1024x1024 $imageIconset/icon_512x512@2x.png
iconutil -c icns $imageIconset

convert "$imageIconset/icon_16x16.png" "$imageIconset/icon_32x32.png" "$imageIconset/icon_128x128.png" "$imageIconset/icon_256x256.png" "${imageFilename}-256.ico";

rm -R $imageIconset




macIcon="${imageFilename}.icns";
winIco256="${imageFilename}-256.ico";
winIco="${imageFilename}.ico";
mv "${macIcon}" "${imageFilename}/${macIcon}"
cp "${winIco256}" "${imageFilename}/${winIco}"
mv "${winIco256}" "${imageFilename}/${winIco256}"
