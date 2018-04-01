#!/bin/bash

BASEQ3_DIR="C:/Program Files (x86)/Steam/steamapps/common/Quake Live/76561198161852807/baseq3"
PLAYER_NAME="Taylor Thrift"
tail -f -n 0 "${BASEQ3_DIR}/qconsole.log"  | ./ql-parser.pl --dir "${BASEQ3_DIR}" --name "${PLAYER_NAME}"
