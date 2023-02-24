#!/usr/bin/sh
TCTL=$(printf "%.0f" $(sensors -j k10temp-pci-00c3 | jq '."k10temp-pci-00c3"."Tctl"."temp1_input"'))
echo "$TCTL °C"
