---
name: formalizar-rigor
description: >-
  Aumenta el rigor y la formalidad de las definiciones y objetos de las notas del vault
  (marco/contexto, condiciones, hipótesis, cuantificadores, resultados con hipótesis↔conclusión),
  preservando todo lo demás. Úsalo cuando el usuario pida "haz más formales/rigurosas las
  definiciones" en uno, varios o todos los conceptos.
---

# Skill: Formalizar el rigor de las notas

> **Vault:** `{{VAULT_PATH}}`

## Cuándo usar
- El usuario pide **subir la formalidad/rigor** de las definiciones y objetos en notas de `Conceptos/` (o un subconjunto).

## Activadores

Frases o peticiones que lo disparan:
- "haz más **formales / rigurosas** las definiciones"
- "**aumenta el rigor / formalidad** … en todos los conceptos"
- "**endurece** las definiciones y objetos"

## Qué cambiar (solo esto)
Reescribir los callouts de **Definición** y los enunciados que introducen objetos (y `Resultado/Afirmación/Caso`) para que sean rigurosos y autocontenidos, al nivel `{{NIVEL}}` del dominio `{{DOMINIO}}`:
- **Marco, contexto y espacio ambiente explícitos**: declarar sobre qué objetos se trabaja y en qué condiciones (con la notación del dominio; LaTeX si `{{LATEX}}`=on).
- **Cuantificadores** y **rangos de parámetros** precisos.
- **Hipótesis/condiciones de regularidad** explícitas (existencia, unicidad, condiciones de aplicabilidad, supuestos del modelo…).
- **Notación correcta** del dominio.
- En resultados: **hipótesis ↔ conclusión** separadas.

## Qué PRESERVAR (no tocar)
Frontmatter (title, tags, aliases, relacionado), H1, **Historia**, Interpretación (se puede pulir conservando la intuición), **Ejemplos**, Conexiones, footer, **todos los wikilinks**, títulos y fechas.

## Reglas
- **Corrección es prioridad**: no introducir errores ni alterar el significado; no borrar ejemplos.
- Usar **Edit dirigido** (no reescribir el archivo entero).
- No añadir enlaces nuevos ni romper los existentes.

## Escala
- Para muchas notas, repartir en **agentes en paralelo por área temática** (~8 notas por agente), con las reglas anteriores explícitas en el prompt.

## Verificación
- **0 enlaces rotos** en el vault.
- Integridad (solo notas `type: concepto`; para Guías/Investigación verifica solo enlaces rotos y que se preserven sus propias secciones): cada concepto conserva frontmatter, H1, Historia, Ejemplos y footer.
  ```bash
  cd "{{VAULT_PATH}}/Conceptos"
  for f in *.md; do [ "$f" = "Índice de Conceptos.md" ] && continue; \
  { grep -q "\[!quote\] Historia" "$f" && grep -q "^## Ejemplos" "$f"; } || echo "REVISAR: $f"; done
  ```
- Reportar correcciones de paso (notación, fórmulas, condiciones) hechas durante la formalización.
