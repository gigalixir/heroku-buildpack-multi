#!/usr/bin/env bash

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source $SCRIPT_DIR/.test_support.sh




# TESTS
######################
suite "detect"


  test "missing .buildpacks file"

    source ${SCRIPT_DIR}/../bin/detect ${build_path}
    [ "${ECHO_CONTENT[@]}" == "no .buildpacks file" ]
    [ $failed == "true" ]


  test "empty .buildpacks file"

    touch ${build_path}/.buildpacks
    source ${SCRIPT_DIR}/../bin/detect ${build_path}
    [ "${ECHO_CONTENT[@]}" == ".buildpacks file is empty" ]
    [ $failed == "true" ]

  test ".buildpacks file"

    /bin/echo "https://github.com/gigalixir/gigalixir-elixir-buildpack" > ${build_path}/.buildpacks
    source ${SCRIPT_DIR}/../bin/detect ${build_path}
    [ "${ECHO_CONTENT[0]}" == ".buildpacks file detected" ]
    [ $failed == "false" ]

PASSED_ALL_TESTS=true
