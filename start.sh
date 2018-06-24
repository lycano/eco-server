#!/bin/bash

if [ ! -f Configs/WorldGenerator.eco ]; then
  echo "Copying default configs"
  mkdir -p Configs
  cp -varf DefaultConfigs/* Configs/
fi

if [ ! -f Storage/DefaultWorld ]; then
  echo "Copying default storage"
  mkdir -p Storage
  cp -varf DefaultStorage/* Storage/
fi

if [ -z "$(ls -A Mods/)" ]; then
  echo "Copying default mods"
  mkdir -p Mods
  cp -varf DefaultMods/* Mods/
fi

echo "$ECO_VESRION" > Configs/eco_version

MONO_GC_PARAMS=mode=throughput mono --gc=sgen EcoServer.exe -nogui
