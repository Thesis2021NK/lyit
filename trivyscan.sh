#!/bin/bash

dockerImageName=$(awk 'NR==11 {print $2}' Dockerfile)
echo $dockerImageName

trivy -q image --exit-code 0 --severity HIGH --light $dockerImageName
trivy -q image --exit-code 1 --severity CRITICAL --light $dockerImageName

    exit_code=$?
    echo "Exit Code : $exit_code"

    if [[ "$exit_code" == 1 ]]; then
        echo "Image scanning failed. Vulnerabilities found."
        exit 1;
    else
        echo "Image scanning passed."
    fi;