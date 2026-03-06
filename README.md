# cs-thai 🇹🇭

> Counter-Strike Thai-language sound effects for Claude Code — playful Thai voice reactions for every coding moment.

## Sounds

| Event | File | Description |
|---|---|---|
| Session Start | `ready.mp3` | Plays when Claude Code starts |
| Task Acknowledge | `good-need-backup.mp3` | Plays when you submit a prompt |
| Task Complete | `hahaha.mp3` | Plays when a task finishes |
| Permission | `refuse.mp3` | Plays on notification/permission events |
| Error | `dog.mp3` | Plays on error states |

## Installation

### Via Claude Code plugin

```bash
claude plugin install cs-thai@nutttaro
```

### Via Git

```bash
git clone https://gitlab.com/nutttaro/cs-thai ~/.claude/plugins/cs-thai
```

## CLI

```bash
cs-thai status                 # Show current config
cs-thai volume 0.7             # Set volume (0.0–1.0)
cs-thai toggle session-start   # Enable/disable an event
cs-thai test task-complete     # Play a test sound
```

## Requirements

Audio playback requires one of:
- **macOS**: `afplay` (built-in)
- **Linux**: `paplay`, `pw-play`, or `ffplay`

## Adding Sounds

Drop additional `.mp3`, `.wav`, or `.ogg` files into the appropriate `sounds/<event>/` directory. Multiple files per category are supported — a random one plays each time.

## License

MIT © nutttaro
