---
name: notas-didacticas
description: >-
  Crea la nota de NOTAS DIDÁCTICAS acompañante de un documento existente del vault:
  versión ultra-detallada y didáctica para aprendices, con cada justificación desmenuzada
  paso a paso, callouts de color, notas al docente, errores típicos y mapa de dependencias.
  Instancia `Plantillas/Notas Didácticas.md` junto al documento, enlaza bidireccionalmente
  y verifica enlaces. Úsalo cuando el usuario pida "notas didácticas / versión didáctica /
  para estudiantes / acompañante didáctico" de un documento, o "explícalo paso a paso con
  notas al docente". NO para conceptos atómicos (`guardar-concepto`) ni guías nuevas
  (`nota-avanzada`).
---

# Skill: Notas Didácticas de un Documento

> **Vault:** `{{VAULT_PATH}}`
> **Plantilla:** `Plantillas/Notas Didácticas.md` (instánciala tal cual).
> **Destino:** la **misma carpeta del documento**, `<carpeta>/<Título> — Notas Didácticas.md` (`type: guía`). Vive junto al documento para que ambos se abran de un vistazo.

## Qué produce

Un único `.md` en el vault que **explica el documento como para un aprendiz de nivel inicial-intermedio del dominio**: todo lo que el documento comprime, aquí se despliega. Es el **acompañante didáctico**, no un sustituto: el documento mantiene sus justificaciones en formato compacto; estas notas tienen la versión *ultra-detallada*.

## Cuándo usar
- El usuario pide **notas didácticas / versión didáctica / explicación para aprendices** de un documento concreto del vault.
- "Explica este documento **paso a paso**, con **notas al docente**, sin omitir nada."
- "Crea el **acompañante didáctico** de [documento]."

### Activadores
- "crea/haz las **notas didácticas** de [documento]"
- "una **versión didáctica / para estudiantes** del documento"
- "explica el documento **paso a paso** / **con todo el detalle** / **con notas al docente**"
- "**acompañante didáctico** de [documento]"

### Cuándo NO usar
- Crear un **concepto atómico** → `guardar-concepto`.
- Crear una **guía** nueva (desarrollo de una línea) → `nota-avanzada`.
- **Redactar el documento** mismo → `redactar-documento`.
- Aumentar el **rigor** de notas existentes → `formalizar-rigor`.

## Fuente de entrada (leer ANTES de redactar)
1. **El documento** completo (frontmatter, todas las definiciones, todos los resultados y **todas las justificaciones**, ejemplos, problemas abiertos, referencias). Si es largo, léelo por páginas; **no** redactes a partir de un fragmento.
2. Las **notas de concepto** del vault que el documento enlaza (su `relacionado`), para enlazar correctamente y reutilizar definiciones.
3. Si el documento tiene una versión en otro formato, úsala para fijar enunciados/numeración exactos.
> Si el documento no existe o sus justificaciones están incompletas, **dilo** y propón redactarlo/cerrarlo antes (un acompañante didáctico de contenido incompleto no sirve).

## Convención de colores (callouts) — OBLIGATORIA
Usa los callouts **deliberadamente como código de color**, no al azar:

| Callout | Color | Uso |
|---|---|---|
| `[!info]` | 🟦 azul | Definiciones y marco (rigurosas) |
| `[!success]` | 🟩 verde | Enunciados de resultados/afirmaciones |
| `[!tip]` | 🟩 verde-azulado | Ideas clave, intuición, "la idea en una frase" |
| `[!warning]` | 🟨 amarillo | Sutilezas, hipótesis necesarias, correcciones |
| `[!danger]` | 🟥 rojo | Errores típicos / "no hagas esto" |
| `[!example]` | 🟪 morado | Cálculos concretos y ejemplos |
| `[!note]` / `[!note]-` | ⬜ gris | Observaciones; **justificaciones plegables** |
| `[!quote]+` | ⬛ gris-cita | **Notas al docente** (marca con `👩‍🏫`) |

Las **notas al docente** se escriben siempre así: `> [!quote]+ 👩‍🏫 Nota al docente` + cómo enseñarlo, qué diagrama hacer, dónde tropieza el aprendiz, qué ejercicio poner, el patrón a señalar, la pregunta de evaluación ideal.

