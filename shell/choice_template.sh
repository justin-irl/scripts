#!/bin/bash

# request repo name from user
repo_name () {
  echo "Enter the name of a repo:"
  read -r -p ">>>" REPO
  echo "Your repo is $REPO"
}

# request default branch for the repo
branch_check () {
  echo "Enter the default branch for $REPO:"
    cat << EOF
    1. main
    2. develop
    3. manual input option
EOF
  read -r -p ">>> " BRANCH
  if [ "$BRANCH" == "1" ]; then
    BRANCH="main"
  elif [ "$BRANCH" == "2" ]; then
    BRANCH="develop"
  else
    echo "Enter the branch name:"
    read -r -p ">>> " BRANCH
  fi
  echo "Your branch is $BRANCH"
}

# check directory available
check_dir () {
  if [ -d "$REPO" ]; then
    echo "Directory $REPO already exists"
    echo "Do you want to overwrite it?"
    read -r -p ">>> " OVERWRITE
    if [ "$OVERWRITE" == "y" ]; then
      rm -rf "$REPO"
      echo "Directory $REPO has been deleted"
      echo "Creating directory $REPO"
      mkdir "$REPO"
      echo "Directory $REPO has been created"
    else
      echo "Exiting..."
      exit 1
    fi
  else
    echo "Creating directory $REPO"
    mkdir "$REPO"
    echo "Directory $REPO has been created"
  fi
}

# create standard repo directories and suppress error output for existing directories
create_dir () {
  mkdir -p "$REPO/{.git,src,test,docs,bin,etc}" 2>/dev/null
}

# confirm continue with repo creation
confirm_continue () {
  echo "Do you want to continue?"
  read -r -p ">>> " CONTINUE
  if [ "$CONTINUE" == "y" ]; then
    echo "Continuing..."
  else
    echo "Exiting..."
    exit 1
  fi
}