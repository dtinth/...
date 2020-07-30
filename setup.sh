#!/bin/bash -e

echo
echo '# Setup ~/my'
if ! [ -e ~/my ]
then
  git clone https://github.com/dtinth/my.git ~/my
  echo "  * ~/my is set up."
else
  echo "  * Already done."
fi