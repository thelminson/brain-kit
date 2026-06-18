# brain-kit

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Built for Claude Code](https://img.shields.io/badge/Claude%20Code-agents%20%2B%20skills-8A2BE2)](https://claude.com/claude-code)
[![Obsidian](https://img.shields.io/badge/Obsidian-vault-7C3AED?logo=obsidian&logoColor=white)](https://obsidian.md)
[![Domain-agnostic](https://img.shields.io/badge/domain-agnostic-success)](dominio.config.md)
[![PRs welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](#)

> Un **sistema de investigación y conocimiento para Claude Code** —agentes, skills, estructura y convenciones— extraído de un vault doctoral de matemáticas y **generalizado para cualquier área** (biología, derecho, finanzas, ingeniería, humanidades…).

`brain-kit` convierte una carpeta vacía en un **"segundo cerebro" operativo**: un vault tipo Obsidian con notas atómicas, líneas de investigación, guías, fuentes citadas e índices (MOC), gestionado por una **flota de agentes** y un **catálogo de skills** que capturan, investigan, redactan, revisan, producen y mantienen el conocimiento — todo con convenciones estrictas (frontmatter, wikilinks sin rotos, bitácoras, trazabilidad de fuentes).

No es un plugin de Obsidian (JS): es una **plantilla de proyecto para Claude Code** (`.claude/agents`, `.claude/skills`, hooks) + un **esqueleto de vault** + un `setup.sh` que lo instancia para tu dominio.

---

## Qué incluye

```
brain-kit/
├── README.md                 ← este archivo
├── dominio.config.md         ← declaras tu área, idioma, herramientas (lo edita setup.sh)
├── setup.sh                  ← instancia el kit: rellena placeholders y crea el vault
├── .claude/
│   ├── settings.json         ← hooks (carga de contexto al iniciar sesión)
│   ├── claude_hook_start.sh  ← banner + estadísticas + notas recientes
│   ├── agents/               ← 7 agentes especialistas (genéricos)
│   └── skills/               ← 13 skills (captura · investigación · mantenimiento · salida)
├── Conceptos/  Investigación/  Guías/  Fuentes/  Resultados de búsqueda/
├── Plantillas/               ← plantillas de cada tipo de nota
├── Agentes/  Skills/          ← copias documentales (MOC) de agentes y skills
└── docs/                     ← ARQUITECTURA · CONVENCIONES · PIPELINE
```

### Los 7 agentes (flota)
| Agente | Rol |
|---|---|
| **director** | *Playbook* de orquestación del pipeline: descubrir → desarrollar → revisar → producir → guardar. |
| **investigador** | Investigación web **citada** y descubrimiento de huecos publicables; archiva resultados (`RB-NNNN`). |
| **redactor** | Especialista del dominio que **redacta** contenido riguroso (conceptos, líneas, guías, borradores). |
| **revisor** | Revisión **adversarial** de la corrección del contenido; opción de **segunda opinión** independiente. |
| **guardian** | *Linter* del vault: 0 enlaces rotos, índices/MOC, bitácoras, frontmatter, formato de fuentes. |
| **publicador** | Produce el **entregable** pulido (PDF/LaTeX, informe, web…). |
| **analista-fuentes** | Audita un **artefacto externo** del dominio (repo, dataset, corpus, expediente) y lo documenta. |

### Las 13 skills
**Captura:** `guardar-concepto` · `crear-nota-investigacion` · `nota-avanzada` · `redactar-documento` · `notas-didacticas` · `formalizar-rigor`
**Corpus:** `catalogar-fuentes` · `minar-corpus`
**Investigación:** `buscar-web` · `segunda-opinion`
**Mantenimiento:** `renombrar-backlinks`
**Salida:** `proponer-problemas-pdf` · `notificar`

---

## Filosofía (las 6 reglas)

1. **Una nota = una idea** (atómica, estilo Zettelkasten); todo enlazado por wikilinks.
2. **Cero enlaces rotos**: solo se enlaza a notas que existen; cada nota nueva se integra en su índice (MOC).
3. **Trazabilidad**: toda afirmación con fuente verificable; las búsquedas se archivan (`RB-NNNN`) con sus fuentes.
4. **Rigor + honestidad**: hipótesis y alcance explícitos; los problemas abiertos se declaran como tales; no se inventan fuentes ni resultados.
5. **Bitácora**: cada nota registra su historia de cambios.
6. **Verificación adversarial**: lo importante se revisa para *encontrar errores*, no para validar (con segunda opinión cuando aporta).

Estas reglas son **independientes del dominio**: lo único que cambia es el vocabulario (que `setup.sh` adapta).

---

## Instalación rápida

```bash
cd brain-kit
# 1) Edita dominio.config.md con tu área, idioma y herramientas
# 2) Instancia:
bash setup.sh
```

`setup.sh` rellena los placeholders (`{{DOMINIO}}`, `{{IDIOMA}}`, `{{VAULT_PATH}}`, …) en agentes, skills y docs, crea el esqueleto del vault y deja todo listo para abrir con Claude Code (y, si quieres, Obsidian).

Luego, en Claude Code dentro de la carpeta:
- *"crea un concepto de …"* → `guardar-concepto`
- *"crea una nota de investigación sobre …"* → `crear-nota-investigacion`
- *"busca y cita fuentes sobre …"* → agente `investigador`
- *"genera un pdf con los problemas de estos artículos"* → `proponer-problemas-pdf`
- *"pasa el guardián"* → agente `guardian`

---

## Placeholders (los rellena `setup.sh`)

| Placeholder | Significado | Ejemplo |
|---|---|---|
| `{{DOMINIO}}` | Tu área | `biología molecular` |
| `{{DOMINIO_ADJ}}` | Adjetivo del área | `biológico` |
| `{{NIVEL}}` | Nivel de rigor esperado | `investigación / experto` |
| `{{IDIOMA}}` | Idioma de las notas | `español` |
| `{{VAULT_PATH}}` | Ruta absoluta del vault | `/Users/tu/Desktop/Bio-Brain` |
| `{{WEB_SEARCH}}` `{{LLM_2A_OPINION}}` `{{LATEX}}` `{{NOTIFY}}` | Herramientas disponibles (on/off + cómo) | ver `dominio.config.md` |

---

*Generado a partir de un sistema real de investigación doctoral. Adáptalo, recórtalo y hazlo tuyo.*
