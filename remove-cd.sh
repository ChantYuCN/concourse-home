#!/bin/bash

sudo kill -9  $(ps -aux | grep 8083 | awk '{print $2}' | head -n 1)
