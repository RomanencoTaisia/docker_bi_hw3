#!/bin/bash
COMMAND=$1

if [[ "$OSTYPE" == "msys"* || "$OSTYPE" == "cygwin"* ]]; then
  PROJECT_DIR=$(pwd -W)
  DOCKER_RUN="MSYS_NO_PATHCONV=1 docker run"
else
  PROJECT_DIR=$(pwd)
  DOCKER_RUN="docker run"
fi

case "$COMMAND" in
  build_generator)
    docker build -t hw3-generator ./generator
    ;;

  run_generator)
    mkdir -p data
    eval $DOCKER_RUN --rm -v "\"$PROJECT_DIR/data:/data\"" hw3-generator
    ;;

  create_local_data)
    mkdir -p local_data
    python generator/generate.py local_data
    ;;

  build_reporter)
    docker build -t hw3-reporter ./reporter
    ;;

  run_reporter)
    mkdir -p data
    eval $DOCKER_RUN --rm -v "\"$PROJECT_DIR/data:/data\"" hw3-reporter
    ;;
  structure)
    find . -not -path "./.git/*" -print | sort
    ;;

  clear_data)
    mkdir -p data
    rm -f data/*.csv data/*.html
    ;;

  inside_generator)
    mkdir -p data
    eval $DOCKER_RUN --rm -v "\"$PROJECT_DIR/data:/data\"" --entrypoint sh hw3-generator -c "\"ls -la /data\""
    ;;

  inside_reporter)
    mkdir -p data
    MSYS_NO_PATHCONV=1 docker run --rm -v "$PROJECT_DIR/data:/data" hw3-reporter sh -c "ls -la /data"
    ;;
  *)
    echo "Unknown command: $COMMAND"
    echo "Available commands:"
    echo "  build_generator"
    echo "  run_generator"
    echo "  create_local_data"
    echo "  build_reporter"
    echo "  run_reporter"
    echo "  structure"
    echo "  clear_data"
    echo "  inside_generator"
    echo "  inside_reporter"
    ;;
esac