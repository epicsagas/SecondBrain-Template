# Second Brain Template

> LLM-agent-powered Obsidian vault. Clone and start thinking.

A pre-configured Obsidian vault that uses Claude Code agents to automate knowledge management. Based on the **Karpathy 3-Layer Architecture** (Raw → Wiki → Graph) and **PARA** folder structure.

## What You Get

- **Karpathy 3-Layer** knowledge architecture (Raw → Wiki → Graph)
- **PARA** folder structure with agent navigation
- **2 Claude Code skills** — vault-doctor (diagnostics), skill-forge (create new skills)
- **2 slash commands** — `/vault-fix`, `/vault-scan`
- **1 agent persona** — vault-specialist
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

This replaces `{{VAULT_NAME}}` placeholders in `vault.toml`, `index.md`, and `Home.md`.

### 3. Install Prerequisites

| Component | Install | Purpose |
|-----------|---------|---------|
| [Claude Code](https://docs.anthropic.com/en/docs/claude-code) | `npm install -g @anthropics/claude-code` | LLM agent |
| [obsidian-forge](https://github.com/epicsagas/obsidian-forge) | `cargo install obsidian-forge` | Vault automation daemon |
| [vault-doctor](https://github.com/epicsagas/vault-doctor) | `npm install -g vault-doctor` | Vault health diagnostics |
| [Obsidian](https://obsidian.md) | Download from obsidian.md | Note-taking app |

**Recommended Claude Code plugins** (install via `claude plugin install <name>`):

| Plugin | Purpose |
|--------|---------|
| `alcove` | MCP-based project doc server |
| `obsidian-forge` | Obsidian vault management CLI |
| `epic` | Development pipeline (spec/go/check/ship) |
| `epicsagas` | Decision-making skills (five-whys, devil's advocate) |

Add the epicsagas marketplace first:
```bash
claude plugin marketplace add epicsagas
```

### 4. Open in Obsidian

Open the cloned folder as a vault in Obsidian. Install the [Dataview](https://blacksmithgu.github.io/obsidian-dataview/) community plugin for `Home.md` queries.

### 5. Start Claude Code

```bash
cd my-second-brain
claude
```

## Folder Structure

```
├── 00-Inbox/               # Capture zone
├── 01-Projects/            # Active projects
├── 02-Areas/               # Ongoing interest areas
├── 03-Resources/           # Reference materials
├── 04-Writing/             # Writing projects
├── 10-Zettelkasten/        # Permanent concept notes (Wiki layer)
├── 99-Archives/projects/   # All project docs (active + inactive)
├── _template/              # New project scaffolding
├── scripts/                # Automation scripts
├── AGENTS.md               # Agent instructions (read by Claude Code)
├── CLAUDE.md               # Entry point → delegates to AGENTS.md
├── TAGGING.md              # Tag and frontmatter rules
├── vault.toml              # obsidian-forge configuration
├── index.md                # Agent navigation (static, no Dataview)
└── Home.md                 # Obsidian dashboard (Dataview queries)
```

## Included Skills & Commands

| Type | Name | Trigger |
|------|------|---------|
| Skill | vault-doctor | "scan vault", "fix vault", "check vault health" |
| Skill | skill-forge | "skill create", "skill audit", "make skill" |
| Command | `/vault-fix` | Run vault-doctor auto-fix + verify |
| Command | `/vault-scan` | Run vault-doctor scan + report |
| Agent | vault-specialist | Automated vault health workflows |

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

Follow the interactive prompt. Skills are saved to `.claude/skills/`.

### Change Language

Edit `AGENTS.md` → "Language Rules" section. Default is English for agent-facing files.

### Configure AI Model

Edit `vault.toml` → `[ai]` section:

```toml
[ai]
model = "claude-sonnet-4-20250514"  # or "gpt-4o", "glm-5", etc.
max_concurrent = 5
```

## Creating a New Project

When starting a new project, copy `_template/` to `99-Archives/projects/{name}/`:

```bash
cp -r _template/ 99-Archives/projects/my-project/
cd 99-Archives/projects/my-project
# Replace {{project}} with your project name in all files
```

Or use obsidian-forge: `of init-project my-project`

## Methodology References

This vault combines three knowledge management approaches:

| Method | Role in Vault | Layer |
|--------|--------------|-------|
| [PARA](https://fortelabs.com/blog/para/) | Folder structure (Projects/Areas/Resources/Archives) | Organization |
| [Zettelkasten](https://zettelkasten.de/introduction/) | Atomic concept notes in `10-Zettelkasten/` | Wiki |
| [LLM Wiki](https://gist.github.com/karpathy/b3362274993e5f55ef2dd19e420dff98) | Raw → Wiki → Graph compilation pattern | Automation |

## License

MIT
