<div align="center">
    <picture>
      <img alt="Nift logo" src="https://raw.githubusercontent.com/Archii0/nift/main/assets/niftlogo.png" height="60"/>
    </picture>
<br><br>


<a href="https://github.com/Archii0/nift/stargazers">
<img alt="NPM version" src="https://img.shields.io/github/stars/Archii0/nift?style=for-the-badge&labelColor=000000"/>
</a>
<a href="https://github.com/Archii0/nift/network/members">
<img src="https://img.shields.io/github/forks/Archii0/nift?style=for-the-badge&labelColor=000000"/>
</a>
<a href="https://github.com/Archii0/nift/commits/main">
<img src="https://img.shields.io/github/last-commit/Archii0/nift?style=for-the-badge&labelColor=000000"/>
</a>
<a href="https://github.com/Archii0/nift/blob/main/LICENSE">
<img src="https://img.shields.io/github/license/Archii0/nift?style=for-the-badge&labelColor=000000"/>
</a>
</div>

# Nift

**Nift** is a **minimal build system** designed for quickly **bootstrapping projects** on **Linux**. 

It's useful for **full-stack hackathon projects and personal projects**, enabling you to quickly generate **reusable templates** with common file structures and configurations, so you can start coding right away.


---

## Features
- **Quick Project Setup**: Use templates to generate boilerplate code and directory structures.
- **Fullstack Generation**: Quickly create connected front and backends.
- **Customizable Templates**: Create and manage templates tailored to your workflow.
- **Verbose Mode**: View directory structures and manage templates via an intuitive CLI menu.


---

## Built-in Templates
Nift includes some standard project templates.
### Frontend
- **Next.js (React)**
### Backend
- **Django (python)**
- **Flask (python)**
### Languages
- **C++**: A C++ project with Google Test and Doxygen, built with CMake.
- **Python (Script)**: A Python CLI project using `click`, virtual environment, dependency management, argument parsing, packaging, and a README.

Feel free to enhance these templates or add your own to the repository.


---



## Installation

### 1. Clone the Repository
```bash
git clone https://github.com/Archii0/nift.git
cd nift
```

### 2. Deploy Nift
Run the deployment script to set up Nift:
```bash
sudo ./deploy.sh
```
This will:
- Move the `/templates` directory to `/var/nift`.
- Place the Nift script in `/usr/bin/`, making it globally accessible.

---

## Usage

### Generating a Project
To generate a project using a template, run:
```bash
nift <project-name>
```
Nift will:
1. Create a new directory named `<project-name>`.
2. Copy the chosen template files into the directory.
3. Replace placeholders (e.g., `PROJECTNAME`) in filenames and file content with the specified `<project-name>`.

### Verbose Mode
Enable verbose mode for additional functionality:
```bash
nift <project-name> [-v|--verbose]
```
In verbose mode, you can:
- Browse available templates via a CLI menu.
- View directory structures of templates, such as:
  ```
  C++/
  ├── CMakeLists.txt
  ├── lib/
  ├── Makefile
  ├── src/
      ├── CMakeLists.txt
      ├── main.cpp
  ├── tests/
      ├── CMakeLists.txt
      ├── main.cpp
  ```

---

## Creating Custom Templates

### 1. Undeploy Nift
Before modifying templates, undeploy Nift:
```bash
sudo ./undeploy.sh
```
This removes Nift's deployed files, allowing you to safely edit templates.

### 2. Add a Template
Create a new folder in the `/templates` directory to define your template. Use `PROJECTNAME` as a placeholder in filenames and file content for dynamic substitution.

#### Example: C Template
File: `PROJECTNAME.c`
```c
/* PROJECTNAME.c */

#include "PROJECTNAME.h"

int main(int argc, char *argv[]) {
    printf("Nifty.");
    return 0;
}
```
Templates are ideal for standardizing common project elements, such as:
- Main function stubs.
- Type definitions and imports.
- Build system files (e.g., Makefiles).
- Directory structures for larger projects.

#### Note on Empty Directories
Git does not track empty directories. To preserve them, you can:
- Add a placeholder file (e.g., `.gitkeep`).
- Automate directory creation in your build scripts.

### 3. Redeploy Nift
Once your templates are ready, redeploy:
```bash
sudo ./deploy.sh
```


---

## Contribution
Contributions are welcome! Submit a pull request to:
- Add new templates.
- Improve existing templates.
- Enhance Nift's functionality.

---

## License
This project is licensed under the [MIT License](LICENSE).

---

## Support
If you encounter issues or have questions, open an issue on the [GitHub repository](https://github.com/Archii0/nift/issues).

