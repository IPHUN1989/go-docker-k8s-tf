#!/bin/bash

print_usage() {
    echo "Usage: $0 [--aws | --minikube]"
    echo "Minikube requires sudo privileges"
    exit 1
}

apply_terraform() {
    echo "yes" | terraform apply    
}

if [ "$#" -ne 1 ]; then
    print_usage
fi

if [ "$1" == "--aws" ]; then
    if [ -f ./awsprovider.txt ]; then
        cat ./awsprovider.txt > providers.tf
        apply_terraform
    else
        echo "File ./awsprovider.txt does not exist"
        exit 1
    fi
elif [ "$1" == "--minikube" ]; then

    if ! minikube status > /dev/null 2>&1 ; then
        echo "Minikube is not running. Exiting"
        exit 1
    fi

    if [ -f ./minikubeprovider.txt ]; then
        cat ./minikubeprovider.txt > providers.tf
        apply_terraform
        minikube tunnel
    else
        echo "File ./minikubeprovider.txt does not exist"
        exit 1
    fi
else
    print_usage
fi