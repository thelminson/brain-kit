---
name: proponer-problemas-pdf
description: >-
  Lee a fondo una carpeta de fuentes (PDF/documentos) sobre un tema, extrae los problemas
  abiertos/trabajo futuro que plantean los autores y PROPONE problemas/cuestiones de investigación
  nuevos (combinables con las líneas del programa del usuario en {{DOMINIO}}), y entrega un dossier
  con las FUENTES INTERESANTES (anotadas) y los PROBLEMAS PROPUESTOS, con priorización y
  advertencias. Salida: PDF con LaTeX si {{LATEX}}=on, si no Markdown. Úsalo cuando el usuario pida
  "genera un pdf con los problemas de estos documentos", "resume los problemas de investigación de
  esta carpeta", "extrae problemas de estas fuentes y propón nuevos".
---

# Skill: Dossier de problemas de investigación a partir de una carpeta de fuentes

> **Vault:** `{{VAULT_PATH}}`
> **Config del dominio:** `{{VAULT_PATH}}/.claude/dominio.config.md` (placeholders y toggles, en especial `{{LATEX}}`).
> **Carpeta de la skill:** `{{VAULT_PATH}}/.claude/skills/proponer-problemas-pdf/`
> **Plantilla LaTeX:** `{{VAULT_PATH}}/.claude/skills/proponer-problemas-pdf/plantilla.tex`

Produce un **dossier de investigación** que, a partir de una carpeta de fuentes sobre un tema, sintetiza las **fuentes interesantes** y un conjunto de **problemas/cuestiones de investigación propuestos** (idealmente combinables con las líneas del programa del usuario en `{{DOMINIO}}`).

## Cuándo usar
- El usuario señala una **carpeta de fuentes** (o un conjunto de documentos/PDFs) y quiere **proponer problemas de investigación** a partir de ellos, **entregados como dossier**.
- Opcional: hay un **documento modelo** (p. ej. una nota guía) que fija el alcance temático.

### Activadores
- "**genera un pdf** con las fuentes interesantes y los **problemas propuestos** de [carpeta/tema]"
- "**resume los problemas** de investigación de estas fuentes"
- "de estos documentos, **¿de dónde podemos proponer problemas?**"
- "extrae los **problemas abiertos** de esta carpeta y propón nuevos (combinables con [línea del dominio])"

### Cuándo NO usar
- Catalogar/describir fuentes sin proponer problemas → `catalogar-fuentes`.
- Crear UNA nota de línea de investigación (no dossier) → `crear-nota-investigacion`.
- Cerrar prioridad de UN problema concreto → agente `investigador`.
- Instanciar un documento del vault a LaTeX/PDF → agente `publicador`.

## Formato de salida (toggle `{{LATEX}}`)
- **`{{LATEX}}` = on:** dossier compilado a **PDF** con LaTeX (requiere `pdflatex` de TeX Live; comprobar `command -v pdflatex`). Usa `plantilla.tex` de esta carpeta.
- **`{{LATEX}}` = off (o sin TeX):** dossier en **Markdown** (mismas secciones), guardado como nota del vault.
- Lectura de fuentes con la tool `Read` (soporta PDF; para >10 pp. usar el parámetro `pages`).

## Procedimiento

1. **Localiza la carpeta y las fuentes.** `ls` de la carpeta; identifica el documento modelo si lo hay. Anota tamaños (detecta libros/tesis largos para leerlos por índice + cierre).

2. **Lectura profunda en paralelo.** Reparte las fuentes en **agentes en paralelo** (`analista-fuentes`), en lotes de ~5–8. Cada agente extrae, **por fuente** y sin inventar:
   - **Aporte central** (definiciones/resultados clave, enunciado breve).
   - **Hipótesis/limitaciones** del marco (alcance, condiciones, supuestos).
   - **Problemas abiertos / trabajo futuro** que el autor plantee **EXPLÍCITAMENTE** (cita textual breve + ubicación); si no hay, decirlo.
   - **Gancho hacia el programa del usuario** (marcado como sugerencia propia): ¿qué objeto/idea extender a las **líneas del `{{DOMINIO}}`** del usuario?
   Formato de retorno: markdown con una sección por fuente.

3. **Síntesis (lo que distingue a esta skill).**
   - **Fuentes interesantes** anotadas (2–4 líneas c/u: aporte + problema abierto/limitación), agrupadas (fundacionales / modernas).
   - **Lectura conjunta / hueco unificador:** cruza qué cubre cada fuente y qué NO; identifica la **intersección que ninguna cubre** (de ahí salen los mejores problemas).
   - **Problemas de investigación propuestos:** numerados y agrupados, cada uno con **base** (de qué fuente desciende) y **hueco** (qué falta), y enunciado preciso. Prioriza las **combinaciones con las líneas del dominio**.

4. **Genera el dossier.**
   - **Si `{{LATEX}}` = on:** copia `plantilla.tex` a un temporal (`/tmp/<slug>/`), rellena título, abstract, secciones (Marco mínimo · Fuentes interesantes · Problemas propuestos · Priorización y advertencias · Bibliografía). Mantén el preámbulo de la plantilla (no metas paquetes exóticos). Bibliografía con **referencias reales** (autor, fecha, venue; identificadores verificados; **no inventar**).
   - **Si `{{LATEX}}` = off:** genera las mismas secciones en Markdown.

5. **Compila y verifica (solo LaTeX).**
   ```bash
   cd /tmp/<slug> && pdflatex -interaction=nonstopmode -halt-on-error doc.tex && pdflatex -interaction=nonstopmode -halt-on-error doc.tex
   ```
   Repite 2× (refs/índice). Depura hasta **EXIT 0** y **PDF generado** (`%PDF` al inicio, `%%EOF` al final). Errores típicos: comando no definido, caracteres especiales.

6. **Coloca el resultado.** Mueve el **dossier (PDF + su `.tex`, o el `.md`)** a la carpeta indicada por el usuario; por defecto, una carpeta de documentos de trabajo (junto a documentos meta) o la propia carpeta analizada. Nombre: `<Tema> — Fuentes y Problemas de Investigación.<pdf|md>`. Limpia los temporales de `/tmp`.

7. **Priorización y honestidad.**
   - Incluye una **tabla de priorización** (problema · tipo · base · novedad · viabilidad) y un bloque de **advertencias de prioridad** (qué podría colisionar; recomendar cierre de prioridad con el agente `investigador` antes de redactar).
   - **Distingue** los problemas abiertos *declarados por los autores* de las *propuestas propias*.
   - Si existe un `RB-NNNN` de estado del arte del tema, **enlázalo** en el dossier.

## Verificación (siempre)
- Si `{{LATEX}}` = on: `pdflatex` termina en **EXIT 0** y el PDF es válido (`%PDF`/`%%EOF`, nº de páginas > 0). Si Markdown: la nota tiene todas las secciones y **0 enlaces rotos**.
- **Cero citas inventadas**; problemas abiertos de autor con cita textual; propuestas propias marcadas como tales.
- Reporta: ruta del dossier, nº de páginas (PDF), nº de fuentes y nº de problemas propuestos, y los huecos más accionables.

## Notas
- Es complementaria: la lectura puede apoyarse en `catalogar-fuentes` (si además quieres una nota-biblioteca) y el seguimiento en `crear-nota-investigacion` / `investigador` (cierre de prioridad).
- El dossier es un **documento de trabajo** (no una nota atómica del vault); por eso va a una carpeta de documentos de trabajo o a la carpeta de origen, no a `Conceptos/` ni `Investigación/`.
