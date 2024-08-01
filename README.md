# Ticket System

## System for ticketing issues, ideas and future automations

### By: Nikolay Panev

### License: MIT

#### Dependencies:
##### SHC (for compilation, build and install) - https://github.com/neurobin/shc (also available in most package managers)
##### GNU Make (for compilation, build and install) - https://www.gnu.org/software/make/ (usually comes with your linux distro)

#### How to install:
##### Download the project and extract it to a directory
##### Run the following commands in the directory you extracted it in:
```
cd  package
```
```
make
```
```
make install
```
### !!WARNING!!
##### The command ```make install``` will require super user privilages, because it copies the binaries inside the /home/usr/bin folder.
##### If you lack user privilages, or don't want to use them, I suggest you make an alias inside your shell rc file in you home directory (~/.bashrc, ~/.zshrc etc)
##### In this alias you can link the binary compiled inside package/bin/
##### For bash, it would look something like:
```alias ticket='project_repo_directory/package/bin/ticket'```
##### To be able to use your new alias, use:
```
source ~/.bashrc
```

#### After the install, make sure the project is working correctly:
```
ticket --help
```

# CopyRight: Nikolay Panev
# 2024 - Malko Turnovo, Bulgaria
