#!/bin/bash

# readonly TEMPLATE_DIR=/var/nift/templates
readonly TEMPLATE_DIR=~/Repos/nift/templates
VERBOSE=0
PROJECT_NAME=""
PROJECT_DIR=""
EXIT_MENUS=false

log() {
    if [ "$VERBOSE" -eq 1 ]; then
        echo "$@"
    fi
}

usage() {
    echo "Usage: $0 <project name> [-v]" >&2
    return 0
}

parse_args() {
    
    PROJECT_NAME=$1
    PROJECT_DIR="$PWD/${PROJECT_NAME}"

    shift 
    while getopts ":v" opt; do
        case $opt in
            v) VERBOSE=1 ;;
            \?) usage ;;
        esac
    done
}

validate_input() {
    [ -z "$PROJECT_NAME" ] && usage &&  exit 1
    [ ! -d "$TEMPLATE_DIR" ] && echo "Template directory not found: $TEMPLATE_DIR" >&2 && exit 2
    [ -d "$PROJECT_NAME" ] && echo "Project directory already exists: $PROJECT_DIR" >&2 && exit 3
}

display_tree() {
    local dir="$1"
    local indent="$2"

    for entry in "$dir"/*; do
        if [ -e "$entry" ]; then
            
            if [ -d "$entry" ]; then
                echo -e "$indent├──" "$(basename "$entry")/"
                display_tree "$entry" "    $indent"
            else
                echo -e "$indent├──" "$(basename "$entry")"
            fi
        fi
    done
}

secondary_menu() {
    template=$1
    while true; do
        clear
        echo "Choose an option:"
        echo "1) Use the template"
        echo "2) Show template description"
        echo "3) Show template technologies"
        echo "4) Show template structure"
        echo "5) Select a different template"

        read -p "" choice

        case $choice in
            "1")
                EXIT_MENUS=true;
                return;
                ;;
            "2")
                echo "not implemented yet"
                echo "Press any key to continue..."
                read -n 1 -s
                ;;
            "3")
                echo "not implemented yet"
                echo "Press any key to continue..."
                read -n 1 -s
                ;;
            "4")
                echo "TEMPLATE STRUCTURE"
                echo "$template/"
                display_tree "$template" ""
                echo "Press any key to continue..."
                read -n 1 -s
                ;;
            "5")
                return
                ;;  
            *) echo "Other"
                echo "Press any key to continue..."
                read -n 1 -s
                ;;          
        esac
        echo ""
    done
}

main_menu() {
    
    while true; do
        clear
        echo "Select a template:"
        
        
        select x in *; do
            template="$x"
            case $template in
                "Quit")
                    echo "Exiting..."
                    exit 0
                    ;;
                "")
                    echo "Invalid choice. Please select a valid template."
                    ;;
                *)
                    echo "You selected $template"
                    secondary_menu "$template"
                    break
                    ;;
            esac
        done

        if $EXIT_MENUS; then
            return
        fi

    done
}

copy_and_process_template() {
    # Copy template to project folder
    # cd $cur

    cp -R "${TEMPLATE_DIR}/${PROJECT_TYPE}/$template/." $1

    cd $1
    echo "12"

    # processdirectory "."
    echo "13"

}

menu_option() {
    if [ "$VERBOSE" -eq 1 ]; then
        main_menu
    else
        # Select template without verbose options
        select x in *; do
            template="$x"
            break
        done
    fi
}



# Function for text substitution in files
processfile() {
    local file=$1
    new=$(sed "s,test,$PROJECT_NAME,g" <<< "$file")

    if [ "$file" = "$new" ]; then
        sed "s,test,$PROJECT_NAME,g" < $file > temp
        mv -f temp $file
    else
        sed "s,test,$PROJECT_NAME,g" < $file > $new
        if [ -e "$new" ]; then
            rm -f $file
        fi
    fi
}

# Function for text substitution in directories
processdirectory() {
    local dir=$1
    curDir="$PWD"

    echo "Error:1"

    if [ ! -d "$dir" ]; then
        echo "Directory $dir does not exist"
        exit 1
    fi

    for file in "$dir"/*; do
        echo "Error:2"
        if [ -f "./$file" ]; then
            echo "Error:3"
            processfile $file
            echo "Error:4"
        elif [ -d "./$file" ]; then
            echo "Error:5"
            base_dir=$(basename "$file")
            echo "Error:6"

            # Text substitution in the directory name
            if [[ "$base_dir" == *"test"* ]]; then
                echo "Error:7"
                new_dir_name="${base_dir//test/$PROJECT_NAME}"
                echo "Error:8"
                mv "$file" "$new_dir_name"
                echo "Error:9"
                file=$new_dir_name
                echo "Error:10"
            fi
            echo "Error:11"

            # Process all files in subdirectory if it is not empty
            if ! [ -z "$(ls -A "$file")" ]; then
                echo "Error:12"
                processdirectory "$file"
                echo "Error:13"
            fi
        else
            echo "$file is neither a file or a directory - please add as an issue on GitHub if this type should be supported."
        fi
    done
}




check_exists_or_install_package() {
    local pkgName=$1

    if ! dpkg -s $pkgName &>/dev/null; then
        echo "$pkgName is not installed! Install? (y/n)";
        read -r REPLY
        if [[ "$REPLY" =~ ^[Yy]$ ]]; then
            sudo apt-get install -y "$pkgName"
        fi
    fi
}

check_dependencies() {
    log "Checking depencies..."
    check_exists_or_install_package "git"
    check_exists_or_install_package "gh"
}

initialise_git() {

    git init -b main &>/dev/null
    if [ $? -ne 0 ]; then
        echo "Error: Failed to initialize git repository." >&2
        exit 1
    fi

    git add . &>/dev/null
    if [ $? -ne 0 ]; then
        echo "Error: Failed to add files to git repository." >&2
        exit 1
    fi

    git commit -m "Initial commit from nift template" --quiet &>/dev/null
    if [ $? -ne 0 ]; then
        echo "Error: Failed to commit changes to git repository." >&2
        exit 1
    fi

    echo "✓ Git repository initialized and initial commit created."
}



create_github_repo() {
    echo "Make respository public? (y/n)";
    read -r REPLY

    if [[ "$REPLY" =~ ^[Yy]$ ]]; then
        gh repo create "$PROJECT_NAME" --public --source=. --remote=upstream --push &>/dev/null
    else
        gh repo create "$PROJECT_NAME" --private --source=. --remote=upstream --push &>/dev/null
    fi

    if [ $? -ne 0 ]; then
        echo "Error: Failed to create GitHub repository." >&2
        exit 1
    fi

    echo "GitHub repository created and pushed."
}

project_type() {
    echo "Choose a project type:"
    select x in "Full Stack" *; do
        PROJECT_TYPE="$x"
        break
    done
}

main() {
    check_dependencies
    parse_args "$@"
    validate_input
    cur="$PWD"
    cd $TEMPLATE_DIR
    project_type
    
    echo "$PWD"
    if [ "$PROJECT_TYPE" = "Full Stack" ]; then
        PROJECT_TYPE="Frontend"
        mkdir -p $PROJECT_DIR/frontend
        cd $TEMPLATE_DIR/Frontend
        echo "1"
        menu_option
        echo "2"
        cd $cur
        echo "3"
        copy_and_process_template "$PROJECT_DIR/frontend"
        echo "4"


        PROJECT_TYPE="Backend"
        echo "5"
        mkdir -p $PROJECT_DIR/backend
        echo "6"
        cd $TEMPLATE_DIR/Backend
        echo "7"
        menu_option
        echo "8"
        cd $cur
        echo "9"
        copy_and_process_template $PROJECT_DIR/backend
        echo "10"
    else
        cd $PROJECT_TYPE
        echo "$CWD"
        menu_option
        cd $cur
        copy_and_process_template $PROJECT_DIR
    fi

    # menu_option
    # cd $cur
    # copy_and_process_template
    initialise_git
    create_github_repo
    echo "Created new project using $template template. Pretty nifty."
}


main "$@"