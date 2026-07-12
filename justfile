# Task runner (just). Install: uv tool install rust-just

default:
    @just --list

# Boot the infra stack (redpanda, redis, postgres, mlflow) and wait for health
up:
    docker compose up -d --wait

# Stop the stack (volumes preserved)
down:
    docker compose down

# Stop the stack and delete volumes
nuke:
    docker compose down -v

# Run unit tests (integration tests excluded)
test:
    uv run pytest -m "not integration"

# Run integration tests (requires the stack up)
test-integration:
    uv run pytest -m integration

# Lint + format check
lint:
    uv run ruff check .
    uv run ruff format --check .

# Auto-fix lint and formatting
fix:
    uv run ruff check --fix .
    uv run ruff format .

# End-to-end demo (full pipeline lands in M3; for now boots the stack)
demo: up
    @echo "Stack is up. Generator -> scoring pipeline arrives in M3; this recipe will grow with it."
