# routeros-config-audit

Automated configuration backups of the MemHamWAN RouterOS fleet.

- **`main`** — sanitized configs (`/export hide-sensitive` + redaction), one
  `.rsc` file per device, updated hourly by
  [Oxidized](https://github.com/ytti/oxidized) running on the on-network
  backup host. Full-text searchable via GitHub code search or `git grep`.
- **`encrypted`** — nightly full exports (`/export show-sensitive`),
  sops/age-encrypted per device. Decryption keys are held by netops members
  (same recipients as [netops-secrets](https://github.com/memhamwan/netops-secrets)),
  not by the backup host.
- **`master`** — frozen 2021-era snapshot, kept for history.

Values shown as `REDACTED` were scrubbed as defense in depth; the real values
live in the encrypted branch and netops-secrets.

Both branches are **automation-owned**: do not push to them by hand. Tooling,
device onboarding, and the backup-host runbook live in
[memhamwan/netops](https://github.com/memhamwan/netops).
