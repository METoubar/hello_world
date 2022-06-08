#!/bin/bash

ns=${{ github.event.inputs.name }}
size=${#ns}

if (( ${{ github.event.inputs.name }} == *['!'@#\$%^\&*()_+ ]* && $size -lt 16 )); then
    echo "make sure that your environment name does not contain special chars ['!'@#\$%^\&*()_+] and less than 16 character"
    echo "::set-output name=env_checks::false"
# elif (( $(kubectl get ns | grep -i ${{ github.event.inputs.team }}-${{ github.event.inputs.name }}) )); then
#     echo "This environment already exist, please make sure to delete it, or use another name"
#     echo "::set-output name=env_checks::false"
# elif ! (( $(kubectl get ns --no-header | grep -i ${{ github.event.inputs.team }} | wc -l) -lt 5 )); then
#     echo "::set-output name=env_checks::false"
#     echo "You exceeded the max limit of environments"
else
    echo "::set-output name=env_checks::false"
fi
