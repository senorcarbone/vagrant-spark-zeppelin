#!/usr/bin/env bash

echo "Cleaning up ..."
apt-get clean
rm -rf /var/lib/apt/lists/*

