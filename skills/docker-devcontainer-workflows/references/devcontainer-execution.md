# Devcontainer Execution Guardrails

## Detect Devcontainer Setup

- Check for `.devcontainer/devcontainer.json`.
- Check whether compose is used via `dockerComposeFile` and `service` entries.
- Identify workspace mount path via `workspaceFolder` and `workspaceMount`.

## Execution Priority

1. If already inside the devcontainer terminal, run project commands directly there.
2. If on host and devcontainer CLI is available, run:
`devcontainer exec --workspace-folder <path> <cmd>`
3. If devcontainer maps to a compose service, use:
`docker compose exec <service> <cmd>`

Prefer these container paths over host execution for project scripts and tooling.

## Mounted Script Rule

When a script is mounted into the container workspace and the project expects container toolchains:

- Do not run it on host by default.
- Run it inside the devcontainer/service container.
- Verify with `pwd` and expected tool versions (`node -v`, `python --version`, etc.).

## Rebuild and Recovery

- Rebuild when dependencies or Dockerfile features change:
`devcontainer rebuild --workspace-folder <path>`
- Reopen/restart if environment drift occurs:
`devcontainer up --workspace-folder <path>`

## Common Pitfalls

- Host and container use different dependency sets.
- Host creates files with incompatible line endings or permissions.
- Command assumes container-only paths such as `/workspaces/<repo>`.

When these occur, rerun from container context and keep host-side execution limited to orchestration commands.
