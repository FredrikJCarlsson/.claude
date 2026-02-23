# Docker Compose Execution Patterns

## Service Discovery

- List services: `docker compose config --services`
- Show merged config: `docker compose config`
- Find running service containers: `docker compose ps`

## Choosing `exec` vs `run`

- Use `docker compose exec <service> <cmd>` when the service container is already running and you need to run a command in that same environment.
- Use `docker compose run --rm <service> <cmd>` for one-off jobs that should not depend on the long-running process state.

## Interactive vs Non-interactive

- Interactive terminal: `docker compose exec <service> sh`
- Automation/non-TTY contexts: `docker compose exec -T <service> <cmd>`

Use `-T` in scripted runs to avoid pseudo-TTY issues.

## Startup and Dependencies

- Start all services in background: `docker compose up -d`
- Start selected services: `docker compose up -d <service>`
- Rebuild images when Dockerfile or base dependencies change: `docker compose build`

## Common Command Templates

- Install dependencies in service container: `docker compose exec <service> <package-manager> install`
- Run tests in service container: `docker compose exec -T <service> <test-command>`
- Run migrations in service container: `docker compose exec -T <service> <migration-command>`

## Path and Permission Notes

- Treat paths in `exec` commands as container filesystem paths.
- If files are created with wrong ownership, run with the proper user or adjust service `user:` in compose.
