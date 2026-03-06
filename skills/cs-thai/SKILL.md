---
name: cs-thai
description: Manage Thai sound effects for Claude Code
user_invocable: true
---

# cs-thai Skill

Manage the cs-thai sound effects plugin.

## Commands

- `/cs-thai` — Show current config (volume, enabled events)
- `/cs-thai volume <0.0-1.0>` — Set volume
- `/cs-thai toggle <event>` — Enable or disable an event sound
- `/cs-thai test [category]` — Play a test sound for a category
- `/cs-thai help` — Show usage

## Implementation

Run the CLI script: `bash $CLAUDE_PLUGIN_ROOT/scripts/cs-thai <command> [args]`

Events: `session-start`, `task-acknowledge`, `task-complete`, `error`, `permission`
