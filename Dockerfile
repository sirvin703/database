# Postgres base image (Alpine variant for smaller size)
FROM postgres:16-bookworm

# Copy any initialization scripts. These run automatically on first start
# when the data directory is empty.
COPY init/ /docker-entrypoint-initdb.d/

# Healthcheck: relies on runtime env POSTGRES_USER/POSTGRES_DB
HEALTHCHECK --interval=30s --timeout=3s --retries=3 CMD pg_isready -U "$POSTGRES_USER" -d "$POSTGRES_DB" || exit 1
