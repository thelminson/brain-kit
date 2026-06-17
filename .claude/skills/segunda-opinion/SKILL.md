---
name: segunda-opinion
description: >-
  Acceso bajo demanda a un SEGUNDO modelo de razonamiento (configurado en dominio.config.md) para
  contrastar el trabajo de Claude. Claude orquesta con todo el contexto del vault; solo delega lo
  que el usuario pida. DOS modos, ambos SOLO explícitos: (1) CONSULTA — razonamiento puntual
  ("pregúntale al segundo modelo", "que lo razone otro modelo", "consulta una segunda opinión");
  (2) DUAL — resolver la MISMA tarea en paralelo a ciegas y fusionar ("contrasta", "doble cerebro",
  "segunda opinión", "compara con el otro modelo"). NUNCA se activa solo. Requiere {{LLM_2A_OPINION}} ≠ off.
---

# Skill: Segunda opinión de un segundo modelo bajo demanda

> **Vault:** `{{VAULT_PATH}}`
> **Config del dominio:** `{{VAULT_PATH}}/.claude/dominio.config.md` (placeholders y toggles, en especial `{{LLM_2A_OPINION}}`).
> **Carpeta de la skill:** `{{VAULT_PATH}}/.claude/skills/segunda-opinion/`

## Disponibilidad (toggle)
- **Esta skill SOLO aplica si `{{LLM_2A_OPINION}}` ≠ `off`.** Si el toggle está en `off`, el segundo modelo **no está configurado** y la skill **no aplica**: dilo explícitamente al usuario y resuelve la tarea solo con Claude.
- El **segundo modelo de razonamiento** (su identificador, endpoint y ejecutable/comando) se define en `dominio.config.md`. No se nombran marcas concretas aquí: es "el segundo modelo configurado".

## Regla de activación (importante)
- **Dormido por defecto.** Todas las demás skills funcionan con normalidad sin tocar el segundo modelo, a menos que el usuario lo pida **explícitamente**.
- Solo se activa con un disparador claro del usuario:
  - **Modo consulta:** "pregúntale al segundo modelo", "consulta una **segunda opinión** sobre…", "que lo **razone** otro modelo".
  - **Modo dual:** "**contrasta** con el otro modelo", "**doble cerebro**", "**segunda opinión**", "**compara** con el otro modelo", "hazlo también con el segundo modelo y fusiona".
- Solo para **cosas avanzadas** (razonamiento, contenido de nivel `{{NIVEL}}`). Nunca automático, nunca para tareas triviales, nunca para nada que requiera web/MCP/visión en el lado del segundo modelo (este solo recibe el texto que Claude le incluya en el prompt).

## Requisitos
- `{{LLM_2A_OPINION}}` ≠ `off` y el ejecutable/credencial del segundo modelo configurados en el entorno (p. ej. `~/.zshenv`). La credencial **nunca** se escribe en el chat ni se pasa como argumento.
- Comando/ejecutable y modelos disponibles: ver `dominio.config.md`. Por convención imprime `RAZONAMIENTO`, `RESPUESTA` y `USO`.

---

## MODO 1 — Consulta puntual

Para una pregunta de razonamiento aislada.

1. **Reúne el contexto** del vault que el problema necesite (Read). El segundo modelo NO ve el vault: solo verá lo que incluyas.
2. **Redacta el prompt completo** (contexto + pregunta) y escríbelo con Write a un temporal (p. ej. `/tmp/segunda_opinion_prompt.md`). Incluye instrucciones de rigor de nivel `{{NIVEL}}` en `{{IDIOMA}}`.
3. **Lanza la consulta** con el comando del segundo modelo indicado en `dominio.config.md` (vía Bash).
4. **Integra críticamente**: presenta la respuesta del segundo modelo distinguiéndola de tu propio análisis; verifica su razonamiento (no lo asumas correcto) y señala errores o saltos. Guarda en el vault si el usuario lo pide.
5. **Limpia** el temporal si tiene material sensible.

---

## MODO 2 — Dual / segunda opinión (independiente + desempate híbrido)

Acompaña a **otra skill local** (p. ej. `nota-avanzada`, `redactar-documento`, `formalizar-rigor`, `crear-nota-investigacion`, `guardar-concepto`). La misma tarea se resuelve dos veces — Claude y el segundo modelo **de forma independiente** — y Claude fusiona lo mejor de ambos.

**Principio:** el segundo modelo trabaja **a ciegas** (NO ve el borrador de Claude) para máxima diversidad y verificación cruzada genuina. El segundo modelo aporta **sustancia**; Claude aporta su propia versión, la **fusión** y **toda la integración al vault** (formato, wikilinks, frontmatter, índice) — eso no se le pide al segundo modelo.

### Protocolo

1. **Ejecuta la skill local con normalidad** y reúne el contexto del vault (definiciones, plantilla, notas enlazables). Identifica la **tarea sustantiva** (el contenido a producir).
2. **Lanza al segundo modelo EN PARALELO, a ciegas.** Escribe a un temporal (p. ej. `/tmp/segunda_opinion_dual.md`) un prompt con SOLO: el enunciado de la tarea + el contexto necesario + instrucciones de rigor. **NO** incluyas tu borrador ni convenciones de formato del vault (el segundo modelo produce contenido, no formato). Lánzalo en segundo plano (`run_in_background: true` en Bash), redirigiendo a un archivo de salida.
3. **Mientras el segundo modelo trabaja, produce TU propia versión** completa siguiendo la skill local.
4. **Recoge la salida del segundo modelo** (lee el archivo de salida cuando el proceso termine).
5. **Diff crítico.** Compara ambas versiones punto por punto:
   - **Coincidencias** → alta confianza, se conservan.
   - **Aportes únicos** de cada uno (un argumento mejor, un ejemplo más claro, una hipótesis más fina) → se incorporan.
   - **Discrepancias** → zona a auditar.
6. **Desempate híbrido (solo si hay discrepancia sustantiva).** Para cada punto en conflicto, haz una ronda corta donde cada lado ve el argumento del otro: presenta al segundo modelo el punto concreto de tu versión (un mini-prompt acotado) y pídele que lo refute o lo acepte; tú haces lo propio con su argumento. Decide con el razonamiento, no por autoridad. Documenta brevemente quién tenía razón.
7. **Síntesis "lo mejor de ambos".** Construye el resultado final combinando lo verificado de ambas versiones y **tú** lo integras al vault con el formato de la skill local (wikilinks, índice, frontmatter, etc.).
8. **Reporta al usuario** de forma transparente: qué aportó cada modelo, dónde discreparon y cómo se resolvió. **Limpia** los temporales.

### Plantilla de prompt para el segundo modelo (modo dual, a ciegas)
```
Eres un asistente riguroso de nivel {{NIVEL}} en {{DOMINIO}}. Resuelve la siguiente tarea de
forma autónoma y con rigor. Justifica cada paso e indica hipótesis explícitas. Devuelve solo la
SUSTANCIA (afirmaciones, justificaciones, ejemplos); no te preocupes por formato editorial.

TAREA: <enunciado de la tarea de la skill local>

CONTEXTO: <definiciones/resultados/datos del vault que necesite>
```

---

## Notas
- El identificador del modelo por defecto y la alternativa ligera se configuran en `dominio.config.md`.
- El segundo modelo es siempre un **subordinado puntual**: Claude mantiene el contexto, la web, MCP, el control del vault y la decisión final de la síntesis.
- Cross-reference: el agente `revisor` puede usar esta skill en modo dual para una revisión adversarial independiente.
