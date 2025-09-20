#!/bin/sh


if [ "$(uname)" == "Darwin" ]; then
  SED=gsed
else
  SED=sed
fi
SED=gsed

cp evaluation.yml evaluation-namespace.yml
${SED} -e 's/Evaluation/Evaluation (Namespace)/' -i evaluation-namespace.yml
${SED} -e 's/ubuntu-latest/namespace-profile-default/' -i evaluation-namespace.yml
