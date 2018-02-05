#!/bin/bash -eu
# Copyright London Stock Exchange Group All Rights Reserved.
#
# SPDX-License-Identifier: Apache-2.0
#
# This script pulls docker images from the Dockerhub hyperledger repositories

# set the default Docker namespace and tag

set -ev

usage() { echo "Usage: $0 [-v|--version <fabric version>]" 1>&2; exit 0; }


DOCKER_NS=hyperledger
ARCH=x86_64
VERSION=1.1.0-preview
BASE_DOCKER_TAG=x86_64-0.4.2

# set of Hyperledger Fabric images
FABRIC_IMAGES=(fabric-peer fabric-orderer fabric-couchdb fabric-tools)

while (( "$#" )); do
  case "$1" in
    -v | --version)
      VERSION=$2
      shift 2
      ;;
    -h | --help )
      usage
      break;;
    --) # end argument parsing
      shift
      break
      ;;
    -*|--*=) # unsupported flags
      echo "Unsupported option $1"
      usage
      exit 1
      ;;
    # *) # preserve positional arguments
    #   PARAM="$PARAMS $1"
    #   shift
    #   ;;
  esac
done
# set positional arguments in their proper place
eval set -- "$PARAMS"

for image in ${FABRIC_IMAGES[@]}; do
  echo "Pulling ${DOCKER_NS}/$image:${ARCH}-${VERSION}"
  docker pull ${DOCKER_NS}/$image:${ARCH}-${VERSION}
done

echo "Pulling ${DOCKER_NS}/fabric-baseos:${BASE_DOCKER_TAG}"
docker pull ${DOCKER_NS}/fabric-baseos:${BASE_DOCKER_TAG}
