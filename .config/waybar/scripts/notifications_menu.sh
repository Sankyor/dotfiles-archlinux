#!/bin/bash

# Lista: "ID - Título"
choice="$(
  makoctl history |
  sed -n 's/^Notification \([0-9]\+\): \(.*\)$/\1 - \2/p' |
  wofi --dmenu --style ~/.config/wofi/style.css --prompt "🔔 Historial"
)"

# Si cancelas, salir
[ -z "$choice" ] && exit 0

# Extraer ID (todo lo antes del primer espacio)
id="${choice%% *}"

# Menú de acciones
action="$(
  printf "Restaurar\nBorrar\nBorrar todo\n" |
  wofi --dmenu --style ~/.config/wofi/style.css --prompt "Acción (ID $id)"
)"

case "$action" in
  "Restaurar")
    # Opción simple: restore del último expirado (mako no siempre permite restore por ID)
    makoctl restore
    ;;
  "Borrar")
    makoctl dismiss -n "$id"
    ;;
  "Borrar todo")
    makoctl dismiss --all
    ;;
  *)
    exit 0
    ;;
esac
