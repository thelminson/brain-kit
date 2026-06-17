---
name: renombrar-backlinks
description: >-
  Renombra o divide notas del vault y reescribe de forma segura TODOS los backlinks del
  vault, preservando el texto de display y dejando el nombre antiguo como alias. Úsalo
  cuando el usuario pida renombrar una nota, separar/dividir un concepto en dos, o
  reorganizar notas que requieran actualizar enlaces.
---

# Skill: Renombrar / dividir notas y reescribir backlinks

> **Vault:** `{{VAULT_PATH}}`
> ⚠️ Obsidian solo auto-actualiza enlaces si el renombrado se hace **dentro de la app**. Por sistema de archivos hay que reescribir los backlinks **a mano**.

## Cuándo usar
- Renombrar una nota; **dividir** un concepto en dos (p. ej. definición vs. tipos); reorganizar manteniendo la red de enlaces intacta.

## Activadores

Frases o peticiones que lo disparan:
- "**renombra** esta nota / estos títulos"
- "**divide / separa** este concepto en dos notas"
- "**reescribe los backlinks**"
- "reorganiza estas notas manteniendo los enlaces"

## Pasos
0. **Red de seguridad (obligatorio):** confirma que el árbol de git está limpio antes de tocar el vault,
   para poder revertir con `git checkout .` si algo sale mal:
   ```bash
   git status --porcelain   # debe estar vacío; si no, avisa y detente o haz commit antes
   ```
1. **Inventariar backlinks** a cada título afectado (cuántos y en qué notas):
   ```bash
   grep -rl "\[\[<Título viejo>" --include="*.md" .
   grep -rho "\[\[<Título viejo>" --include="*.md" . | wc -l
   ```
2. **Reescribir los TARGETS** de los wikilinks en todo el vault (preserva `|display]]` y anclas `#`).
   ⚠️ **Escapado:** usa `|` como delimitador de `sed` y **escapa** en el *patrón* los metacaracteres de
   regex (`. [ ] * \`) y en el *reemplazo* los caracteres `&` y `\`. Si tus títulos contienen `. , ( )` u
   otros símbolos, un `sed` sin escapar puede corromper.
   ```bash
   find . -name "*.md" -not -path "./.obsidian/*" -print0 | xargs -0 sed -i '' \
     -e 's|\[\[<Título viejo escapado>|[[<Título nuevo escapado>|g'
   ```
   Tras ejecutarlo, **inspecciona el diff** (`git diff --stat`) antes de continuar.
3. **Limpiar display redundante** que pueda surgir: `[[X|X]]` → `[[X]]`.
4. **Renombrar el archivo:** `mv "<Título viejo>.md" "<Título nuevo>.md"`.
5. **Actualizar dentro de la nota renombrada:** `title:` del frontmatter, el `# H1`, y los **aliases** (añadir el **nombre viejo como alias** para preservar búsquedas/enlaces; quitar el alias que ahora coincide con el título).
6. Si es una **división**, crear/ajustar la segunda nota y repartir el contenido (una solo definición, otra el resto), con punteros mutuos.
7. Actualizar la(s) línea(s) del **Índice MOC** si describen las notas.

## Verificación (imprescindible)
```bash
cd "{{VAULT_PATH}}"
# 0 enlaces a nombres viejos:
grep -rho "\[\[<Título viejo>" --include="*.md" . | wc -l        # debe ser 0
# 0 display redundante:
grep -rn "\[\[<Título nuevo>|<Título nuevo>\]\]" --include="*.md" .
# 0 enlaces rotos en el vault:
grep -rho "\[\[[^]]*\]\]" --include="*.md" . | sed 's/\[\[//; s/\]\]//; s/|.*//; s/#.*//' | sort -u | \
  while read -r l; do [ -z "$(find . -path ./Plantillas -prune -o -name "${l}.md" -print 2>/dev/null)" ] && echo "ROTO -> [[$l]]"; done
```
- Confirmar que el archivo viejo ya no existe y que el nuevo tiene `title`, `H1` y `aliases` correctos.
- Reportar nº de backlinks reescritos por archivo.
