# Nift

Nift is a minimal build system for quick-starting projects on Linux.

## Usage
Clone the repo and create your own templates in the `/templates` directory. 

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
## Deployment

Once your templates are made, run `sudo ./deploy.sh`, which will move your templates directory to `/var/nift` and the script to run it to `/usr/bin/nift`.

Nift can now be ran with the command:
```bash
nift <project name>
```

This will copy your chosen templates to a new directory, with your project name substited into the template files and file names. 

## Standard Templates

The repo includes some generic dummy templates to start with, including:
- C (with a Makefile)
- C++ (using CUDA runtime)
- Go
- Python
- Rust
 
Feel free to add your own templates and commit them to the repo.
