---
name: minar-corpus
description: >-
  Analiza una carpeta/corpus (documentos, informes, catálogos) para identificar los
  conceptos y líneas de investigación que FALTAN en el vault, y luego crea las notas que
  falten en `Conceptos` e `Investigación`. Úsalo cuando el usuario pida "verifica todos
  los archivos de esta carpeta y crea los conceptos/investigación que falten" o expandir
  el vault a partir de un corpus.
---

# Skill: Minar un corpus y crear los conceptos que falten

> **Vault:** `{{VAULT_PATH}}`
> **Config del dominio:** `{{VAULT_PATH}}/.claude/dominio.config.md` (placeholders `{{DOMINIO}}`, `{{DOMINIO_ADJ}}`, `{{NIVEL}}`, `{{IDIOMA}}`, toggles).
> **Plantillas:** `Plantillas/Concepto.md` y `Plantillas/Investigación.md` (instanciar tal cual).

## Cuándo usar
- El usuario pide **minar un corpus** y **crear los conceptos/líneas de investigación que falten** en el vault.
- Esta skill **crea notas nuevas** (Conceptos/Investigación). Para solo *describir* una carpeta de fuentes en una nota de referencia sin generar conceptos, usa `catalogar-fuentes`.

## Activadores

Frases o peticiones que lo disparan:
- "verifica **todos los archivos** y **crea los conceptos que falten**"
- "crea los **conceptos / investigación que falten**"
- "**expande el vault** a partir de este corpus"
- "¿qué conceptos faltan según estos documentos?"

## Pasos
1. **Análisis (delegado, en paralelo).** Lanzar agentes (`analista-fuentes`) que lean los **documentos-síntesis** del corpus (preferir `.tex`/`.md`: catálogos, estados del arte, roadmaps — ya enumeran todo; abrir PDF solo si hace falta). Darles la **lista de los conceptos que YA existen** en el vault para que reporten **solo los huecos**. Cada agente devuelve, en formato fijo:
   - `## CONCEPTOS FALTANTES` — `**Título** | descripción 1-2 líneas | área | fuente`
   - `## LÍNEAS DE INVESTIGACIÓN` — `**Título** | descripción | conceptos asociados | fuente`
2. **Consolidar y deduplicar** las listas; descartar lo que ya cubren las notas existentes.
3. **CONFIRMAR EL ALCANCE con el usuario** antes de crear (el volumen puede ser grande: decenas de notas). Usar `AskUserQuestion` para que elija clusters/temas. Esto es obligatorio si salen >~10 notas.
4. **Crear (delegado, en paralelo por área).** A cada agente: la plantilla `Plantillas/Concepto.md` o `Plantillas/Investigación.md`, y la **lista completa de títulos permitidos** (existentes + todos los nuevos del lote) para que los wikilinks resuelvan al completarse todas. Puede apoyarse en `guardar-concepto` y `crear-nota-investigacion`.
5. **Consolidar los índices** de forma centralizada: añadir los conceptos nuevos a `Conceptos/Índice de Conceptos.md`. **Investigación NO tiene índice propio por defecto**: enlaza las líneas nuevas desde el `relacionado`/Conexiones de las notas afines (o crea `Investigación/Índice de Investigación.md` solo si el usuario lo aprueba).
6. **Verificar** todo (ver abajo).

## Reglas
- Atribuciones e historia **correctas**; rigor de nivel `{{NIVEL}}`; en `{{IDIOMA}}`.
- Excluir build artifacts y `.git`. No omitir áreas del corpus.
- Marcar con honestidad citas recientes o definiciones especializadas a confirmar.

## Verificación
- Nº de archivos creados == nº esperado (comprobar existencia por título).
- **0 enlaces rotos** en todo el vault.
- Cada concepto nuevo cumple la plantilla (Historia + Ejemplos + frontmatter + H1 + footer).
- Reportar cobertura y advertencias.
