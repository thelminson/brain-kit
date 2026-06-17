---
name: notificar
description: >-
  Envía un mensaje a un canal externo configurado, bajo demanda, SOLO cuando el usuario lo pide
  explícitamente — típicamente al terminar una solicitud con "notifícame", "avísame", "envía la
  notificación", "mándalo al canal" o frase equivalente. Envía exactamente lo que el usuario quiera:
  si indica un texto concreto, ese texto; si no, un resumen claro del resultado de la tarea recién
  realizada. No se activa de forma automática. Requiere {{NOTIFY}} ≠ off.
---

# Skill: Notificar a un canal externo bajo demanda

> **Vault:** `{{VAULT_PATH}}`
> **Config del dominio:** `{{VAULT_PATH}}/.claude/dominio.config.md` (placeholders y toggles, en especial `{{NOTIFY}}`).
> **Carpeta de la skill:** `{{VAULT_PATH}}/.claude/skills/notificar/`

## Disponibilidad (toggle)
- **Esta skill SOLO aplica si `{{NOTIFY}}` ≠ `off`.** Si el toggle está en `off`, no hay canal de notificación configurado: dilo al usuario y no intentes enviar nada.
- El **canal externo de notificación** (su ejecutable/comando, destino y credenciales) se define en `dominio.config.md`. No se nombran servicios concretos aquí: es "el canal de notificación configurado".

## Regla de activación (importante)
- **Solo bajo demanda explícita.** Nunca se activa de forma automática al terminar una tarea.
- Disparadores típicos (al final de una petición o como mensaje aparte):
  - "**notifícame**", "**avísame**", "**envía la notificación**"
  - "**mándalo al canal**", "**envía esto**", "**notifica el resultado**"

## Procedimiento

1. **Comprueba el toggle.** Si `{{NOTIFY}}` = `off`, informa al usuario de que no hay canal configurado y termina.
2. **Determina el contenido del mensaje:**
   - Si el usuario indica un **texto concreto**, envía exactamente ese texto.
   - Si no, redacta un **resumen claro y conciso** del resultado de la tarea recién realizada (qué se hizo, dónde quedó, enlaces/rutas relevantes).
3. **Envía** usando el comando/ejecutable del canal indicado en `dominio.config.md` (vía Bash). La credencial/token vive en el entorno (p. ej. `~/.zshenv`); **nunca** se escribe en el chat ni se pasa como argumento.
4. **Confirma** al usuario que el mensaje se envió (o reporta el error si falló), de forma concisa.

## Notas
- El destino, el ejecutable y el formato admitido (texto plano, Markdown…) se configuran en `dominio.config.md`.
- Cross-reference: agentes como `investigador` pueden, en modo descubrimiento, usar esta skill para enviar una lista de candidatos al canal configurado — siempre bajo demanda.
