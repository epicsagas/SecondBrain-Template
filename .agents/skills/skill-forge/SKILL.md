---
name: skill-forge
description: "Skill creator and optimizer following Agent Skills Open Standard. Triggers on skill create, make skill, skill forge, new skill, skill audit, skill optimize, SKILL.md."
---

# Skill Forge

Meta-skill for creating and optimizing Agent Skills. Generates production-grade SKILL.md files following the Agent Skills Open Standard.

## Trigger

- skill create, make skill, new skill, skill forge, skill builder
- skill audit, skill optimize, skill review
- SKILL.md, slash command, custom command

## Instructions

When the user requests skill creation or optimization, execute the pipeline below.

---

### Phase 1: Requirements Gathering

Extract the following from user input. Use AskUserQuestion to fill gaps.

**Required:**

| Field | Question | Default |
|-------|----------|---------|
| Skill name | What name? (lowercase + hyphens, max 64 chars) | Infer from input |
| Purpose | What does this skill do? | — |
| Triggers | When should it activate? | Infer from purpose |
| Scope | Project-local vs global? | Project (`.agents/skills/`) |

**Optional (advanced):**

| Field | Description | Default |
|-------|-------------|---------|
| `allowed-tools` | Restrict which tools the skill can use | Unset (all allowed) |
| `model` | Override model when skill activates | Unset |
| `disable-model-invocation` | Prevent automatic invocation | false |

---

### Phase 2: Architecture Selection

Auto-select the optimal pattern based on requirements.

| Pattern | Use case | Body size |
|---------|----------|-----------|
| **CLI Wrapper** | External CLI tool invocation | ~50 lines |
| **MCP Tool Wrapper** | MCP server tool orchestration | ~80 lines |
| **Multi-Phase Pipeline** | Sequential multi-step workflow | ~150 lines |
| **Research / Analysis** | Web search + analysis + report | ~100 lines |
| **File Generator** | Template-based file output | ~120 lines |
| **Code Review / Audit** | Code analysis + feedback | ~80 lines |

**Selection criteria:**
1. External tool calls only → CLI Wrapper
2. MCP tools only → MCP Tool Wrapper
3. 3+ sequential steps → Multi-Phase Pipeline
4. Web search / research involved → Research / Analysis
5. File artifacts generated → File Generator
6. Code / document analysis → Code Review / Audit

---

### Phase 3: SKILL.md Generation

#### 3.1 Frontmatter Spec

```yaml
---
name: {skill-name}
description: {when to use + what it does}
---
```

**Description writing rules:**
- "helps with code" (BAD) → "when tests fail, analyzes failures and suggests fixes" (GOOD)
- Include trigger keywords naturally
- One sentence: when to use + what it does

#### 3.2 Body Structure

```markdown
# {Skill Display Name}

{One-line summary}

## Trigger

- {trigger keywords / patterns}

## Instructions

{Execution instructions}
```

---

### Phase 4: Quality Validation

**Structural Validation:**
- `name` field present, lowercase+hyphens, max 64 chars
- `description` field present, max 1024 chars, includes trigger keywords
- `## Trigger` section present, 3+ keywords
- `## Instructions` section present
- Body 200 lines or fewer
- CLI commands use relative names (on PATH) or project-relative paths

**Quality Validation:**
- Description is specific enough
- Single responsibility — skill doesn't do too much
- Error handling guidance at necessary points

---

### Phase 5: File Creation

1. Write file to `.agents/skills/{skill-name}/SKILL.md`
2. Create scripts/, references/ subfiles if needed

---

## Execution Modes

- `/skill-forge create` → Phase 1–5 (create new)
- `/skill-forge audit` → Audit existing skills
- `/skill-forge optimize` → Optimize existing skills

---

## Best Practices

### Do
- Keep body under 200 lines
- Include trigger keywords in description
- Skillify when you repeat the same context 2+ times per week
- Minimize frontmatter — name + description suffice

### Don't
- Make one skill do too much
- Write vague descriptions
- Put global rules in skills (belongs in AGENTS.md)
- Write 200+ line monolithic SKILL.md files
