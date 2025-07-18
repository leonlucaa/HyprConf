#!/bin/bash

# Verifica o status do MPD
STATUS=$(mpc status | grep "\[playing\]" | wc -l) # 1 se tocando, 0 se pausado/parado

if [ "$STATUS" -eq 1 ]; then
    # MPD está tocando: mostra o ícone de pausa
    echo "{\"text\":\"⏸\", \"tooltip\":\"Pausar\"}"
else
    # MPD está pausado ou parado: mostra o ícone de play
    echo "{\"text\":\"▶\", \"tooltip\":\"Tocar\"}"
fi
