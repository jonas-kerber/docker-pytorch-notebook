# Get main and help dir
helpdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
maindir="$helpdir/.."
echo $helpdir
echo $maindir

# Remove all running containers because it will not work otherwise
echo "Removing all running containers..."
$helpdir/force_remove_all_docker_containers.sh

# Create helping file and run in separate tab
run_cmd="$maindir/docker_run.sh | tee $helpdir/.output_run.txt"
echo $run_cmd > $helpdir/.start_jupyter_notebook.sh
chmod +x $helpdir/.start_jupyter_notebook.sh
echo -e "\n Start docker_run.sh in new terminal tab..."
open -a Terminal.app $helpdir/.start_jupyter_notebook.sh &   #on linux:  xterm -e $helpdir/.start_jupyter_notebook.sh; check for OS with uname

# After 2 seconds automatically get token 
sleep 2
echo -e "\nGetting token ID..."
output=$(cat $helpdir/.output_run.txt)
token_id=$(echo $output | sed -E  's/(.*)token=(.*)/\2/')

# Open web page with token_id
echo -n "Opening page http://localhost:8888/?token="
echo $token_id
command="open http://localhost:8888/?token=$token_id"   #on linux: xdg-open ...
eval $command
