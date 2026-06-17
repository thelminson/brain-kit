# Pipeline editorial

El agente **director** es el *playbook* que el hilo principal ejecuta delegando en los especialistas. Dos modos.

## Modo A — Descubrimiento
*Disparador:* «busca temas/huecos publicables sobre [tema]».
```
investigador (huecos + N candidatos con resumen + pre-prioridad) → archiva RB-NNNN → (notificar, si NOTIFY=on)
```
Salida: lista de candidatos rankeados.

## Modo B — Desarrollo (de un candidato elegido)
*Disparador:* «desarrolla el #N [para REVISTA/entregable]». Secuencia **con gates** (no avanzar si un gate falla):
1. **investigador** → cierra prioridad (`RB-NNNN`). 🚦 Si hay **colisión**, avisar y parar.
2. **redactor** → nota de investigación + desarrollo (guía) + borrador.
3. **revisor** → revisión adversarial (+ segunda opinión). 🚦 Corregir hallazgos graves antes de seguir.
4. **publicador** → entregable (PDF/LaTeX o Markdown). 🚦 Compila/valida sin errores.
5. **revisor** (pasada final) + **guardian** → integridad (0 enlaces rotos, índices, bitácoras).

Salida: **entregable listo + informe de revisión**.

## Reglas de coordinación
- Cada fase deja **bitácora**; se reporta el estado tras cada gate.
- El usuario puede entrar por **cualquier fase suelta** (solo revisión, solo PDF, solo guardián); el director encadena solo cuando se pide el pipeline completo.
- Herramientas externas (`WEB_SEARCH_EXTRA`, `LLM_2A_OPINION`, `NOTIFY`) **solo si están `on`** en `dominio.config.md`.

## Patrón de descubrimiento de problemas
Para proponer problemas de investigación a partir de una carpeta de fuentes:
```
analista-fuentes / lectura paralela  →  síntesis (fuentes interesantes + hueco unificador)
  →  proponer-problemas-pdf (dossier)  →  investigador (cierre de prioridad)  →  crear-nota-investigacion
```
