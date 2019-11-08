# Fuzzing
## Dependencies
* [Vagrant](https://www.vagrantup.com/)
* [VirtualBox](https://www.virtualbox.org/)

## Setup 
Everyone who is part of the project should have his own diary in which he/she will write down his/her progress. Create it in the diaries directory of this project.

Depending on your host operating system, update .gitignore so the repository is not polluted with system files. Full list of preconfigured .gitignore files can be found [here](https://github.com/github/gitignore).

## Test cases
Directory testcases contains two files mp4 files which I have found online. I have trimmed them so they are under the AFL recommended limit of 1KB. They are still completely valid mp4 files, but they are (very) short.

## Running the environment
Enter the project directory via terminal/cmd. Run the following command:
```bash
vagrant up
```
Note that it will take some time when you run it for the first time because Vagrant has to download the base Ubuntu box.

The shouldn't be any errors during the VM configuration. After the configuration is done, you can access the VM using:
```bash
vagrant ssh
```