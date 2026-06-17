---
name: guardar-concepto
description: >-
  Crea y guarda una nota de concepto atómico en la carpeta `Conceptos/` del vault,
  siguiendo su plantilla (Historia, Definición formal, Interpretación, Por qué importa,
  Ejemplos, Conexiones), la integra en el Índice MOC y verifica que no haya enlaces
  rotos. Úsalo cuando el usuario pida "guardar / crear / agregar un concepto" en
  Conceptos, o añadir al vault un concepto extraído de un paper, web o documento.
---

# Skill: Guardar un concepto en el vault

Flujo para añadir un **concepto atómico** a `Conceptos/` del vault, respetando sus convenciones.

> **Ruta base del vault:** `{{VAULT_PATH}}`
> **Carpeta destino:** `Conceptos/<Título exacto>.md`

## Cuándo usar
- El usuario pide guardar/crear/agregar **un concepto** del dominio `{{DOMINIO}}` en `Conceptos`.
- El usuario pide volcar al vault un concepto extraído de una fuente (paper, web, PDF).

## Activadores

Frases o peticiones que lo disparan:
- "guarda / crea / agrega **un concepto** en Conceptos"
- "añade a mi vault el concepto …"
- "guarda en Conceptos: …"
- volcar **un** concepto desde un paper, web o PDF a una nota atómica

## Principios
- **Una nota = un concepto** (estilo Zettelkasten, atómico).
- Todo en **`{{IDIOMA}}`** y con la **notación del dominio** (LaTeX `$…$`, `$$…$$` si `{{LATEX}}`=on).
- **Rigor alto** acorde al nivel `{{NIVEL}}`: declarar el marco/objetos con precisión (dominios, condiciones, hipótesis), y los resultados con afirmación ↔ conclusión separadas.
- **Atribuciones históricas correctas** (autor, año); no inventar fechas — si hay duda, usar el autor o el periodo.
- Si hay **fuente**, leerla/extraerla primero; si no, usar conocimiento estándar verificable.

## Plantilla obligatoria

```markdown
---
title: "<Título>"
date: <YYYY-MM-DD>
tags:
  - {{DOMINIO}}
  - <2-4 tags temáticos>
type: concepto
status: procesado
aliases:
  - <2-4 alias, incluye el nombre en otro idioma si aplica>
relacionado:
  - "[[Índice de Conceptos]]"
  - "[[<1-4 notas relacionadas existentes>]]"
---

# <Título>

> [!quote] Historia
> <2-5 frases: quién lo introdujo, año/periodo, contexto de origen y evolución>

> [!info] Definición (<concepto> — autor, año)
> <definición formal: declara el marco, los objetos y las hipótesis/condiciones con precisión>

> [!note] Interpretación
> <intuición operativa o visual>

## Por qué importa

> [!tip] Resultado clave
> <resultado/propiedad central, con afirmación y conclusión>

## Ejemplos

> [!example] <título>
> <ejemplo concreto, caso ilustrativo o contraejemplo>

## Conexiones

- <2-4 viñetas enlazando con [[notas existentes]]>

---

**Fuente:** <referencias reales: autor (año), título>

## 🧠 Bitácora

> [!note] Registro de la nota
> - <YYYY-MM-DD> — Nota creada.
> - <al ampliar/corregir/reestructurar el concepto: una línea fechada con qué cambió y por qué>

*Generado por Claude — <YYYY-MM-DD>*
```

## Pasos
1. **Redactar** la nota con la plantilla, rigurosa y correcta.
2. **Wikilinks**: enlazar SOLO a notas que existan (o a otras que se estén creando en el mismo lote). Nunca dejar enlaces rotos ni inventar destinos.
3. **Índice MOC**: añadir una entrada en `Conceptos/Índice de Conceptos.md`, bajo la sección temática correcta. Si no encaja en ninguna, crear una sección nueva breve.
4. **Si se renombra o divide** una nota: usar `renombrar-backlinks` para reescribir TODOS los backlinks del vault y dejar el nombre antiguo como **alias** (por sistema de archivos hay que hacerlo a mano).

## Verificación (siempre)
- **0 enlaces rotos** en la(s) nota(s) y en el índice. Comando de comprobación:
  ```bash
  cd "{{VAULT_PATH}}"
  grep -o "\[\[[^]]*\]\]" "<archivo>.md" | sed 's/\[\[//; s/\]\]//; s/|.*//; s/#.*//' | sort -u | \
  while IFS= read -r l; do [ -z "$l" ] && continue; \
  [ -z "$(find . -path ./Plantillas -prune -o -name "${l}.md" -print 2>/dev/null)" ] && echo "ROTO -> [[$l]]"; done
  ```
- La nota tiene frontmatter, H1, **Historia**, **Ejemplos**, **🧠 Bitácora** (con la entrada de creación fechada) y footer.
- Reportar al usuario qué se creó, dónde, y señalar con honestidad cualquier atribución o afirmación que convenga revisar.

## Escala (muchos conceptos a la vez)
- Para crear/editar **muchas notas**, repartir el trabajo en **agentes en paralelo por área temática**, dándole a cada agente:
  - la plantilla exacta,
  - la **lista completa de títulos permitidos** (existentes + los nuevos del lote) para que los wikilinks resuelvan al completarse,
  - reglas de preservación (no tocar frontmatter/historia/ejemplos/enlaces ajenos al objetivo).
- Después, **consolidar el Índice** de forma centralizada y ejecutar la verificación global de enlaces.

## Notas
- Tipos de nota relacionados: `type: concepto` (atómica), `type: referencia` (catálogo/biblioteca), `type: investigación` (líneas de trabajo, en `Investigación/`), `type: moc` (el índice).
- Plantillas vivas del vault: `Plantillas/Concepto.md` y `Plantillas/Investigación.md`.
- Skills relacionados: `crear-nota-investigacion`, `nota-avanzada`, `formalizar-rigor`, `renombrar-backlinks`, `catalogar-fuentes`, `minar-corpus`.
