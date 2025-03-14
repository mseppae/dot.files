#!/bin/bash

function safe_symbolic_link {
  if [[ -z $1 ]]; then
    echo "source file not provided"
    exit 1
  fi
  
  if [[ -z $2 ]]; then
    echo "target file not provided"
    exit 1
  fi
  
  if [[ -f $2 ]]; then
    echo "File $2 exists, skipping..."
  else
    echo "Linking file $1 to $2"
    ln -s $1 $2
  fi
}

function create_directory {
  if [[ -z $1 ]]; then
    echo "directory name not provided"
    exit 1
  fi
  
  if [[ ! -d $1 ]]; then
    echo "Creating directory $1"
    mkdir -p $1
  fi
}

function symlink_pattern {
  if [[ -z $1 ]]; then
    echo "no source pattern provided"
    exit 1
  fi
  
  if [[ -z $2 ]]; then
    echo "no target location provided"
    exit 1
  fi

  target_directory=$2
  
  for filename in $1; do
    if [[ -z $filename ]]; then
      continue
    fi
    basename="$(basename $filename)"

    safe_symbolic_link $filename ${target_directory}/$basename
  done
}

