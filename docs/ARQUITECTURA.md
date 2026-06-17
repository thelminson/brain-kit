# Arquitectura

`brain-kit` tiene tres capas: **estructura** (el vault), **flota** (agentes) y **catálogo** (skills), unidas por **convenciones** ([CONVENCIONES.md](CONVENCIONES.md)) y orquestadas por un **pipeline** ([PIPELINE.md](PIPELINE.md)).

## 1. Estructura del vault

| Carpeta | Tipo de nota | Para qué |
|---|---|---|
| `Conceptos/` | `concepto` | Notas **atómicas** (una idea por nota), estilo Zettelkasten. |
| `Investigación/` | `investigación` | **Líneas de trabajo / problemas abiertos**: pregunta, plan, estado del arte. |
| `Guías/` | `guía` | **Desarrollos extensos**: teoría + ejemplos + ejercicios; o "desarrollo teórico" de una línea. |
| `Fuentes/` | — | Documentos originales del dominio (PDFs, datasets, expedientes…). |
| `Resultados de búsqueda/` | `resultado-búsqueda` | **`RB-NNNN`**: cada búsqueda externa archivada con su informe y `## Fuentes`. |
| `Plantillas/` | — | Plantillas de cada tipo de nota. |
| `Agentes/` `Skills/` | `agente` `skill` | **Copias documentales** (MOC) de la flota y el catálogo. |

Cada carpeta-contenido tiene un **Índice (MOC)** que enlaza sus notas por tema. El MOC es el mapa de navegación y el punto de integración obligatorio.

## 2. Flota de agentes (`.claude/agents/`)

Roles con **herramientas acotadas** que ejecutan las skills con criterio:

- **director** — protocolo de orquestación (no lanza subagentes; el hilo principal ejecuta el plan).
- **investigador** — investigación citada + descubrimiento de huecos → `RB-NNNN`.
- **redactor** — redacta contenido riguroso del dominio (conceptos, líneas, guías, borradores).
- **revisor** — busca errores adversarialmente; segunda opinión opcional.
- **guardian** — verifica integridad (enlaces, índices, bitácoras, frontmatter, fuentes).
- **publicador** — produce el entregable pulido (PDF/LaTeX, informe).
- **analista-fuentes** — audita un artefacto externo del dominio y lo documenta.

## 3. Catálogo de skills (`.claude/skills/`)

Procedimientos reutilizables que producen un tipo de salida concreto. Ver [Índice de Skills](../Skills/Índice de Skills.md). Se agrupan en **captura**, **corpus**, **investigación**, **mantenimiento** y **salida**.

## Por qué es domain-agnostic

Todo el contenido específico ("teorema", "demostración", "LaTeX/MathJax", "doctoral") está parametrizado con placeholders (`{{DOMINIO}}`, `{{NIVEL}}`, `{{IDIOMA}}`, toggles de herramientas) que `setup.sh` rellena. La **estructura, las convenciones y el pipeline no cambian** entre áreas: lo que cambia es el vocabulario y qué herramientas externas hay disponibles.
