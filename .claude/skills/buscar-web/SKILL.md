---
name: buscar-web
description: >-
  Investigación web profunda y CITADA bajo demanda, con rigor de nivel {{NIVEL}}: busca en tiempo
  real, lee, sintetiza y devuelve un informe CITADO (URI + título) archivado en el vault. Por
  defecto usa búsqueda/fetch nativos; si hay un motor externo citado configurado, lo añade.
  SOLO con disparadores explícitos: "busca en la web", "búsqueda profunda", "investiga en
  internet", "busca fuentes sobre…".
---

# Skill: Búsqueda web profunda y citada bajo demanda

> **Vault:** `{{VAULT_PATH}}`
> **Config del dominio:** `{{VAULT_PATH}}/.claude/dominio.config.md` (placeholders y toggles, en especial `{{WEB_SEARCH_EXTRA}}`).
> **Carpeta de la skill:** `{{VAULT_PATH}}/.claude/skills/buscar-web/`

El usuario quiere una búsqueda profunda en la web con rigor de nivel `{{NIVEL}}`, fundamentada y citada. Claude orquesta con todo el contexto del vault, busca, lee, sintetiza y archiva el resultado.

## Regla de activación (importante)
- **Solo bajo demanda explícita:** se activa únicamente con frases como "**busca en la web**", "**búsqueda profunda**", "**investiga en internet**" o "**busca fuentes sobre…**".
- **Ventaja:** bibliografía exacta, prioridades históricas, verificar si un problema/cuestión está resuelta y citar fuentes concretas con su URI.

## Motores (toggle con degradación)
- **Por defecto (siempre disponible):** herramientas nativas `WebSearch` + `WebFetch`. Buscan, abren y leen las fuentes; son la vía base.
- **Motor externo citado (opcional):** si `{{WEB_SEARCH_EXTRA}}` ≠ `off` (valores `gemini` o `perplexity` — los que devuelven fuentes con grounding), se invoca además el cliente `{{VAULT_PATH}}/.claude/skills/segunda-opinion/consultar.sh` con ese proveedor, pidiéndole una respuesta **con fuentes/URIs**. Si el toggle está en `off`, se trabaja **solo** con las nativas (degradación limpia, sin error).
- La credencial del proveedor vive en `~/.zshenv` (`GEMINI_API_KEY` / `PERPLEXITY_API_KEY`); **nunca** se escribe en el chat ni se pasa como argumento. Endpoints/modelos: tabla en `dominio.config.md`.

## Procedimiento

1. **Afina la pregunta:** si es ambigua, aclara alcance o palabras clave antes de buscar.
2. **Prepara la consulta:** redacta la consulta de investigación en `{{IDIOMA}}`, enfocada a las fuentes de referencia del `{{DOMINIO}}` (repositorios, archivos, sitios institucionales; sin límite de fecha: las fuentes clásicas cuentan).
3. **Busca:**
   - Lanza `WebSearch`/`WebFetch` nativos para localizar y leer fuentes.
   - Si `{{WEB_SEARCH_EXTRA}}` ≠ `off`, lanza además el motor citado (vía Bash) y combina sus fuentes ancladas con lo nativo:
     ```bash
     bash "{{VAULT_PATH}}/.claude/skills/segunda-opinion/consultar.sh" /tmp/buscar_extra_prompt.md {{WEB_SEARCH_EXTRA}}
     ```
4. **Sintetiza el informe:** estructura (1) Estado del arte, (2) Problemas abiertos / huecos, (3) Conclusiones/propuestas, (4) Lista de fuentes con sus URI. Distingue lo verificado de tus inferencias; si no encuentras algo, decláralo. Si NO hubo fuentes de grounding del motor externo, trátalo como **no anclado** (`grounded: false`).
5. **Archiva el resultado en el vault** (carpeta `Resultados de búsqueda/`):
   - Calcula el siguiente ID secuencial:
     ```bash
     ls "{{VAULT_PATH}}/Resultados de búsqueda/" | grep -oE 'RB-[0-9]+' | sort | tail -1
     ```
   - Guarda la nota como `RB-NNNN — <título>.md` con frontmatter `id`, `type`, `modelo` (motor usado), `grounded` (true/false) y `date`, y una sección `## Fuentes` con la disciplina bibliográfica del dominio (Apellido, N. Año — Título — URI).
   - Registra la nota en `Resultados de búsqueda/Índice de Resultados de búsqueda.md` y **actualiza el contador** del índice.
6. **Integra con las notas del vault:** si la búsqueda apoya a otra nota (documento, guía…), enlaza bidireccionalmente con `[[RB-NNNN …]]` en la bitácora de esa nota.
7. **Limpieza:** borra cualquier archivo temporal del prompt.

## Verificación (siempre)
- La nota contiene referencias reales y verificables con sus URI directos y el flag `grounded` correcto.
- **0 enlaces rotos** en la nota y el índice:
  ```bash
  grep -rho "\[\[[^]]*\]\]" --include="*.md" . | sed 's/\[\[//; s/\]\]//; s/|.*//; s/#.*//' | sort -u | \
    while read -r l; do [ -z "$(find . -path ./Plantillas -prune -o -name "${l}.md" -print 2>/dev/null)" ] && echo "ROTO -> [[$l]]"; done
  ```

## Notas
- Rol subordinado del motor externo: Claude decide qué buscar y cómo sintetizar; el motor (nativo o externo) solo trae los datos anclados.
- El modelo/ejecutable del motor externo y sus alternativas se configuran en `dominio.config.md`; no se citan marcas concretas aquí.
- Para una segunda opinión de razonamiento sobre el material hallado, ver `segunda-opinion` (si está habilitada).
