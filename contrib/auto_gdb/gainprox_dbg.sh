#!/bin/bash
# use testnet settings,  if you need mainnet,  use ~/.gainproxcore/gainproxd.pid file instead
gainprox_pid=$(<~/.gainproxcore/testnet3/gainproxd.pid)
sudo gdb -batch -ex "source debug.gdb" gainproxd ${gainprox_pid}
