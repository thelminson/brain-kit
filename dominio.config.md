# Configuración del dominio — brain-kit

> Edita los valores de abajo y ejecuta `bash setup.sh`. El script sustituirá estos
> placeholders en `.claude/agents`, `.claude/skills`, `docs/` y las notas semilla.

```ini
# --- Identidad del área ---
DOMINIO            = tu área de conocimiento        # p. ej. "biología molecular", "derecho mercantil"
DOMINIO_ADJ        = del área                        # adjetivo: "biológico", "jurídico", "clínico"
NIVEL              = investigación / experto         # nivel de rigor esperado
IDIOMA             = español                         # idioma de las notas

# --- Rutas ---
VAULT_PATH         = /Users/yimmyeman/Desktop/Mi-Brain   # dónde vivirá el vault instanciado
                                                         # (puede ser esta misma carpeta)

# --- Herramientas disponibles (on/off) ---
# Marca lo que tengas; las skills/agentes que dependan de algo apagado se degradan con elegancia.
WEB_SEARCH         = on    # búsqueda web nativa (WebSearch/WebFetch) — base del agente investigador
WEB_SEARCH_EXTRA   = off   # motor externo citado vía API (Google/Gemini, Perplexity…): comando o "off"
LLM_2A_OPINION     = off   # segunda opinión vía otro LLM por API (DeepSeek/o3…): comando o "off"
LATEX              = on    # pdflatex disponible (para publicador y proponer-problemas-pdf)
NOTIFY             = off   # notificación (Telegram/email…): comando o "off"
```

## Notas
- **WEB_SEARCH** debería estar `on` siempre que tengas las tools nativas de Claude Code; es lo mínimo para investigar.
- **WEB_SEARCH_EXTRA / LLM_2A_OPINION / NOTIFY** son opcionales: si los pones `off`, el agente `investigador` usa solo web nativa, el `revisor` omite la segunda opinión y no se notifica nada.
- **LATEX** `off` hace que `proponer-problemas-pdf` y el `publicador` produzcan **Markdown** en vez de PDF.
- Puedes reejecutar `setup.sh` si cambias algo (es idempotente sobre los placeholders restantes).