## Pasos
1. **Confirmar el documento objetivo** y localizar su carpeta. Leer el documento completo (paso "Fuente de entrada").
2. **Crear el archivo** `<Título> — Notas Didácticas.md` en la carpeta del documento, instanciando `Plantillas/Notas Didácticas.md`. Rellenar frontmatter: `type: guía`, `status`, `aliases` (incluye "… — teaching notes"), `relacionado` (el documento, la línea de investigación, y **todos** los conceptos que el tema toque).
3. **Estructura** (espejo del documento, expandido):
   - `[!abstract] Cómo usar estas notas` (audiencia, requisitos, **leyenda de colores**).
   - `[!quote]+ 👩‍🏫 Nota al docente` con el **arco de todo el contenido en tres frases**.
   - **§0 La idea antes de las definiciones** (motivación + "el personaje nuevo").
   - **§1 Preliminares con lupa** (cada noción del marco, con intuición y un error típico).
   - **Un bloque por resultado** (Def./Afirmación/Resultado), en este patrón fijo: enunciado `[!success]`/`[!info]` → intuición `[!tip]` → **justificación detallada** `[!note]-` (ver Reglas) → sutileza `[!warning]` → mini-cálculo `[!example]` → `[!quote]+` nota al docente.
   - **Ejemplos** del documento, desarrollados (incluida la **recuperación del caso clásico/límite** como control de calidad, y los casos extremos).
   - **Mapa de dependencias** en `mermaid` (qué resultado usa cuál; de dónde cuelga el problema abierto).
   - **Conexiones** (viñetas con `[[enlaces]]` explicados) + **Fuente** + footer.
4. **Justificaciones (lo esencial del skill):** trasladar **cada** justificación del documento a su versión didáctica, **más detallada**: justificar **cada paso** (por qué es lícito, qué propiedad/afirmación previa se usa, qué resultado se invoca por nombre), marcar los pasos delicados con sub-callouts (`> > [!danger]` trampa, `> > [!tip]` la clave), cerrar bloques con ✔. **No** te limites a copiar la del documento: añade los pasos intermedios que el documento da por sabidos.
5. **Enlazar e indexar.** (a) Backlink desde el documento: añadir el `[[… — Notas Didácticas]]` a su `relacionado` y un box `[!tip] 📘 Versión didáctica` cerca del encabezado. (b) Actualizar la entrada del documento en el **Índice** correspondiente mencionando el acompañante didáctico. (c) Puntero opcional desde la línea de investigación.
6. **Verificar** (ver abajo).

## Reglas
- Idioma `{{IDIOMA}}` + notación del dominio (LaTeX si `{{LATEX}}`=on). Rigor: las **definiciones** llevan marco, condiciones e hipótesis explícitas (igual que el documento) y **luego** la lectura intuitiva.
- **No omitir nada.** El criterio es: *un aprendiz con los prerrequisitos puede seguir la nota sin consultar otra fuente*. Si un paso del documento dice "es inmediato", aquí se justifica.
- **Dos versiones de cada justificación.** La del documento (compacta) se queda donde está; la de las notas es la **ultra-detallada**. No edites las justificaciones del documento desde este skill.
- **Honestidad.** Si el documento marca un resultado como esbozo/condicional/abierto, las notas lo dicen igual (con `[!warning]`), y explican *qué* falta y *por qué*.
- **Wikilinks solo a notas existentes**; nunca dejar enlaces rotos. Reutiliza los conceptos del vault (no redefinas lo que ya tiene nota propia: enlázalo).
- **Notas al docente en cada sección importante** (mínimo: una en el arco general, una por cada resultado central, una final con "cómo enseñar esto en un curso/seminario").
- ≥1 **mapa de dependencias** (mermaid) y, donde aplique, diagramas descritos en prosa.

## Verificación
- **0 enlaces rotos** (comando estándar del vault: escanear `[[…]]` contra los nombres de archivo y alias, ignorando código inline y comentarios HTML; normalizar Unicode NFC).
- La nota tiene: frontmatter (`type: guía`, `relacionado` poblado), `[!abstract]` con leyenda de colores, el `[!quote]+ 👩‍🏫` del arco, **un bloque por cada resultado del documento** con su justificación detallada, ejemplos (incluida la recuperación del caso clásico/límite), mapa mermaid, `## Conexiones`, Fuente y footer.
- **Cobertura:** cada Definición/Afirmación/Resultado/Ejemplo del documento aparece explicado; ninguna justificación del documento queda sin su versión detallada.
- Backlink en el documento (+ box 📘) y entrada actualizada en el Índice.
- Reportar: ruta de la nota, qué documento explica, qué resultados cubre, y enlaces rotos (debe ser 0).

## Notas
- Tipos del vault: `concepto` (atómica), `guía` (desarrollo / **notas didácticas**), `investigación` (línea), `documento` (borrador), `moc` (índice). Estas notas son `type: guía`.
- Plantilla viva: `Plantillas/Notas Didácticas.md`. Mantener sincronizadas plantilla y este SKILL.
- Skills relacionados: `redactar-documento` (genera el documento fuente), `nota-avanzada`, `guardar-concepto`.
