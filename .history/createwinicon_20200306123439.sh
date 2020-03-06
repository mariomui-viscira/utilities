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

imageFilename=$inputFile;
file1024x1024="file1024x1024.png";

if [ ! -f $imageFilename ]; then
  echo 'File does not exist, please specify.';
  exit;
else
  echo "File exists: processing...${imageFilename}";
  #resize input into 1024 base png.
  convert -background none -resize 1024x1024 "$inputFile" "$file1024x1024";

fi;

[[ $imageFilename =~ (^[^\.]+) ]] && imageFilename=${BASH_REMATCH[1]};

sips -z 16 16 "$file1024x1024" --out "$imageIconset"/icon_16x16.png
sips -z 24 24 $file1024x1024 --out $imageIconset/icon_24x24.png
sips -z 32 32 $file1024x1024 --out $imageIconset/icon_32x32.png
sips -z 48 48 $file1024x1024 --out $imageIconset/icon_32x32.png
sips -z 64 64 $file1024x1024 --out $imageIconset/icon_64x64.png
sips -z 128 128 $file1024x1024 --out $imageIconset/icon_128x128.png
sips -z 256 256 $file1024x1024 --out $imageIconset/icon_256x256.png

