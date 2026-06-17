---
name: crear-nota-investigacion
description: >-
  Crea una nota de línea de investigación / problema abierto en `Investigación/` del
  vault, con la plantilla de investigación (Pregunta/conjetura, Motivación, Planteamiento
  formal, Definiciones/resultados a usar, Conceptos asociados, Estado del arte y genealogía,
  Plan de acción, Fuentes, Bitácora) y, si procede, un Plan de documento. Úsalo cuando el
  usuario pida crear una nota de investigación, formalizar una pregunta abierta o esbozar
  un documento/proyecto.
---

# Skill: Crear nota de investigación

> **Vault:** `{{VAULT_PATH}}`
> **Carpeta destino:** `Investigación/<Título>.md` (`type: investigación`, `status: en-curso`)

## Cuándo usar
- El usuario pide una **nota de investigación**, una **pregunta abierta** formalizada o una hoja de ruta de documento/proyecto.

## Activadores

Frases o peticiones que lo disparan:
- "crea una **nota de investigación**"
- "formaliza este **problema / pregunta abierta**"
- "esboza un **documento / línea de proyecto**"
- "agrégalo a Investigación"

## Filosofía de la nota
Una nota de investigación no es un *tema*, es un **problema atacable**. Debe dejar claro, a quien la lea en frío: (1) qué se pregunta con precisión, (2) **sobre qué objetos formales** y con qué maquinaria, (3) **de qué desciende** y **quién más lo ha tocado**, y (4) cuál es el primer paso. Los cuatro bloques densos —Planteamiento formal, Maquinaria, Estado del arte/genealogía, Plan— son obligatorios y son lo que distingue esta nota de un simple recordatorio.

## Plantilla
> La plantilla canónica vive en `Plantillas/Investigación.md`. Esta es su forma; mantenlas sincronizadas.

```markdown
---
title: "<Título>"
date: <YYYY-MM-DD>
tags: [investigación, {{DOMINIO}}, <tema>]
type: investigación
status: en-curso
aliases: [<2-3 alias, incluye otro idioma si aplica>]
relacionado:
  - "[[Índice de Conceptos]]"
  - "[[<conceptos asociados existentes>]]"
---

# <Título>

> [!question] Pregunta / conjetura
> <conjetura precisa, en notación del dominio (LaTeX si {{LATEX}}=on); una afirmación falsable, no un tema>

> [!abstract] Motivación y contexto
> <por qué importa, en qué línea se inscribe, qué hueco llena>

---

## 📐 Planteamiento formal
> [!info] Marco y notación
> <marco/contexto, objetos, condiciones; qué es dato y qué incógnita>
> [!info] Definición (objeto central)
> <definición formal autocontenida del objeto que el problema introduce/estudia>
> [!note] Formulación precisa
> <la conjetura como afirmación cerrada hipótesis ⇒ tesis; caso general vs. caso modelo>

---

## 📎 Definiciones, resultados y afirmaciones a usar
> [!info] Maquinaria que se asume (herramientas de entrada)
> - **Def./Resultado** <nombre> (<autor, año>) — <enunciado en una línea + para qué>
> [!todo] Resultados objetivo (lo que se quiere probar/establecer)
> - **Objetivo 1.** <enunciado tentativo>

---

## 🔗 Conceptos asociados
> [!info] Notas atómicas del vault de las que depende
> - [[<concepto>]] — <para qué>

---

## 🧬 Estado del arte y genealogía
> [!quote] ¿Qué investigación la precede?
> <línea genealógica: de qué resultados/escuelas/programas desciende el problema>
> [!cite] ¿Quién ha planteado el problema? (autores · fuentes · publicaciones)
> - <Autor (año), Título, fuente — qué resolvió, qué dejó abierto>  // o "sin trabajo previo directo; búsquedas: <…>"
> [!warning] Veredicto de novedad
> <HUECO GENUINO | PARCIALMENTE ABORDADO | RESUELTO/REENFOCAR + justificación de una línea>

---

## 🎯 Plan de acción
> [!todo] Pasos
> - [ ] Paso 1 — …
### Hipótesis y resultado esperado
- …
### Riesgos / obstáculos
- … (incluye riesgo de prioridad/duplicación)

---

## 📚 Fuentes y referencias a consultar
> [!cite] Bibliografía
> - [ ] Autor (año), *Título* — <qué aporta>
### Pendiente de leer
- [ ] …

---

## 🧠 Bitácora de avance
> [!note] Registro
> - <YYYY-MM-DD> — Nota creada. <idea inicial + qué se verificó>

---

**Estado:** en curso · *próxima acción:* <—>

*Generado por Claude — <YYYY-MM-DD>*
```

