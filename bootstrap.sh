#!/usr/bin/env bash

# Script copied from here:
# https://codereview.stackexchange.com/questions/181950/follow-up-script-to-create-symlinks-for-dotfiles-in-a-git-repository

RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
RESET=$(tput sgr0)

is_symlink_dest_equal_to() { test "$(readlink $1)" == "$2"; }
can_create_dir() { mkdir -p "$1"; }
is_directory() { test -d "$1"; }
file_exists() { test -e "$1"; }
is_symlink() { test -L "$1"; }

create_symlink() {
  file_loc="$1"
  symlink_loc="$2"

  ln -s "$file_loc" "$symlink_loc"
  echo "Created a symlink $symlink_loc -> $file_loc"
  return 0
}

invalid_file_error() {
  file_loc="$1"
  symlink_loc="$2"

  echo "${RED}WARNING${RESET}: Failed to link $symlink_loc to $file_loc"
  echo "${RED}         ${RESET}$file_loc does not exist"
  return 1
}

handle_non_existing_symlink_directory() {
  file_loc="$1"
  symlink_loc="$2"
  symlink_dir=$(dirname "$symlink_loc")

  if ! can_create_dir "$symlink_dir" ; then
    echo "${RED}WARNING${RESET}: Failed to link $symlink_loc to $file_loc"
    echo "${RED}         ${RESET}Could not create folder $symlink_dir/"
    return 1
  else
    create_symlink "$file_loc" "$symlink_loc"
  fi
}

handle_wrong_existing_symlink() {
  file_loc="$1"
  symlink_loc="$2"
  current_dest=$(readlink "$symlink_loc")

  echo "It seems like $symlink_loc already is symlink to $current_dest."
  read -p "Do you want to replace it? [Y/N] " -n 1 -r
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    echo
    echo "Removing current symlink..."
    unlink "$symlink_loc"
    create_symlink "$file_loc" "$symlink_loc"
    return
  fi
}

handle_existing_symlink() {
  file_loc="$1"
  symlink_loc="$2"

  if is_symlink_dest_equal_to "$symlink_loc" "$file_loc" ; then
    echo "--> $symlink_loc -> $file_loc ${GREEN}exists${RESET}."
    return 0
  else
    handle_wrong_existing_symlink "$file_loc" "$symlink_loc"
  fi
}

handle_delete_previous_file() {
  file_loc="$1"
  symlink_loc="$2"

  printf "\\nDeleting %s...\\n" "$symlink_loc"
  rm -rf "$symlink_loc"
  create_symlink "$file_loc" "$symlink_loc"
}

handle_move_previous_file() {
  file_loc="$1"
  symlink_loc="$2"

  printf "\\nMoving %s to ~%s/.other..." "$symlink_loc" "$HOME"
  mkdir "$HOME/.other"
  mv "$symlink_loc" "$HOME/.other"
  create_symlink "$file_loc" "symlink_loc"
}

handle_existing_non_symlink() {
  file_loc="$1"
  symlink_loc="$2"

  echo "It seems like $symlink_loc already exists."
  read -p "Do you want to [d]elete, [m]ove (-> $HOME/.other/) or [k]eep $symlink_loc? " -n 1 -r
  if [[ $REPLY =~ ^[Dd]$ ]]
  then
    handle_delete_previous_file "$file_loc" "$symlink_loc"
  elif [[ $REPLY =~ ^[Mm]$ ]]; then
    handle_move_previous_file "$file_loc" "$symlink_loc"
  else
    printf "\\nKeeping %s...\\n" "$symlink_loc"
    return 0
  fi
}

handle_existing_file() {
  file_loc="$1"
  symlink_loc="$2"

  if is_symlink "$symlink_loc"; then
    handle_existing_symlink "$file_loc" "$symlink_loc"
  else
    handle_existing_non_symlink "$file_loc" "$symlink_loc"
  fi
}

custom_link() {
  file_loc="$1"
  symlink_loc="$2"

  if ! file_exists "$file_loc"; then
    invalid_file_error "$file_loc" "$symlink_loc"
  elif file_exists "$symlink_loc"; then
    handle_existing_file "$file_loc" "$symlink_loc"
  else
    symlink_dir=$(dirname "$symlink_loc")

    if ! is_directory "$symlink_loc"; then
      handle_non_existing_symlink_directory "$file_loc" "$symlink_loc"
    else
      create_symlink "$file_loc" "$symlink_loc"
    fi
  fi
}


dotfileDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd $dotfileDir

git pull origin master
git submodule init
git submodule update

custom_link "$dotfileDir/.tmux.conf" "$HOME/.tmux.conf"
custom_link "$dotfileDir/.tmux" "$HOME/.tmux"
custom_link "$dotfileDir/.gitconfig" "$HOME/.gitconfig"
custom_link "$dotfileDir/.gitignore_global" "$HOME/.gitignore_global"
custom_link "$dotfileDir/.vim" "$HOME/.vim"
custom_link "$dotfileDir/.vimrc" "$HOME/.vimrc"
custom_link "$dotfileDir/.zshrc" "$HOME/.zshrc"
custom_link "$dotfileDir/.zlogin" "$HOME/.zlogin"
custom_link "$dotfileDir/.zsh" "$HOME/.zsh"
