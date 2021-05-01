#!/bin/bash
f_userinput() {

    numVal='^[1-2]+$'
    read -r -p "Company Name: " name
    read -r -p "E-Mail: " email
   
}

f_makepage() {

    mkdir -p yourproduct
    mkdir -p yourproduct/assets
    cp index.html yourproduct/maintenance.html
    cp -ar assets/* yourproduct/assets/
    sed -i -E "s/\[email\]/$email/g" yourproduct/maintenance.html
    sed -i -E "s/\[Company\]/$name/g" yourproduct/maintenance.html
    
}

if [[ -f "index.html" ]] && [[ -f "assets/css/style.css" ]]; then
    f_userinput
    if [[ -d yourproduct/ ]]; then
        read -r -p "There is an existing project! Continue anyway? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
        f_makepage
    else
        f_makepage
    fi
else
    echo "Please make sure, that \"index.html\" and \"assets/style.css\" are in place"
fi
