---
title: "Índice de Skills"
date: {{FECHA}}
tags: [skills, índice, automatización]
type: índice
status: procesado
aliases: [MOC Skills]
---

# Índice de Skills — {{DOMINIO}}

> [!abstract] Qué es
> Catálogo de **skills** (procedimientos) en `.claude/skills/<nombre>/SKILL.md`. Lo que dispara cada uno es su campo `description`.

## Cuadro de activadores

| Skill | Se activa cuando pides… | Produce |
|---|---|---|
| `guardar-concepto` | "guarda/crea **un concepto**" | Nota atómica en `Conceptos/` |
| `crear-nota-investigacion` | "crea una **nota de investigación**", formaliza una pregunta abierta | Nota en `Investigación/` |
| `nota-avanzada` | "crea una **guía** / nota avanzada / monografía" | Guía en `Guías/` |
| `redactar-documento` | "redacta/escribe un **documento/artículo/informe**" | Borrador largo en `Guías/` o `Fuentes/` |
| `notas-didacticas` | "versión **didáctica** / explícalo paso a paso" | Nota didáctica acompañante |
| `formalizar-rigor` | "haz más **rigurosas** las definiciones" | Definiciones endurecidas en lote |
| `catalogar-fuentes` | "**cataloga** esta carpeta de fuentes / papers" | Nota-biblioteca con ficha por fuente |
| `minar-corpus` | "**crea los conceptos/líneas que falten** de este corpus" | Conceptos/líneas faltantes + índice |
| `renombrar-backlinks` | "**renombra/divide** esta nota" | Renombrado + backlinks reescritos |
| `buscar-web` | "**busca y cita** fuentes sobre …" (citado) | Informe citado en `Resultados de búsqueda/` (`RB-NNNN`) |
| `segunda-opinion` | "**segunda opinión** / contrasta con otro modelo" (si `LLM_2A_OPINION=on`) | Respuesta/fusión de un LLM externo |
| `proponer-problemas-pdf` | "**genera un pdf** con los problemas de estos artículos" | Dossier (PDF o Markdown) de fuentes + problemas propuestos |
| `notificar` | "**notifica / avísame**" (si `NOTIFY=on`) | Mensaje a un canal externo |

## Cómo se eligen (evitar solapes)
- **Un concepto** → `guardar-concepto`. **Una guía** → `nota-avanzada`. **Una línea/pregunta** → `crear-nota-investigacion`.
- **Carpeta de fuentes**: describirlas → `catalogar-fuentes`; *extraer y crear* lo que falta → `minar-corpus`; *proponer problemas en PDF* → `proponer-problemas-pdf`.
- **Investigación web citada** → `buscar-web` (la maneja el agente `investigador`). **Segunda opinión** es un modificador transversal.

---

*Generado por brain-kit*
