# Second Brain Template

> LLM-agent-powered Obsidian vault. Clone and start thinking.

A pre-configured Obsidian vault that uses AI coding agents to automate knowledge management. Based on the **Karpathy 3-Layer Architecture** (Raw → Wiki → Graph) and **PARA** folder structure. Works with **Claude Code, Codex, Cursor, and Antigravity**.

## What You Get

- **Karpathy 3-Layer** knowledge architecture (Raw → Wiki → Graph)
- **PARA** folder structure with agent navigation
- **2 Agent Skills** — vault-doctor (diagnostics), skill-forge (create new skills)
- **1 agent persona** — vault-specialist
- **Cross-tool compatibility** — `.agents/` works across Claude Code, Codex, Cursor, Antigravity
- **Project document templates** — PRD, ARCHITECTURE, DECISIONS, etc.
- **Tag and frontmatter** enforcement rules

## Architecture

```
┌─────────────────────────────────────────────────┐
│                  Graph Layer                     │
│         wikilink connections + MOCs              │
│         (auto-strengthened by obsidian-forge)    │
├─────────────────────────────────────────────────┤
│                  Wiki Layer                      │
│           10-Zettelkasten/                       │
│      Refined atomic concept notes                │
│           (manual curation)                      │
├─────────────────────────────────────────────────┤
│                  Raw Layer                       │
│   99-Archives/projects/ · 00-Inbox/ · 02-Areas/ │
│        Project docs, captures, areas             │
│           (git sync + of process-all)            │
└─────────────────────────────────────────────────┘
```

**Content flow:** Raw → Wiki (manual refinement) → Graph (automated)

## Quick Start

### 1. Use This Template

Click **"Use this template"** → **"Create a new repository"** on GitHub, or:

```bash
gh repo create my-second-brain --template epicsagas/SecondBrain-Template --clone
cd my-second-brain
```

### 2. Run Setup

```bash
chmod +x setup.sh
./setup.sh "MySecondBrain"
```

This:
- Replaces `{{VAULT_NAME}}` placeholders
- Creates cross-tool symlinks (`.claude/` → `.agents/`)
- Initializes git

### 3. Install Prerequisites

| Component | Install | Purpose |
|-----------|---------|---------|
| [Claude Code](https://docs.anthropic.com/en/docs/claude-code) | `npm install -g @anthropics/claude-code` | LLM agent |
| [obsidian-forge](https://github.com/epicsagas/obsidian-forge) | `cargo install obsidian-forge` | Vault automation daemon |
| [vault-doctor](https://github.com/epicsagas/vault-doctor) | `npm install -g vault-doctor` | Vault health diagnostics |
| [Obsidian](https://obsidian.md) | Download from obsidian.md | Note-taking app |

### 4. Open in Obsidian

Open the cloned folder as a vault in Obsidian. Install the [Dataview](https://blacksmithgu.github.io/obsidian-dataview/) community plugin for `Home.md` queries.

### 5. Start Your Agent

```bash
# Any of these works:
claude          # Claude Code
codex           # OpenAI Codex
agy             # Antigravity
# Or open in Cursor IDE
```

## Folder Structure

```
├── .agents/                    # Agent infrastructure (source of truth)
│   ├── skills/                 #   SKILL.md files (Agent Skills Open Standard)
│   ├── agents/                 #   Agent personas (YAML frontmatter + Markdown)
│   └── rules/                  #   Vault conventions
├── .claude/                    # Claude Code config (symlinks to .agents/)
│   └── settings.local.json     #   Permissions
├── .codex/                     # Codex-specific config
│   └── agents/                 #   Agent definitions (TOML format)
├── 00-Inbox/                   # Capture zone
├── 01-Projects/                # Active projects
├── 02-Areas/                   # Ongoing interest areas
├── 03-Resources/               # Reference materials
├── 04-Writing/                 # Writing projects
├── 10-Zettelkasten/            # Permanent concept notes (Wiki layer)
├── 99-Archives/projects/       # All project docs (active + inactive)
├── _template/                  # New project scaffolding
├── scripts/                    # Automation scripts
├── AGENTS.md                   # Agent instructions (read by all tools)
├── CLAUDE.md                   # Entry point → delegates to AGENTS.md
├── TAGGING.md                  # Tag and frontmatter rules
├── vault.toml                  # obsidian-forge configuration
├── index.md                    # Agent navigation (static, no Dataview)
└── Home.md                     # Obsidian dashboard (Dataview queries)
```

## Cross-Tool Compatibility

All agent infrastructure lives in `.agents/`. `setup.sh` creates symlinks so each tool discovers it:

| Tool | How it finds skills | How it finds agents |
|------|--------------------|--------------------|
| **Claude Code** | `.claude/skills/` → symlink → `.agents/skills/` | `.claude/agents/` → symlink → `.agents/agents/` |
| **OpenAI Codex** | `.claude/skills/` (reads natively) | `.codex/agents/` (TOML format) |
| **Cursor** | reads `.claude/skills/` natively | reads `.claude/agents/` natively |
| **Antigravity** | reads `.agents/skills/` natively | (not yet supported) |

### Why `.agents/`?

`.agents/` is the [Agent Skills Open Standard](https://agentskills.io) location. It's the only path that all four tools can agree on:
- Antigravity reads it natively
- Claude Code, Codex, Cursor read it via symlinks

## Included Skills

| Skill | Trigger | Description |
|-------|---------|-------------|
| vault-doctor | "scan vault", "fix vault", `/vault-scan`, `/vault-fix` | Diagnostics and auto-fix |
| skill-forge | "skill create", "skill audit", `/skill-forge` | Create and optimize skills |
| vault-specialist | (agent persona) | Full vault health workflows |

## Customization

### Add Domain Concepts

Edit `vault.toml` `[graph].concepts` array:

```toml
concepts = [
  { name = "Machine Learning", keywords = ["ml", "neural network"], tags = ["ml"] },
]
```

### Add New Skills

```bash
claude
> /skill-forge create
```

Skills are saved to `.agents/skills/` and automatically available to all tools via symlinks.

### Change Language

Edit `AGENTS.md` → "Language Rules" section. Default is English for agent-facing files.

### Configure AI Model

Edit `vault.toml` → `[ai]` section:

```toml
[ai]
model = "claude-sonnet-4-20250514"
max_concurrent = 5
```

## Creating a New Project

Copy `_template/` to `99-Archives/projects/{name}/`:

```bash
cp -r _template/ 99-Archives/projects/my-project/
cd 99-Archives/projects/my-project
# Replace {{project}} with your project name in all files
```

Or use obsidian-forge: `of init-project my-project`

## Methodology References

| Method | Role in Vault | Layer |
|--------|--------------|-------|
| [PARA](https://fortelabs.com/blog/para/) | Folder structure (Projects/Areas/Resources/Archives) | Organization |
| [Zettelkasten](https://zettelkasten.de/introduction/) | Atomic concept notes in `10-Zettelkasten/` | Wiki |
| [LLM Wiki](https://gist.github.com/karpathy/b3362274993e5f55ef2dd19e420dff98) | Raw → Wiki → Graph compilation pattern | Automation |

## License

MIT
