# Convenciones (innegociables)

Son las reglas que hacen el sistema fiable y navegable. Aplican a **cualquier dominio**.

## Notas
- **Una nota = una idea** (atómica) en `Conceptos/`. Las líneas de trabajo van a `Investigación/`; los desarrollos largos a `Guías/`.
- **Idioma:** {{IDIOMA}}. Notación/formalismo del dominio según corresponda (LaTeX si `LATEX=on`).
- **Frontmatter** obligatorio por tipo (ver `Plantillas/`): `title`, `date`, `tags`, `type`, `status`, `aliases`, `relacionado`.

## Enlaces
- **Solo wikilinks a notas existentes** → **0 enlaces rotos**. Si falta un concepto, se crea con `guardar-concepto` antes de enlazarlo.
- **Integración en el índice (MOC):** toda nota nueva se registra en el índice de su carpeta, bajo su sección temática.
- Comprobación de enlaces rotos:
  ```bash
  grep -rho "\[\[[^]]*\]\]" --include="*.md" . | sed 's/\[\[//; s/\]\]//; s/|.*//; s/#.*//' | sort -u | \
    while read -r l; do [ -z "$(find . -name "${l}.md" 2>/dev/null | head -1)" ] && echo "ROTO -> [[$l]]"; done
  ```

## Fuentes y trazabilidad
- Afirmaciones con **fuente real y verificable** (autor, año, título, enlace). **Nunca** inventar fuentes ni datos.
- Búsquedas externas → nota **`RB-NNNN`** en `Resultados de búsqueda/` con su informe y una sección final **`## Fuentes`** en formato `Apellido, N. (Año). Título + enlace`, y `grounded: true/false`.
- El contador `RB-NNNN` es el id más alto + 1 (ver el índice de esa carpeta).

## Rigor y honestidad
- Hipótesis, alcance y supuestos **explícitos**; nivel {{NIVEL}}.
- Los **problemas abiertos se declaran como tales**; distinguir lo verificado de la inferencia.
- Recuperar/comprobar **casos límite** cuando aplique.

## Bitácora
- Cada nota de contenido lleva una sección **`## 🧠 Bitácora`** con una entrada fechada por cambio relevante.

## Verificación
- Lo importante se revisa **adversarialmente** (agente `revisor`), buscando errores; **segunda opinión** (`segunda-opinion`) cuando aporta.
- Antes de cerrar un trabajo grande: pasar el agente `guardian` (0 rotos, índices, bitácoras, frontmatter, fuentes).

## Escala
- A gran escala, repartir el trabajo en **agentes en paralelo por área temática** y **consolidar el índice de forma centralizada** al final (evita choques de edición sobre el MOC).
