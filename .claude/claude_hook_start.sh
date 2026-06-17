#!/usr/bin/env bash
# brain-kit — carga de contexto al iniciar sesión (SessionStart).
# Portátil: usa $CLAUDE_PROJECT_DIR (la raíz del vault instanciado).
cd "${CLAUDE_PROJECT_DIR:-.}" 2>/dev/null || exit 0

DOM="{{DOMINIO}}"
echo "🧠 Vault de ${DOM} (brain-kit). Contexto: lee «Conceptos/Índice de Conceptos.md»."

cnt() { ls "$1"/*.md 2>/dev/null | grep -v "Índice" | wc -l | tr -d ' '; }
echo "Conceptos: $(cnt Conceptos) · Investigación: $(cnt Investigación) · Guías: $(cnt Guías) · Resultados de búsqueda: $(cnt 'Resultados de búsqueda')"

echo "Notas .md modificadas (últimos 7 días):"
find Conceptos "Investigación" "Guías" Fuentes "Resultados de búsqueda" -name "*.md" -mtime -7 2>/dev/null \
  | sed 's|^|  - |' | head -25
exit 0
