#!/bin/bash

count="$(makoctl history | grep -c '^Notification ')"

# Siempre mostrar icono (para que siempre sea clickeable)
echo "🔔 $count"
