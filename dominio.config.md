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
WEB_SEARCH_EXTRA   = off   # motor citado con grounding: gemini | perplexity | off
LLM_2A_OPINION     = off   # segunda opinión: deepseek | openai | grok | gemini | perplexity | off
LATEX              = on    # pdflatex disponible (para publicador y proponer-problemas-pdf)
NOTIFY             = off   # notificación (telegram/email/slack…): comando o "off"
```

## Proveedores LLM (segunda opinión y motor de búsqueda citado)

`LLM_2A_OPINION` y `WEB_SEARCH_EXTRA` aceptan uno de estos proveedores. Todos se consultan con el
mismo cliente `.claude/skills/segunda-opinion/consultar.sh` (interfaz OpenAI). Pon la **API key** en
`~/.zshenv` con el nombre indicado y reabre la terminal.

| Proveedor (valor) | Clave en `~/.zshenv` | Endpoint | Modelo por defecto | Bueno para |
|---|---|---|---|---|
| `deepseek`   | `DEEPSEEK_API_KEY`   | `api.deepseek.com`                         | `deepseek-reasoner` | razonamiento / 2.ª opinión |
| `openai`     | `OPENAI_API_KEY`     | `api.openai.com/v1`                        | `gpt-5.1`           | 2.ª opinión general |
| `grok`       | `XAI_API_KEY`        | `api.x.ai/v1`                              | `grok-4`            | 2.ª opinión general |
| `gemini`     | `GEMINI_API_KEY`     | `…/v1beta/openai` (Google)                 | `gemini-2.5-pro`    | búsqueda con grounding · 2.ª opinión |
| `perplexity` | `PERPLEXITY_API_KEY` | `api.perplexity.ai`                        | `sonar-pro`         | búsqueda citada (sonar) |

> Los **modelos por defecto** se editan en `consultar.sh` (mapa `case`) o se pasan como 3.er argumento.
> Para `WEB_SEARCH_EXTRA` usa `gemini` o `perplexity` (son los que devuelven fuentes/grounding);
> `LLM_2A_OPINION` admite los cinco. Si pones `off`, la skill/agente correspondiente se degrada (usa
> solo herramientas nativas / omite la segunda opinión) sin romper nada.
>
> Uso directo del cliente:
> `bash .claude/skills/segunda-opinion/consultar.sh /tmp/prompt.md <proveedor> [modelo]`

## Notas
- **WEB_SEARCH** debería estar `on` siempre que tengas las tools nativas de Claude Code; es lo mínimo para investigar.
- **WEB_SEARCH_EXTRA / LLM_2A_OPINION / NOTIFY** son opcionales: si los pones `off`, el agente `investigador` usa solo web nativa, el `revisor` omite la segunda opinión y no se notifica nada.
- **LATEX** `off` hace que `proponer-problemas-pdf` y el `publicador` produzcan **Markdown** en vez de PDF.
- Puedes reejecutar `setup.sh` si cambias algo (es idempotente sobre los placeholders restantes).
