---
title: "Índice de Agentes"
date: {{FECHA}}
tags: [agentes, índice, automatización]
type: índice
status: procesado
aliases: [MOC Agentes]
---

# Índice de Agentes — {{DOMINIO}}

> [!abstract] Qué es
> Flota de **agentes especialistas** (subagentes de Claude Code en `.claude/agents/`). Cada uno es un **rol con herramientas acotadas** que usa las skills del catálogo. Las definiciones ejecutables viven en `.claude/agents/<nombre>.md`.

> [!info] El pipeline editorial
> **Descubrimiento:** `investigador` caza huecos → candidatos. **Desarrollo:** `investigador` (prioridad) → `redactor` → `revisor` → `publicador` → `guardian`. El **`director`** es el *playbook* que el hilo principal ejecuta.

## Cuadro de agentes

| Agente | Rol | Herramientas (sugeridas) |
|---|---|---|
| `director` | Playbook de orquestación del pipeline | Read, Grep, Write |
| `investigador` | Investigación web citada + descubrimiento de huecos (`RB-NNNN`) | WebSearch, WebFetch, Bash, Read, Write, Edit, Grep |
| `redactor` | Redacta contenido riguroso de {{DOMINIO}} (conceptos, líneas, guías, borradores) | Read, Write, Edit, Grep, Bash |
| `revisor` | Revisión adversarial de la corrección; segunda opinión opcional | Read, Grep, Bash, Edit |
| `guardian` | Linter del vault (enlaces, índices, bitácoras, frontmatter, fuentes) | Read, Grep, Bash, Edit |
| `publicador` | Produce el entregable (PDF/LaTeX o Markdown) | Read, Write, Edit, Bash, Grep |
| `analista-fuentes` | Audita un artefacto externo de {{DOMINIO}} y lo documenta | Read, Write, Edit, Bash, Grep, WebSearch, WebFetch |

---

*Generado por brain-kit*
