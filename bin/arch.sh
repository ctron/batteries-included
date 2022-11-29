#!/usr/bin/env bash

set -e

function variant1() {
  uname -m
}

function variant2() {

  case "$(uname -m)" in
    "x86_64")
      echo "amd64"
      ;;
    "aarch64")
      echo "arm64"
      ;;
    *)
      echo "Unsupported platform ($(uname -m))"
      exit 1
      ;;
  esac

}

case "$1" in
  "-1")
    variant1
    ;;
  "-2")
    variant2
    ;;
  *)
    echo "Unknown variant ($1)"
    exit 1
    ;;
esac
