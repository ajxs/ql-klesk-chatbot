#!/bin/bash

# main program args, edit these.
BASEQ3_DIR="C:/Program Files (x86)/Steam/steamapps/common/Quake Live/76561198827372787/baseq3"
PLAYER_NAME="Klesk"

# Ensure existence of target files.
KLESK_CFG_TARGET="${BASEQ3_DIR}/klesk.cfg"
[ -f "${KLESK_CFG_TARGET}" ] || cp "./klesk.cfg" "${KLESK_CFG_TARGET}"
touch "${BASEQ3_DIR}/klesk-insult.cfg"
touch "${BASEQ3_DIR}/klesk-insult-talker.cfg"
touch "${BASEQ3_DIR}/klesk-praise.cfg"
touch "${BASEQ3_DIR}/klesk-taunt.cfg"

tail -f -n 0 "${BASEQ3_DIR}/qconsole.log"  | ./klesk.pl --dir "${BASEQ3_DIR}" --name "${PLAYER_NAME}"
