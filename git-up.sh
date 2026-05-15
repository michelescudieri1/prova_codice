#!/bin/bash

# Recupera il nome del branch corrente
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)

# Se viene passato un argomento, usalo come messaggio di commit
# Altrimenti chiedi all'utente di inserirlo
if [ -z "$1" ]; then
    echo "📝 Inserisci il messaggio del commit:"
    read COMMIT_MSG
else
    COMMIT_MSG="$1"
fi

# Se il messaggio è ancora vuoto, usa un default
if [ -z "$COMMIT_MSG" ]; then
    COMMIT_MSG="Aggiornamento automatico: $(date +'%Y-%m-%d %H:%M:%S')"
fi

echo "🚀 Inizio procedura di aggiornamento su branch: $CURRENT_BRANCH..."

# 1. Aggiunge tutte le modifiche
git add .

# 2. Crea il commit
git commit -m "$COMMIT_MSG"

# 3. Effettua il push sul branch corrente
git push origin "$CURRENT_BRANCH"

if [ $? -eq 0 ]; then
    echo "✅ Successo! Modifiche caricate su GitHub."
else
    echo "❌ Errore durante il push. Controlla la connessione o il token."
fi
