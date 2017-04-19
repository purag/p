#!/bin/bash

exe=
if [[ $(which p) = *"/.p/p" ]]; then
  exe="p"
else
  exe=$0
fi

# Helpers
usage () {
  if [ "$1" = "--long" ]; then
    echo "Long usage coming soon!"
    usage
  else
    echo "usage: $exe [<project>] [help|h] [<command> [<args>]]"
    echo ""
    echo "  Create and manage personal projects."
    echo "    $exe in a project directory will output project details."
    echo "    $exe <project> will switch to the directory for <project>."
    echo ""
    echo "Available commands (and shorthands):"
    echo "  archive, ar     Archive an active project"
    echo "  copy, cp        Copy an existing project"
    echo "  dump, d         Dump active project configuration to stdout"
    echo "  go, g           Go to a project directory by its name"
    echo "  list, ls        List your projects"
    echo "  start, s        Start a new project"
    echo "  todo, t         Add and modify project TODOs"
    echo ""
    echo "  help, h         Show all commands, or get more help on one"
    echo ""
  fi
}

failwith () {
  echo $1
  usage
  exit 1
}

# Print short usage if no arguments were provided
if [ $# -lt 1 ]; then
  usage
  exit 0
fi

# Actually parse the command...
case $1 in
  "help" | "h" )
    [ $# -lt 2 ] && usage --long && exit 0

    case $2 in
      "start" | "s" )
        echo "usage: $exe start <name> [<args>]"
        echo ""
        echo "Arguments:"
        echo "  --with t1[,t2...]    Run the specified initializers after creating the project"
        echo "   -w t1[,t2...]         Available by default: git, npm"
        echo "  --at <dir>           Path to the directory where the project will live"
        echo "   -a <dir>              Default: ~/projects/<name>"
        echo "  --bare, -b           Initialize the project with just a name (p won't ask for any"
        echo "                         other details)"
        echo "  --cd                 cd into the project directory after creation"
        echo "  --then <file>        Path to a custom script that will automatically be executed in"
        echo "                         the project directory after creation"
        ;;

      "copy" | "cp" )
        echo "usage: $exe copy <nameToCopy> [<newName>] [<args>]"
        echo ""
        echo "Arguments:"
        echo "  <newname>            The name for the new project"
        ;;

      *)
        failwith "unknown command: $2"
    esac
    ;;

  *)
    failwith "unknown command: $1"
    ;;
esac
