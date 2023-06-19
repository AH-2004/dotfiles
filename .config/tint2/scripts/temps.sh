#!/usr/bin/sh
core_0=$(printf "%.0f" $(sensors -j coretemp-isa-0000 | jq '."coretemp-isa-0000"."Core 0"."temp2_input"'))
core_1=$(printf "%.0f" $(sensors -j coretemp-isa-0000 | jq '."coretemp-isa-0000"."Core 1"."temp3_input"'))
echo "$core_0 °C  $core_1 °C"
