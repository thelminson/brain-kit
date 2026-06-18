#!/usr/bin/env bash
# brain-kit — cliente LLM multi-proveedor (interfaz OpenAI ChatCompletions).
# Sirve para la skill `segunda-opinion` y, con modelos de búsqueda, para `buscar-web`.
#
# Uso:   consultar.sh <archivo_prompt> [proveedor] [modelo]
#   <archivo_prompt> : ruta a un .md/.txt con el prompt completo (contexto + pregunta).
#   [proveedor]      : deepseek | openai | grok | gemini | perplexity
#                      (por defecto: $LLM_PROVIDER, o "deepseek").
#   [modelo]         : opcional; si se omite usa el modelo por defecto del proveedor.
#
# La CLAVE se lee de una variable de entorno por proveedor (defínela en ~/.zshenv);
# NUNCA se pasa como argumento. Variables esperadas:
#   deepseek   → DEEPSEEK_API_KEY
#   openai     → OPENAI_API_KEY
#   grok       → XAI_API_KEY
#   gemini     → GEMINI_API_KEY
#   perplexity → PERPLEXITY_API_KEY
#
# Imprime RAZONAMIENTO (si el modelo lo expone), RESPUESTA y USO.
set -euo pipefail
command -v curl >/dev/null 2>&1 || { echo "Falta 'curl'." >&2; exit 127; }
command -v jq   >/dev/null 2>&1 || { echo "Falta 'jq'."   >&2; exit 127; }

PROMPT_FILE="${1:?Uso: consultar.sh <archivo_prompt> [proveedor] [modelo]}"
PROVIDER="${2:-${LLM_PROVIDER:-deepseek}}"
MODEL_OVERRIDE="${3:-}"

case "$PROVIDER" in
  deepseek)   BASE="https://api.deepseek.com";                                  KEYVAR="DEEPSEEK_API_KEY";   DEF_MODEL="deepseek-reasoner";;
  openai)     BASE="https://api.openai.com/v1";                                 KEYVAR="OPENAI_API_KEY";     DEF_MODEL="gpt-5.1";;
  grok)       BASE="https://api.x.ai/v1";                                       KEYVAR="XAI_API_KEY";        DEF_MODEL="grok-4";;
  gemini)     BASE="https://generativelanguage.googleapis.com/v1beta/openai";  KEYVAR="GEMINI_API_KEY";     DEF_MODEL="gemini-2.5-pro";;
  perplexity) BASE="https://api.perplexity.ai";                                KEYVAR="PERPLEXITY_API_KEY"; DEF_MODEL="sonar-pro";;
  *) echo "Proveedor desconocido: '$PROVIDER'. Usa: deepseek|openai|grok|gemini|perplexity" >&2; exit 2;;
esac

MODEL="${MODEL_OVERRIDE:-$DEF_MODEL}"
KEY="${!KEYVAR:-}"
[ -n "$KEY" ] || { echo "$KEYVAR no está definida. Añádela a ~/.zshenv y reabre la sesión." >&2; exit 1; }

PAYLOAD=$(jq -n --rawfile q "$PROMPT_FILE" --arg m "$MODEL" \
  '{model:$m, messages:[{role:"user", content:$q}], stream:false}')

RESP=$(curl -sS --max-time 600 "$BASE/chat/completions" \
  -H "Authorization: Bearer $KEY" \
  -H "Content-Type: application/json" \
  -d "$PAYLOAD") || { echo "Fallo de red al contactar $PROVIDER." >&2; exit 1; }

echo "$RESP" | jq -e . >/dev/null 2>&1 || { echo "Respuesta no-JSON o vacía de $PROVIDER:" >&2; printf '%s\n' "$RESP" >&2; exit 1; }
if echo "$RESP" | jq -e '.error' >/dev/null 2>&1; then
  echo "ERROR $PROVIDER:" >&2; echo "$RESP" | jq -r '.error.message // .error' >&2; exit 1
fi

REASON=$(echo "$RESP" | jq -r '.choices[0].message.reasoning_content // empty')
[ -n "$REASON" ] && { echo "===== RAZONAMIENTO ====="; printf '%s\n\n' "$REASON"; }
echo "===== RESPUESTA ($PROVIDER · $MODEL) ====="
echo "$RESP" | jq -r '.choices[0].message.content // "(sin contenido)"'
echo
echo "===== USO ====="
echo "$RESP" | jq -r '.usage // {} | "prompt:\(.prompt_tokens // "?") completion:\(.completion_tokens // "?") total:\(.total_tokens // "?")"'
