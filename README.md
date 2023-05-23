### Description
This repo contains my terminal shell scripts located at ~/Studio/Terminal.  

`sourcer.sh` is a bash script that if called, given a directory as a positional argument, 
it would `source` bash files that their name ends with `.rc` found within directories that end with `.d`, **recursively**.  

If `sourcer.sh` were called from the `.bashrc` file or the `.zshrc` file, every `*.rc` bash script would run 
and the opened termianl would have access to all the result produced by them.

### TODOS
- cleanup deprecated directory
- migrate the TODOS to this readme file
- create documentation for the scripts.
    - Or dynamically add those documentation to here, or another relevant readme file.
