---
name: nota-avanzada
description: >-
  Genera una GUÍA Markdown de nivel {{NIVEL}} sobre un tema del dominio y la guarda en
  `Guías/` del vault: definiciones formales, resultados con justificación o esbozo (declarado),
  ejemplos graduados, ejercicios con soluciones y diagramas, todo con callouts de Obsidian
  y notación del dominio, y RICAMENTE enlazada a los conceptos existentes del vault
  (frontmatter `relacionado`, wikilinks inline, sección Conexiones e Índice MOC). Úsalo
  cuando el usuario pida crear una guía/nota avanzada, notas formales, una monografía o una
  introducción rigurosa como nota del vault. No usar para una nota atómica simple (usa
  `guardar-concepto`). Para la versión didáctica de un documento ya existente, usa `notas-didacticas`.
---

# Skill: Nota Avanzada (Guía Markdown en el vault)

> **Vault:** `{{VAULT_PATH}}`
> **Destino:** `Guías/<Título>.md` (`type: guía`, o `referencia` si es un catálogo).
> Salida en **Markdown de Obsidian** (callouts + notación del dominio, LaTeX si `{{LATEX}}`=on). La nota debe quedar **integrada en la red**: enlaces y relaciones a los conceptos del vault.

## Cuándo usar
- El usuario pide una **guía / nota avanzada** (nivel `{{NIVEL}}`) como **nota del vault**: notas formales, monografía, introducción rigurosa, material con teoría + ejemplos + ejercicios.

### Activadores

Frases o peticiones que lo disparan:
- "crea una **guía / nota avanzada**"
- "**notas formales / monografía / introducción rigurosa** como nota del vault"
- "una **nota de nivel {{NIVEL}}** sobre … con ejemplos y ejercicios"
- "guarda en **Guías** una nota sobre …"

### Cuándo NO usar
- Un solo concepto atómico → usa `guardar-concepto`.
- Un documento de salida externo (p. ej. `.tex`/`.pdf` compilable) → ese flujo queda fuera de este skill.
- Explicaciones conversacionales breves o cálculos aislados.

## Plantilla de la nota

```markdown
---
title: "<Título>"
date: <YYYY-MM-DD>
tags:
  - {{DOMINIO}}
  - guía
  - <2-4 tags temáticos>
type: guía
status: procesado
aliases:
  - <2-4 alias, incluye otro idioma si aplica>
relacionado:
  - "[[Índice de Conceptos]]"
  - "[[<TODOS los conceptos del vault que toque el tema>]]"
---

# <Título>

> [!abstract] Qué es esta nota
> <propósito, alcance, requisitos previos y roadmap explícito de la guía>

## 1. Introducción y contexto
<motivación histórica y contemporánea; posición en la literatura; conexiones; enlaza [[conceptos]] desde aquí>

## 2. Fundamentos
> [!info] Definición (<concepto> — autor, año)
> <definición formal y autocontenida: marco, objetos, condiciones, hipótesis>

> [!note] Observación
> <intuición / aclaración>

## 3. Cuerpo principal
> [!success] Resultado (<nombre>, año)
> <hipótesis ↔ conclusión; justificación o esbozo (declarado como tal) con referencias>

> [!tip] Afirmación / Corolario / Caso particular
> <enunciado con hipótesis explícitas>

## 4. Diagramas y visualización
<Mermaid o el motor de diagramas disponible; ver "Diagramas" abajo>

## 5. Ejemplos resueltos
> [!example] Ejemplo (Básico/Intermedio/Avanzado)
> <enunciado + solución paso a paso + interpretación>

## 6. Ejercicios propuestos
> [!question] Ejercicio (Nivel)
> <enunciado autocontenido>
> [!note]- Solución
> <desarrollo completo, justificado>

## 7. Conexiones
- <viñetas que enlazan [[conceptos]] del vault y explican la relación>

## 8. Referencias
- Autor (año), *Título*, editorial/fuente.

---

**Fuente:** <fuentes reales / origen>

*Generado por Claude — <YYYY-MM-DD>*
```