## Reglas por bloque

**📐 Planteamiento formal.** No basta nombrar el tema: define los **objetos formales** con callouts `[!info]` (marco, condiciones, hipótesis), fija notación y **reescribe la conjetura como afirmación cerrada** (hipótesis ⇒ tesis). Si el caso general es duro, declara el **caso modelo** que se ataca primero.

**📎 Definiciones, resultados y afirmaciones a usar.** Separa explícitamente:
- *Maquinaria de entrada* (lo que se **asume** como caja negra) — enuncia en una línea + cita (autor, año).
- *Resultados objetivo* (lo que se quiere **probar/establecer**) — en orden lógico; cada uno debe poder volverse un resultado del documento.
Esta distinción asumido/objetivo es obligatoria.

**🧬 Estado del arte y genealogía** (bloque crítico):
- *¿Qué la precede?* — la **cadena genealógica** del problema (resultados/escuelas/programas de los que desciende), distinta de la bibliografía suelta.
- *¿Quién lo ha planteado?* — **investiga la literatura** (delega en el agente `investigador` o el skill `buscar-web`; o `WebSearch`/`WebFetch`. No inventes citas) y reporta autores, grupos y **fuentes/publicaciones** que hayan tocado el problema o casos parciales, con autor-año-fuente y **qué dejaron abierto**. Si no hay trabajo previo, dilo y **deja constancia de las búsquedas** (términos, fecha).
- *Veredicto de novedad* — marca `HUECO GENUINO` / `PARCIALMENTE ABORDADO` / `RESUELTO-REENFOCAR` en `[!warning]`, justificado. **Antes de afirmar "hueco genuino", verifica**; cuidado con falsos positivos (términos homónimos que significan cosas distintas en subcampos).

**General.**
- **Conceptos asociados** y enlaces: solo a notas **existentes**; no inventar destinos rotos. Si falta un concepto clave, proponer crearlo con `guardar-concepto`.
- Referencias **reales** (nunca inventadas); rigor acorde a `{{NIVEL}}`; notación del dominio e idioma `{{IDIOMA}}`.
- Si es un **documento líder**, añadir `## 📄 Plan de documento` (objeto central, resultados objetivo con bosquejo, estructura, ejemplos por caso, **destinos/audiencia objetivo**, cronograma).
- Si la línea ya tiene desarrollo extenso (definiciones+resultados+justificaciones+ejemplos), considerar una **nota-guía** en `Guías/` (skill `nota-avanzada`) enlazada bidireccionalmente desde el bloque 📎/🧬.
- Enlazar la nueva nota desde la sección **🧪 Líneas de Investigación** del Índice MOC (`Índice de Investigación`).

## Verificación
- **0 enlaces rotos**; la nota tiene los bloques: Pregunta, Planteamiento formal, Definiciones/resultados a usar, Estado del arte y genealogía (con veredicto), Plan de acción, Fuentes y Bitácora.
- El bloque 🧬 cita fuentes reales o deja constancia explícita de "sin trabajo previo + búsquedas realizadas".
- Maquinaria separada en *asumido* vs *objetivo*.
