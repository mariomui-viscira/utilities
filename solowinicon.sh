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
sips -z 40 40 $file1024x1024 --out $imageIconset/icon_40x40.png

sips -z 48 48 $file1024x1024 --out $imageIconset/icon_48x48.png
sips -z 128 128 $file1024x1024 --out $imageIconset/icon_128x128.png


convert "$imageIconset/icon_16x16.png" "$imageIconset/icon_32x32.png" "$imageIconset/icon_40x40.png" \
"$imageIconset/icon_48x48.png" "$imageIconset/icon_128x128.png" "${imageFilename}.ico";

rm -R $imageIconset


echo "${imageFilename} what"
winIco="${imageFilename}";

cp "${winIco}.ico" "${imageFilename}/${winIco}-256.ico";
echo "${winIco} what am i";
mv "${winIco}.ico" "${imageFilename}";