## Mapa de entornos → callouts de Obsidian

| Entorno | Callout | Entorno | Callout |
|---|---|---|---|
| Historia | `[!quote]` | Ejemplo | `[!example]` |
| Definición | `[!info]` | Ejercicio | `[!question]` |
| Resultado | `[!success]` | Solución | `[!note]-` (plegable) |
| Afirmación / Resultado clave | `[!tip]` | Observación | `[!note]` |
| Caso particular / Corolario | `[!success]` / `[!tip]` | Advertencia / estado epistémico | `[!warning]` |

## Diagramas
- **Mermaid** (nativo en Obsidian) para grafos/flujos/dependencias: bloques ```mermaid … ```.
- Si `{{LATEX}}`=on y el vault tiene un motor de diagramas adicional (p. ej. TikZ vía plugin), úsalo para diagramas técnicos; simplificar si el soporte es parcial.
- Notación del dominio inline (LaTeX `$…$`, `$$…$$` si `{{LATEX}}`=on).

## Enlaces y relaciones (lo esencial de este skill)
1. **Identificar** todos los conceptos del vault que el tema toca (revisar `Conceptos/`).
2. **`relacionado`** en el frontmatter: incluir el Índice + esos conceptos.
3. **Wikilinks inline**: enlazar los conceptos la primera vez que aparecen en definiciones, resultados y ejemplos.
4. **Sección `## Conexiones`**: viñetas que expliciten la relación con cada concepto enlazado.
5. **Índice MOC**: añadir la nota en `Índice de Conceptos` (sección «Guías fuente» o `Índice de Guías`) según el área temática.
6. **Backlinks opcionales**: añadir un enlace a la guía desde las Conexiones de los 1-3 conceptos más centrales.
7. **Solo enlaces que existan**: nunca dejar wikilinks rotos; si un concepto no tiene nota, dejarlo en texto plano o proponer crearlo (con `guardar-concepto`).

## Estándares
- Idioma `{{IDIOMA}}` + notación del dominio; rigor de nivel `{{NIVEL}}`.
- Justificaciones completas salvo «esbozo» (declarado); atribuciones históricas correctas.
- Ejemplos graduados (≥5: Básico→Intermedio→Avanzado); ejercicios (5–10) con solución plegable.
- Sin ambigüedad en afirmaciones técnicas; marcar resultados abiertos con `[!warning]` ⚠.

## Verificación
- **0 enlaces rotos** en el vault:
  ```bash
  cd "{{VAULT_PATH}}"
  grep -rho "\[\[[^]]*\]\]" --include="*.md" . | sed 's/\[\[//; s/\]\]//; s/|.*//; s/#.*//' | sort -u | \
    while read -r l; do [ -z "$(find . -path ./Plantillas -prune -o -name "${l}.md" -print 2>/dev/null)" ] && echo "ROTO -> [[$l]]"; done
  ```
- La nota tiene frontmatter, H1, definiciones/resultados/ejemplos y `## Conexiones`.
- El `relacionado` y los wikilinks inline cubren los conceptos relevantes; la nota aparece en el Índice.

## Checklist
- [ ] Frontmatter Obsidian con `relacionado` poblado de conceptos reales.
- [ ] Roadmap en `[!abstract]`.
- [ ] Definiciones en `[!info]`, resultados en `[!success]`, ejemplos en `[!example]`, ejercicios en `[!question]` + soluciones `[!note]-`.
- [ ] Diagramas (mermaid/otro) si aplica.
- [ ] ≥5 ejemplos graduados y 5–10 ejercicios con solución.
- [ ] Sección `## Conexiones` con relaciones explicadas.
- [ ] Nota añadida al Índice MOC; backlinks opcionales desde conceptos centrales.
- [ ] 0 enlaces rotos; referencias reales; footer.
