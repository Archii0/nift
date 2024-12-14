#!/bin/bash

usage() {
    >&2 echo "Usage: $0 <project name>"
    return 0
}

pname=$1
pdir="./${pname}"
tdir=/var/nift/templates

# error handling for correct usage
if [ -z "$pname" ]; then
    usage
    exit 1
elif ! [ -d "$tdir" ]; then
    >&2 echo "Unable to find template directory: $tdir"
exit 2
elif [ -d "$pname" ]; then
    >&2 echo "Project directory already exists: $pdir"
    exit 3
fi

cur="$PWD"
cd $tdir

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

exit_menus=false

secondary_menu() {
    template=$1
    while true; do
        echo "Choose an option:"
        echo "1) Use the template"
        echo "2) Show template description"
        echo "3) Show template technologies"
        echo "4) Show template structure"
        echo "5) Select a different template"

        read -p "" choice

        case $choice in
            "1")
                exit_menus=true;
                return;
                ;;
            "2")
                ;;
            "3")
                ;;
            "4")
                echo "TEMPLATE STRUCTURE"
                echo "$template/"
                display_tree "$template" ""
                ;;
            "5")
                return
                ;;  
            *) echo "Other"
                ;;          
        esac
        echo ""
    done
}

ain_menu() {
    
    while true; do
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

        if $exit_menus; then
            return
        fi

    done
}

main_menu

# copy template to project folder
cd $cur
cp -R ${tdir}/$template $pdir
cd $pdir

# function for text substitution in files
processfile() {
    local file=$1
    new=$(sed "s,PROJECTNAME,$pname,g" <<< "$file")

    if [ "$file" = "$new" ]; then
        sed "s,PROJECTNAME,$pname,g" < $file > temp
        mv -f temp $file
    else
        sed "s,PROJECTNAME,$pname,g" < $file > $new
        if [ -e "$new" ]; then
            rm -f $file
        fi
    fi
}

# function for text substitution in directories
processdirectory() {
    local dir=$1
    curDir="$PWD"

    # 
    if [ ! -d "$dir" ]; then
        echo "Directory $dir does not exist"
        exit 1
    fi

    for file in "$dir"/*; do
        if [ -f "./$file" ]; then
            processfile $file
        elif [ -d "./$file" ]; then
            base_dir=$(basename "$file")

            # text substitution in the directory name
            if [[ "$base_dir" == *"PROJECTNAME"* ]]; then
                new_dir_name="${base_dir//PROJECTNAME/$pname}"
                mv "$file" "$new_dir_name"
                file=$new_dir_name
            fi

            # process all files in subdirectory if it is not empty
            if ! [ -z "$(ls -A "$file")" ]; then
                processdirectory $file
            fi
        else
            echo "$file is neither a file or a directory - please add as an issue on GitHub if this type should be supported."
        fi
    done
}

processdirectory "."

echo "Created new project using $template. Pretty nifty."