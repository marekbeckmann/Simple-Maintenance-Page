#!/bin/bash
functionuserinput() {

    numVal='^[1-2]+$'
    read -r -p "Company Name: " name
    read -r -p "E-Mail: " email
    read -r -p "Design Choice (1/2): " design
    if ! [[ $design =~ $numVal ]]; then
        design=1
    fi

}

functionmakepage() {

    mkdir -p yourproduct
    mkdir -p yourproduct/assets
    cp index.html yourproduct/index.html
    cp -ar assets/* yourproduct/assets/
    sed -i -E "s/\[email\]/$email/g" yourproduct/index.html
    sed -i -E "s/\[Company\]/$name/g" yourproduct/index.html
    if [[ $design = 2 ]]; then
        sed -i '/\[alt-bg\]/d' yourproduct/assets/css/style.css
    fi

}

if [[ -f "index.html" ]] && [[ -f "assets/css/style.css" ]]; then
    functionuserinput
    if [[ -d yourproduct/ ]]; then
        read -r -p "There is an existing project! Continue anyway? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
        functionmakepage
    else
        functionmakepage
    fi
else
    echo "Please make sure, that \"index.html\" and \"assets/style.css\" are in place"
fi
