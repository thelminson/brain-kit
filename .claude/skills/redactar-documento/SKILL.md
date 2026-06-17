---
name: redactar-documento
description: >-
  Redacta un BORRADOR de documento largo (artículo, informe, monografía) en el vault,
  instanciando `Plantillas/Documento.md` a partir de una nota de `Investigación/` y/o su
  nota-guía de desarrollo en `Guías/`. Produce el documento estructurado (introducción
  con estado del arte y hueco, preliminares, resultados principales con justificación,
  casos particulares, problemas abiertos honestos, referencias reales) en `Guías/` o
  `Fuentes/`, lo enlaza bidireccionalmente y verifica que no haya enlaces rotos. Úsalo
  cuando el usuario pida "redacta/escribe un documento", "instancia la plantilla de
  documento", "convierte esta línea/guía en un borrador" o "borrador de informe/paper".
---

# Skill: Redactar un documento de investigación

> **Vault:** `{{VAULT_PATH}}`
> **Plantilla:** `Plantillas/Documento.md` (borrador del vault). Instánciala tal cual.
> **Destino:** `Guías/<Título>.md` o `Fuentes/<Título>.md` (`type: documento`) — el `.md` es el **hub navegable** del vault, en `{{IDIOMA}}`. Si se exporta a un formato externo (p. ej. LaTeX/PDF), ese flujo queda fuera de este skill; el contenido/notación es **idéntico** entre versiones y solo cambia la prosa.

## Cuándo usar
- El usuario pide **redactar/escribir un documento**, **instanciar la plantilla de documento**, **convertir una línea de investigación o una guía en un borrador largo**, o un **borrador para un destino** concreto.

## Activadores
- "redacta / escribe **un documento / informe / artículo** sobre …"
- "instancia la **plantilla de documento** con …"
- "convierte **esta línea / esta guía** en un **borrador**"
- "borrador de **documento para [destino/audiencia]**"

## Fuentes de entrada (leer ANTES de redactar)
Un documento nace de material ya existente en el vault; **no inventes resultados**. Localiza y lee:
1. **Nota de Investigación** (`Investigación/`): aporta el hueco, la genealogía, el estado del arte (bloque 🧬), la maquinaria *asumido/objetivo* (📎) y el planteamiento (📐).
2. **Nota-guía de desarrollo** (`Guías/… — Desarrollo`), si existe: aporta las **definiciones, resultados y justificaciones** ya redactadas y los **ejemplos / recuperación de casos**. Es la fuente primaria del cuerpo principal.
3. **Notas de Concepto** enlazadas: definiciones formales y citas.
Si falta la guía de desarrollo, **adviértelo** y propón generarla antes (skill `nota-avanzada`); un documento sin justificaciones no es un borrador útil.

## Mapeo guía/nota → secciones del documento
| Sección del documento | De dónde sale |
|---|---|
| **Resumen / Abstract** | síntesis de la pregunta (📐) + resultado principal (guía) + casos que recupera |
| **§1 Introducción** | 🧬 (estado del arte, hueco, genealogía) + 📎 *objetivos* como contribución numerada |
| **§2 Preliminares** | 📐 *Marco y notación* + 📎 *Maquinaria que se asume* |
| **§3 Resultados principales** | resultados + **justificaciones** de la guía (completas; "esbozo" si lo es) |
| **§4 Casos particulares** | ejemplos de la guía + **recuperación de los casos límite/clásicos** conocidos |
| **§5 Aplicación** (opc.) | si la línea la contempla |
| **§6 Conclusiones / abiertos** | callouts `[!warning]` de la guía (núcleo abierto) + direcciones |
| **Referencias** | bibliografía real de la nota/guía (📚) |
| **🧠 Bitácora de avance** (en el `.md`) | registro fechado de hitos: instanciado, teoría cerrada, correcciones de revisión, envío/publicación |

