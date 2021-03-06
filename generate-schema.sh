#!/bin/bash

#
# Copyright (c) 2021. Bernard Bou.
#
# -compat
# outdir
# indir
# files*: external sql template file names, if none they are taken from resources

source define_colors.sh
if [ "$1" == "-compat" ]; then
  compatswitch="-compat"
  shift
  echo -e "${Y}compat mode${Z}"
else
  compatswitch=
fi

if [ "$*" != "" ]; then
  outdir="$1"
  shift
  indir="$1"
  shift
  for sql in $*; do
    base=$(basename ${sql})
    java -ea -cp oewn-grind-wndb2sql.jar org.oewntk.sql.out.SchemaGenerator ${compatswitch} "${outdir}" "${indir}" "${sql}"
  done
else
  outdir="sql"
  for db in mysql sqlite; do
    for type in create index reference; do
      echo -e "${M}${db}/${type}${Z}"
      java -ea -cp oewn-grind-wndb2sql.jar org.oewntk.sql.out.SchemaGenerator ${compatswitch} "${outdir}/${db}/${type}" "${db}/${type}" $*
    done
  done
fi
