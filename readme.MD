#! /bin/bash
#dependencies 
# brew install imagemagick
# brew install ghostscript

*all caps is user inputted*
`./createicon i INPUTFILE`

2020 update

## Creating a mac icon
./createicon.sh -i ./slab2/testing.png  
* slab2 is the directory that will house your source image
* testing.png is the source image usually very big 2048 × 2048
* createicon.sh will run imagemagick and ghostscript to convert the source file into the requisite sizes.
* no inputfile then the fallback is "file1024x1024.png" in root
* output files will be pumped into the same folder as the input folder.

## Creating a windows icon.
./createwinicon.sh i ./pres_branded/SB_app_icon/SB_app_icon.png   
* SB_app_icon is the directory that will house your source image
* SB_app_icon.png  is the source image usually very big 2048 × 2048
* createwinicon.sh will run imagemagick and ghostscript to convert the source file into the requisite sizes.
* output files will be pumped into the same folder as the input folder.

