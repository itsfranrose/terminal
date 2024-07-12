### Description
This repo contains my terminal shell scripts located at ~/Studio/Terminal.

I source env at login in `.profile`.
be warned that since I mainly use zsh, there may be some code that is only zsh compatible, but I doubt that that's the case; usually my codes are bash-like.

`src.zsh` calls the appropriate script from `src/`, and each script sources the appropriate code and takes the code root directory and `-v` (verbose) as args.
for nested scripts in each section, sourcers only go down in directories that end with `.d` so as to allow some development flexibility; and also the files that each sourcer looks for should end with - `.env` for environment variables in `env/`, `.zsh` for aliases, and `.rc` for modules.

`zim.zsh` just sources the aliases and modules and integrates in `zimfw`.

### TODOS
- cleanup deprecated directory
- create documentation for the scripts.
    - Or dynamically add those documentation to here, or another relevant readme file.
