# Daily Automation Setup

The `.github/workflows/daily-hcm-portfolio.yml` workflow runs a repository audit every day at approximately 08:00 Asia/Kolkata. On a scheduled publication date, the Python script uses Responses API web search restricted to `docs.oracle.com`, checks the required article structure, updates the tracker to `Draft PR`, and the workflow pushes a date-specific `codex/` branch and opens a PR against `main`. It never merges or publishes directly.

## Required setup after this foundation PR is merged

1. In **Settings → Secrets and variables → Actions**, add repository secret `OPENAI_API_KEY` with an API key that is allowed to call the OpenAI Responses API. Usage is billed to the associated API account; set appropriate project budget/rate limits there.
2. Add repository variable `OPENAI_MODEL` with a model available to that API project that supports the Responses API web search tool. The workflow does not hard-code a model name because model availability depends on the API project.
3. In **Settings → Actions → General → Workflow permissions**, enable **Allow GitHub Actions to create and approve pull requests**. The workflow requests only `contents: write` and `pull-requests: write`; organization policy may still restrict these permissions.
4. Confirm Actions are enabled for the repository. After merge, inspect the first run in the Actions tab.

## Credentials and permissions

- `OPENAI_API_KEY` is needed only to research and draft a publication on a scheduled slot. Daily audits run without it. Never paste this key into a workflow, issue, repository file, or article.
- `GITHUB_TOKEN` is issued by GitHub for each workflow run. The workflow uses it to read the repository, push the separate draft branch, and open a PR. No personal access token is required.
- Oracle tenant usernames/passwords, employee information, and Fusion access tokens are **not** required by this workflow. Articles use public Oracle Help Center pages and synthetic examples.
- Model-generated drafts are candidates. Structural checks cannot prove every technical statement. A knowledgeable human must verify SQL/API/HDL details, tenant dependencies, references, and privacy before merge.

## Operating behavior

- The daily audit reads `AGENTS.md`, checks the two-per-week tracker pattern, and checks existing articles for required sections, five interview answers, and Oracle documentation links.
- Draft generation occurs only when today matches a tracker row whose status is `Scheduled`. It searches official Oracle documentation, then opens at most one branch/PR for that date.
- A missing API secret/model skips drafting; failed source or structure checks fail the scheduled job and do not create a PR.
- If a date-specific branch already exists, the job skips it to avoid duplicate drafts. Resolve that PR/branch before retrying the same slot.
- Merge decisions and changing a tracker row from `Draft PR` to `Published` remain manual.
- GitHub scheduled jobs can start later than their requested cron time. The daily run uses UTC date; its chosen cron time (02:30 UTC) is the same calendar date in Asia/Kolkata.
