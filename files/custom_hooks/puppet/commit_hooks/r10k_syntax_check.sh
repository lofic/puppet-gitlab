#!/bin/bash
#
# This script assumes you have installed r10k and will perform a syntax check on the Puppetfile if existing

echo "Performing a syntax check on the r10k Puppetfile:"
PUPPETFILE="$1"
echo "r10k puppetfile check $PUPPETFILE"
r10k puppetfile check "$PUPPETFILE"

if [[ $? -ne 0 ]]
then
    exit 1
fi
