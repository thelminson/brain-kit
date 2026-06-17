#!/usr/bin/env bash
# brain-kit — instanciador. Rellena placeholders desde dominio.config.md y prepara el vault.
# Uso: bash setup.sh   (lee dominio.config.md; idempotente sobre los placeholders restantes)
set -euo pipefail

KIT_DIR="$(cd "$(dirname "$0")" && pwd)"
CFG="$KIT_DIR/dominio.config.md"
[ -f "$CFG" ] || { echo "✗ Falta dominio.config.md"; exit 1; }

# --- Lee KEY = VALUE del bloque de config (ignora comentarios tras '#') ---
getcfg() {
  grep -E "^[[:space:]]*$1[[:space:]]*=" "$CFG" | head -1 \
    | sed -E "s/^[^=]*=[[:space:]]*//; s/[[:space:]]*#.*$//; s/[[:space:]]*$//"
}

DOMINIO="$(getcfg DOMINIO)"
DOMINIO_ADJ="$(getcfg DOMINIO_ADJ)"
NIVEL="$(getcfg NIVEL)"
IDIOMA="$(getcfg IDIOMA)"
VAULT_PATH="$(getcfg VAULT_PATH)"
WEB_SEARCH="$(getcfg WEB_SEARCH)"
WEB_SEARCH_EXTRA="$(getcfg WEB_SEARCH_EXTRA)"
LLM_2A_OPINION="$(getcfg LLM_2A_OPINION)"
LATEX="$(getcfg LATEX)"
NOTIFY="$(getcfg NOTIFY)"
FECHA="$(date +%F)"

echo "brain-kit setup"
echo "  DOMINIO      = $DOMINIO"
echo "  IDIOMA       = $IDIOMA"
echo "  VAULT_PATH   = $VAULT_PATH"
echo "  herramientas = web:$WEB_SEARCH web+:$WEB_SEARCH_EXTRA 2aopinion:$LLM_2A_OPINION latex:$LATEX notify:$NOTIFY"
echo

[ -n "$VAULT_PATH" ] || { echo "✗ VAULT_PATH vacío en dominio.config.md"; exit 1; }

# --- 1) Copia el kit al VAULT_PATH (si es distinto de la carpeta del kit) ---
if [ "$VAULT_PATH" != "$KIT_DIR" ]; then
  mkdir -p "$VAULT_PATH"
  echo "→ Copiando estructura a $VAULT_PATH"
  # Copia .claude, docs, plantillas, índices semilla y carpetas del vault
  for d in .claude docs Plantillas Conceptos "Investigación" "Guías" Fuentes "Resultados de búsqueda" Agentes Skills; do
    cp -R "$KIT_DIR/$d" "$VAULT_PATH/" 2>/dev/null || true
  done
  cp "$KIT_DIR/dominio.config.md" "$VAULT_PATH/" 2>/dev/null || true
else
  echo "→ Instanciando in situ ($VAULT_PATH)"
fi

# --- 2) Sustituye placeholders en .claude, docs e índices semilla ---
echo "→ Rellenando placeholders…"
# sed -i compatible macOS/BSD y GNU
sedi() { if sed --version >/dev/null 2>&1; then sed -i "$@"; else sed -i '' "$@"; fi; }

replace_in() {
  # $1 = archivo
  sedi \
    -e "s|{{DOMINIO}}|$DOMINIO|g" \
    -e "s|{{DOMINIO_ADJ}}|$DOMINIO_ADJ|g" \
    -e "s|{{NIVEL}}|$NIVEL|g" \
    -e "s|{{IDIOMA}}|$IDIOMA|g" \
    -e "s|{{VAULT_PATH}}|$VAULT_PATH|g" \
    -e "s|{{WEB_SEARCH}}|$WEB_SEARCH|g" \
    -e "s|{{WEB_SEARCH_EXTRA}}|$WEB_SEARCH_EXTRA|g" \
    -e "s|{{LLM_2A_OPINION}}|$LLM_2A_OPINION|g" \
    -e "s|{{LATEX}}|$LATEX|g" \
    -e "s|{{NOTIFY}}|$NOTIFY|g" \
    -e "s|{{FECHA}}|$FECHA|g" \
    "$1"
}

find "$VAULT_PATH/.claude" "$VAULT_PATH/docs" "$VAULT_PATH/Plantillas" \
     "$VAULT_PATH/Agentes" "$VAULT_PATH/Skills" "$VAULT_PATH/Conceptos" \
     "$VAULT_PATH/Investigación" "$VAULT_PATH/Guías" "$VAULT_PATH/Resultados de búsqueda" \
     -name "*.md" -o -name "*.sh" -o -name "*.json" 2>/dev/null | while IFS= read -r f; do
  case "$f" in *dominio.config.md) continue;; esac
  replace_in "$f"
done

chmod +x "$VAULT_PATH/.claude/claude_hook_start.sh" 2>/dev/null || true

echo
echo "✓ Listo. Tu '$DOMINIO'-brain está en: $VAULT_PATH"
echo "  Siguiente:"
echo "   1) cd \"$VAULT_PATH\" && claude   (abre Claude Code aquí)"
echo "   2) (opcional) abre la carpeta como vault en Obsidian"
echo "   3) Empieza: «crea un concepto de …», «crea una nota de investigación sobre …», «pasa el guardián»"
