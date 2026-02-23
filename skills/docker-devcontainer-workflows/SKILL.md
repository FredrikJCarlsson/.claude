---
name: docker-devcontainer-workflows
description: Docker, Docker Compose, and devcontainer execution workflows. Use when tasks involve deciding where commands should run (host vs container), running scripts in mounted workspaces, starting or targeting compose services, attaching to running containers, or executing project commands inside devcontainers instead of the local machine.
---

# Docker and Devcontainer Workflows

## Overview

Use this skill to choose the correct execution target for project commands and run them with minimal host-side risk.

## Workflow

1. Detect container and project context:
- Check whether the current shell is already inside a container using `test -f /.dockerenv` or `cat /proc/1/cgroup`.
- Check for `.devcontainer/devcontainer.json` and `docker-compose.yml` or `compose.yaml`.
- Identify candidate services with `docker compose config --services`.

2. Prefer container execution for project-scoped commands:
- If source files or scripts are mounted into a container, run commands in that container unless the user explicitly requests host execution.
- Avoid running build, install, test, migration, and codegen steps on host when the project standard flow is containerized.

3. Choose the execution method:
- Active devcontainer workflow: use `devcontainer exec --workspace-folder <path> <cmd>`.
- Compose-managed service: use `docker compose exec <service> <cmd>` for interactive commands, or `docker compose exec -T <service> <cmd>` for non-interactive runs.
- Plain container: use `docker exec -it <container> <cmd>` (or omit `-it` in non-interactive contexts).

4. Resolve path and user mismatches:
- Use container paths when running inside containers.
- If host path differs from container mount path, map to the container workspace before execution.
- If permissions matter, set user explicitly (`--user` in `docker exec`, or service `user:` config in compose).

5. Handle lifecycle and startup order:
- Start services before exec: `docker compose up -d <service>`.
- For one-off task containers, use `docker compose run --rm <service> <cmd>`.
- Rebuild when dependency layers or Dockerfiles changed: `docker compose build` or devcontainer rebuild.

6. Validate execution location:
- Confirm with `pwd`, `whoami`, and environment markers (`printenv`, `ls /workspaces`).
- If command output implies host execution but container execution was intended, stop and rerun in the right container.

## Host vs Container Decision Rules

- Run on host only when the command is explicitly host-oriented (for example Docker CLI management, editing host files outside mounts, or host network diagnostics).
- Run in container for project runtime/toolchain commands, especially when dependencies are container-only.
- If unsure, inspect `.devcontainer/devcontainer.json` and compose service definitions, then prefer container execution.

## Quick Command Map

- List running containers: `docker ps`
- Open shell in container: `docker exec -it <container> sh`
- Run command in compose service: `docker compose exec <service> <cmd>`
- Run non-interactive CI-style command: `docker compose exec -T <service> <cmd>`
- Start and background services: `docker compose up -d`
- One-off task container: `docker compose run --rm <service> <cmd>`
- Execute in devcontainer workspace: `devcontainer exec --workspace-folder <path> <cmd>`
- Inspect compose services: `docker compose config --services`

## References

- Docker and Compose execution patterns: `references/docker-compose-execution.md`
- Devcontainer workflows and guardrails: `references/devcontainer-execution.md`
