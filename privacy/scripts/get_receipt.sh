#!/bin/sh -e

me=`basename "$0"`

txHash=""
orionPubKey=""
httpEndpoint=""
if [ $# != 4 ]
then
  echo "Unsupported flags, use -h|--help for complete usage"
  echo "Usage: ${me}"
  echo "    -txHash|--transactionHash : the transaction hash returned by executing a transaction"
  echo "    -httpEndpoint|--httpNodeEndpoint : the HTTP service endpoint of node"
  exit 0
fi

while [ $# -gt 0 ]; do
  case "$1" in
    -h|--help)
      echo "Usage: ${me}"
      echo "    -txHash|--transactionHash : the transaction hash returned by executing a transaction"
      echo "    -httpEndpoint|--httpNodeEndpoint : the HTTP service endpoint of node"
      exit 0
      ;;
    -txHash|--transactionHash)
      txHash="${2}"
      shift 2
      ;;
    -httpEndpoint|--httpNodeEndpoint)
      httpEndpoint="${2}"
      shift 2
      ;;
    --) # end argument parsing
      shift
      break
      ;;
    -*|--*=) # unsupported flags
      echo "Error: Unsupported flag $1, try ${me} -h or ${me} --help for complete usage help." >&2
      exit 1
      ;;
  esac
done

curl -X POST --data '{"jsonrpc":"2.0","method":"eea_getTransactionReceipt","params":["'${txHash}'"],"id":1}' ${httpEndpoint}