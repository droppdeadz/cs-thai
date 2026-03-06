# cs-thai 🇹🇭

> Counter-Strike Thai-language sound effects for Claude Code — playful Thai voice reactions for every coding moment.

## Sounds

| Event | Slug | Hook | Sounds | Description |
|---|---|---|---|---|
| Session Start | session-start | `SessionStart` | `letsgo`, `locknload`, `regroup`, `terwin` | Plays when a session begins or resumes |
| Task Acknowledge | task-acknowledge | `UserPromptSubmit` | `ct_affirm`, `ct_inpos`, `ct_point`, `position`, `sprayer` | Plays when you submit a prompt, before Claude processes it |
| Task Complete | task-complete | `Stop` | `ctwin`, `enemydown`, `rescued` | Plays when Claude finishes responding |
| Error | error | `PostToolUseFailure` | `got_shoted`, `mate_down`, `negative`, `nothing_here` | Plays when a tool execution fails |
| Permission | permission | `Notification` | `backup`, `repeat_command` | Plays when Claude needs permission (matched to `permission_prompt`) |
| Subagent Start | subagent-start | `SubagentStart` | `com_getinpos`, `elim`, `vip` | Plays when a subagent is spawned |
| Subagent Stop | subagent-stop | `SubagentStop` | `bombdef`, `bombpl`, `com_go`, `moveout` | Plays when a subagent finishes |
| Session End | session-end | `SessionEnd` | `meeting_point`, `ranaway`, `see_u_later` | Plays when a session terminates |

## Installation

### Via Claude Code plugin

First add the marketplace, then install:

```bash
claude plugin marketplace add https://github.com/nutttaro/cs-thai.git
claude plugin install cs-thai@nutttaro
```

### Via Git

```bash
git clone https://github.com/nutttaro/cs-thai ~/.claude/plugins/cs-thai
```

## CLI

```bash
cs-thai status                 # Show current config
cs-thai volume 0.7             # Set volume (0.0–1.0)
cs-thai toggle session-start   # Enable/disable an event (event slug)
cs-thai test task-complete     # Play a test sound (event slug)
```

## Requirements

Audio playback requires one of:
- **macOS**: `afplay` (built-in)
- **Linux**: `paplay`, `pw-play`, or `ffplay`

## Adding Sounds

Drop additional `.mp3`, `.wav`, or `.ogg` files into the appropriate `sounds/<event>/` directory. Multiple files per category are supported — a random one plays each time.

## License

MIT © nutttaro
