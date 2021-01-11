#!/bin/bash
source_path="/home/rstudio"
code_deploy_path="code/deployment/msstats-dev"
test_folder="tests"
test_utils_folder="utils"
# move into the test folder
cd $source_path/$code_deploy_path/$test_folder
# # execute infra and config files
sudo chmod +x utils/install.R
# # to input '1' infinitely when the console prompts for input a
yes a | Rscript ./utils/install.R |& tee install.log
# make the file executable
sudo chmod +x dataprocess.R
# & to run in background
# pointing output to dev/null so that code deploy doesn't stall
cmd_arg=$source_path/$code_deploy_path/$test_folder/$test_utils_folder
# yes a | ./dataprocess.R ${cmd_arg} > /dev/null 2> /dev/null < /dev/null &
tmux -vv new-session -d -s "msstatstest" Rscript ./dataprocess.R ${cmd_arg}
