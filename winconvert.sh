inputFolder=$1;
#usage winconvert INPUTFOLDER

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
        ./winconvert i [INPUTFOLDER]
        This will create a folder with the name of your input file with mac and win icons.
      "
      exit;
      ;;
  esac
done

if [ ! -d inputFolder]; then
  echo 'folder does not exist'
  exit;
else 
  echo "directy exist: processing ${inputFolder}"
fi;

cmd="convert"

for i in $(ls ${inputFolder}); 
  do
    echo $i;
    cmd="${cmd} ${inputFolder}/${i}"
    sleep .5;
  done;
  cmd="${cmd} ${inputFolder}.ico"
echo $cmd;
# eval $cmd;