## Pasos
1. **Confirmar fuente y destino.** Identifica la nota de Investigación y la guía; confirma (o infiere) el **destino/audiencia objetivo** y, si aplica, la **clasificación/keywords**.
2. **Instanciar.** Crear el documento en `Guías/` o `Fuentes/` instanciando `Plantillas/Documento.md`; rellenar el frontmatter (autores, destino, keywords).
3. **Redactar** cada sección según el mapeo. Las justificaciones de §3 se **trasladan de la guía** (no se re-derivan desde cero); mantener rigor y numeración (Definición 3.1, Resultado 3.2…).
4. **Recuperación de casos** (obligatoria si aplica): incluir la verificación de que el resultado principal se reduce a los **casos clásicos/límite conocidos** (citándolos). Es el sello de calidad.
5. **Honestidad:** trasladar los resultados **abiertos/condicionados** a `[!warning]` en §3/§6; no presentarlos como cerrados.
6. **Enlazar e indexar.** (a) Desde el documento: `relacionado` + cuerpo apuntan a la nota de Investigación y a la guía. (b) Añadir la entrada en el **Índice** correspondiente (`Índice de Guías`), con destino objetivo y estado. (c) Puntero al documento desde la bitácora de la nota de Investigación de la que nace.
7. **Verificar** (ver abajo).

## Reglas
- Idioma `{{IDIOMA}}` + notación del dominio (LaTeX si `{{LATEX}}`=on); rigor de nivel `{{NIVEL}}`.
- **Citas reales** únicamente; nunca inventes autor/año/fuente. Comprobar **prioridad** frente a literatura reciente antes de afirmar novedad (riesgo de que alguien lo haya publicado).
- **No inventar resultados ni justificaciones**: todo lo de §3 debe venir de la guía o ser una consecuencia justificada. Si algo no está establecido, va a `[!warning]`.
- Entornos (consistentes con las guías): Definición `[!info]`, Resultado/Caso `[!success]`/`[!tip]`, *Justificación.* … (cierre), Observación `[!note]`, abierto `[!warning]`, Ejemplo `[!example]`.
- Wikilinks **solo a notas existentes**; nunca dejar enlaces rotos.
- El `.md` es el **borrador de trabajo** en el vault. Si se exporta a un formato externo, no declarar listo ningún artefacto sin verificar/compilar.

## Verificación
- **0 enlaces rotos** en el documento y en las notas tocadas:
  ```bash
  cd "{{VAULT_PATH}}"
  grep -rho "\[\[[^]]*\]\]" --include="*.md" . | sed 's/\[\[//; s/\]\]//; s/|.*//; s/#.*//' | sort -u | \
    while read -r l; do [ -z "$(find . -path ./Plantillas -prune -o -name "${l}.md" -print 2>/dev/null)" ] && echo "ROTO -> [[$l]]"; done
  ```
- El documento tiene: frontmatter (con keywords + destino_objetivo), Resumen, Introducción con estado del arte y **contribución numerada**, Preliminares, ≥1 resultado con justificación, **recuperación del caso clásico/límite verificada** (si aplica), ≥1 ejemplo, Conclusiones con problemas abiertos, Referencias reales, y **🧠 Bitácora de avance** fechada (en el `.md`). Cada cambio de contenido se anota en la bitácora.
- Reportar: ruta del documento, de qué nota/guía se nutrió, qué quedó como abierto, y advertencias de prioridad/atribución a revisar.

## Notas
- Tipos en el vault: `concepto` (atómica), `guía` (desarrollo largo), `investigación` (línea/roadmap), `documento` (borrador), `moc` (índice).
- Plantilla viva: `Plantillas/Documento.md`. Mantener sincronizadas plantilla y skill.
- Skills relacionados: `crear-nota-investigacion`, `nota-avanzada` (genera la guía fuente), `notas-didacticas` (acompañante didáctico), `renombrar-backlinks`. Para revisión adversarial, el agente `revisor`.
