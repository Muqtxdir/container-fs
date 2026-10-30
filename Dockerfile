# syntax=docker/dockerfile:1.28
FROM debian:testing

SHELL ["/bin/bash", "-euxo", "pipefail", "-c"]

RUN --mount=type=cache,target=/var/lib/apt/lists,sharing=locked \
    --mount=type=tmpfs,target=/var/log <<-EOT
	apt-get update
	apt-get install -y --no-install-recommends tini ca-certificates git mkosi oras \
		debian-archive-keyring ubuntu-keyring systemd zstd \
		dnf5 rpm distribution-gpg-keys
EOT

STOPSIGNAL SIGTERM

ENTRYPOINT ["tini", "--"]
CMD ["mkosi"]
