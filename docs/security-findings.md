# Container Security Findings — database

Scanner: Docker Scout  
Image: `sirvin703/database:0.1.1` (based on `postgres:16-bookworm`)  
Date: $(date +'%Y-%m-%d')

## Summary
- Findings: **4 Critical, 38 High** (0 Medium/Low) from report `database_cves_high_critical_011.txt`.
- Most issues originate from `golang/stdlib@1.18.2` flagged by the scanner inside the base image layers and a few Debian packages (`libxslt`, `pam`) that currently have **no fixed versions** published upstream.
- Application layer adds no extra packages beyond Postgres defaults; initialization SQL only.

## Immediate Mitigations (within course scope)
- **Track upstream**: Rebuild regularly to pick up patched base layers (`postgres:16-bookworm` or newer digest).  
- **Pin and monitor**: Pin a known-good digest in production; set up a weekly scan in CI to alert on new CVEs.  
- **Minimal image**: Keep Dockerfile minimal (no extra OS packages).  
- **Runtime hardening**: Run with strong DB creds, non-root user (default for Postgres), least-privileged network/policies when deployed.

## Next-step Options (if allowed by requirements)
- Evaluate `postgres:17-bookworm` (or a newer `16.x` digest) when compatible; rescan.  
- Consider distro variant changes (e.g., slim) if functionality permits; rescan.  
- If specific CVEs become exploitable in your context, switch to a vendor-hardened base or rebuild from source with patched components.

## Evidence
- Quickview: `security-scans/database_quickview_011.txt`
- Filtered CVEs (Critical/High): `security-scans/database_cves_high_critical_011.txt`

