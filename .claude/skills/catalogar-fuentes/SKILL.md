---
name: catalogar-fuentes
description: >-
  Verifica una carpeta de fuentes (PDF, documentos) y produce UNA sola nota de referencia
  en el vault que explica cada fuente: archivo, autor, fecha, publicación/origen, conceptos
  (enlazados a las notas del vault) y qué aporta/resuelve. Úsalo cuando el usuario pida
  "verifica esta carpeta y crea una nota que explique cada fuente", catalogar una
  bibliografía o resumir todos los documentos de un directorio. No omitir ninguna fuente.
---

# Skill: Catalogar fuentes en una nota del vault

> **Vault:** `{{VAULT_PATH}}`
> **Config del dominio:** `{{VAULT_PATH}}/.claude/dominio.config.md` (placeholders `{{DOMINIO}}`, `{{DOMINIO_ADJ}}`, `{{NIVEL}}`, `{{IDIOMA}}`, toggles).
> **Destino sugerido:** `Guías/Biblioteca de Fuentes.md` (`type: referencia`). Si **ya existe**: al catalogar una carpeta nueva, *añade* una sección a esa nota (comprueba antes qué archivos ya están fichados; no recrees ni dupliques fichas).

## Cuándo usar
- El usuario pide **verificar una carpeta de fuentes** y crear **una sola nota** que describa cada una.
- Construir/actualizar una bibliografía comentada.
- Esta skill **solo describe** las fuentes en una nota; **no crea** conceptos ni notas de investigación. Para detectar y crear los conceptos/líneas que faltan a partir del corpus, usa `minar-corpus`.

## Activadores

Frases o peticiones que lo disparan:
- "**verifica esta carpeta** de fuentes / documentos / papers"
- "crea **una nota que explique cada fuente**"
- "**cataloga** la bibliografía / estos documentos"
- "resume todos los documentos de esta carpeta"

## Pasos
1. **Inventariar** las fuentes por subcarpeta. Excluir artefactos de build (`.aux .log .out .toc .nav .snm .synctex.gz`), `.git` y, si procede, guías/informes internos (listarlos aparte). Contar el total.
   ```bash
   cd "<carpeta>"; for d in */; do echo "== $d =="; find "$d" -maxdepth 1 -name "*.pdf" | sort; done
   ```
2. **Leer cada fuente** (resumen/abstract + introducción + conclusiones bastan) y producir una ficha. **No omitir ninguna.**
3. **Ensamblar UNA nota**, agrupada por las subcarpetas/áreas y en orden **cronológico**.
4. **Wikilinks**: en el campo *Conceptos*, enlazar solo a notas que existan en el vault; el resto, texto plano.
5. Añadir una sección final de **informes internos/borradores** (si los hay) por completitud.

## Formato de ficha (una por fuente)
```markdown
### <Apellido/Origen> (<fecha>) — <título corto>
- **Archivo:** `<ruta/nombre exacto>`
- **Autor(es)/Origen:** <…>
- **Fecha:** <…>  ·  **Publicado en/Origen:** <revista/editorial/sitio o "—">
- **Conceptos:** [[<notas del vault>]] + términos clave en texto plano
- **Qué aporta:** <2-3 frases: problema abordado y aportación/resultado principal>
```

## Escala
- Repartir la lectura en **agentes en paralelo por subcarpeta** (lotes de ~8-11 fuentes). A cada agente: el formato de ficha exacto y la **lista de títulos de conceptos del vault** para los wikilinks. Luego concatenar las fichas en la nota única.

## Verificación
- Nº de fichas (`### `) == nº de fuentes de contenido. Comprobar:
  ```bash
  grep -c "^### " "<nota>.md"; grep -c "\*\*Archivo:\*\*" "<nota>.md"
  ```
- **0 enlaces rotos** en la nota:
  ```bash
  grep -rho "\[\[[^]]*\]\]" --include="*.md" . | sed 's/\[\[//; s/\]\]//; s/|.*//; s/#.*//' | sort -u | \
    while read -r l; do [ -z "$(find . -path ./Plantillas -prune -o -name "${l}.md" -print 2>/dev/null)" ] && echo "ROTO -> [[$l]]"; done
  ```
- Reportar cobertura y señalar fuentes sin metadatos completos (fecha/origen) o con ambigüedad temática.
