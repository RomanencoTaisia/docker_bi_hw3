#!/bin/bash
COMMAND=$1
case "$COMMAND" in
  build_generator)
    docker build -t hw3-generator ./generator
    ;;

  run_generator)
    mkdir -p data
    docker run --rm -v "$(pwd)/data:/data" hw3-generator
    ;;

  create_local_data)
    mkdir -p local_data
    python generator/generate.py local_data
    ;;

  *)
    echo "Unknown command: $COMMAND"
    echo "Available commands:"
    echo "  build_generator"
    echo "  run_generator"
    echo "  create_local_data"
    ;;
esac