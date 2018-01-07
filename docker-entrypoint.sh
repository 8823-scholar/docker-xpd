#!/usr/bin/env bash

_init_datafiles() {
  echo "Initializing data files..."
  XPd -printtoconsole | while read i
  do
    echo $i | grep -q 'ThreadDNSAddressSeed exited'
    if [ $? = "0" ]; then
      kill -TERM $(pidof XPd)
      break
    fi
  done
  echo "done"
}

_rewrite_xp_conf() {
  echo "Rewriting XP.conf files..."

  sed -i -e '/^rpcpassword/d' ${XPD_DATA_DIR}/XP.conf
  echo "" >> ${XPD_DATA_DIR}/XP.conf
  echo "rpcpassword=${XPD_RPC_PASSWORD}" >> ${XPD_DATA_DIR}/XP.conf

  sed -i -e '/^rpcallowip/d' ${XPD_DATA_DIR}/XP.conf
  echo "rpcallowip=${XPD_RPC_ALLOW_IP}" >> ${XPD_DATA_DIR}/XP.conf

  sed -i -e '/^server/d' ${XPD_DATA_DIR}/XP.conf
  echo "server=1" >> ${XPD_DATA_DIR}/XP.conf

  sed -i -e '/^testnet/d' ${XPD_DATA_DIR}/XP.conf
  echo "testnet=${XPD_TESTNET}" >> ${XPD_DATA_DIR}/XP.conf

  echo "done"
}

if [ ! -d ${XPD_DATA_DIR}/database ]; then
  _init_datafiles
  _rewrite_xp_conf
fi

echo "On starting XPd, it may take over 10 minutes or more. Please wait patiently."
exec "$@"
