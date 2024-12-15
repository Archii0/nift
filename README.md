# Nift

Nift is a minimal build system for quick-starting projects on Linux.

## Usage

### Setup
Clone the repo and create your own templates in the `/templates` directory. Information about making templates is discussed [here](#making-templates)

### Running Nift

Once your templates are made, run `sudo ./deploy.sh`, which will move your templates directory to `/var/nift` and the script to run it to `/usr/bin/nift`.

Nift can now be ran with the command:
```bash
nift <project name>
```

This will copy your chosen templates to a new directory, with your project name substituted into the template files and file names. 

There is also a verbose flag, where you can use nift with some extra features, such as a CLI menu, and functionality to view template directory structures:
```bash
nift <project name> [-v|--verbose]
```

## Making Templates

To make a new template, make sure that the project is not deployed. If it is you can undeploy by running:
```bash
sudo ./undeploy.sh
```

Then create a new folder in the `/templates` directory with your required setup.

Use the identifier `PROJECTNAME` both in file names and in files, where you want your chosen project name to be. 

An example of a C file, named `PROJECTNAME.c`:
```c
/* PROJECTNAME.c*/

#include "PROJECTNAME.h"

int main(int argc, char *argv[]) {
    printf("Nifty.");
    return 0;
}
```
Template are useful for including the standard main function, common type synonyms, library imports, build system files (e.g. makefiles) as well as setting up project directories for larger projects.

Note that empty directories are supported by Nift, but are not recorded by git (as git tracks files, not directories). Any empty directories in your template will not be stored in the origin repo - a good idea is to add a file to these directories or include the creation of these directories in your build scripts.

## Standard Templates

The repo includes some generic dummy templates to start with, including:
- C (with a Makefile)
- C++ (using CUDA runtime)
- Go
- Python
- Rust

Feel free to add your own templates and commit them to the repo.
