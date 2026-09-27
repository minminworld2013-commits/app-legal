# 컬러핏 Legal Pages Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Publish accurate 컬러핏 privacy, Terms, and deletion pages at the existing stable URLs with a tested rollback path.

**Architecture:** Treat the three static HTML files as one versioned legal surface. A shell contract test enforces identity, required disclosures, stale-claim removal, links, and HTML structure before the files can be merged to the GitHub Pages branch.

**Tech Stack:** Static HTML, POSIX shell, GitHub Pages, git.

## Global Constraints

- Modify only the three `personalcolor*.html` files plus their scoped contract test and #206 design/plan records.
- Preserve `kbazi*.html` byte-for-byte.
- Do not publish unsupported operator, server, payment, advertising-personalization, consent, or deletion claims.
- Rollback source is commit `8288f48074632c6b4e2651955f28968d7bcd17df` and remote branch `backup/personalcolor-pre-206-20260927`.

---

### Task 1: Add the legal-page contract test

**Files:**
- Create: `tests/verify-personalcolor-legal.sh`
- Test: `tests/verify-personalcolor-legal.sh`

**Interfaces:**
- Consumes: the three public-page HTML files.
- Produces: exit 0 only when current identity/disclosures are present and stale claims are absent.

- [ ] Write exact positive and negative text assertions for all three pages.
- [ ] Run the test against the old pages and confirm it fails on `Color:me`.
- [ ] Commit the failing contract test.

### Task 2: Correct the three public pages

**Files:**
- Modify: `personalcolor.html`
- Modify: `personalcolor-terms.html`
- Modify: `personalcolor-delete.html`
- Test: `tests/verify-personalcolor-legal.sh`

**Interfaces:**
- Consumes: `docs/206-personalcolor-legal-design.md`.
- Produces: bilingual privacy, Terms, and deletion pages at stable filenames.

- [ ] Replace the privacy page with current identity, photo/cache, local-record, optional-auth, Ads/ML Kit, retention, child-audience, operator, and rights disclosures.
- [ ] Replace the Terms page with free-service, reference-only, optional-auth, acceptable-use, IP, availability, liability, and governing-law terms.
- [ ] Replace the deletion page with truthful diagnosis deletion, OS clear-data/uninstall, provider sign-out, photo residue, and support guidance.
- [ ] Run the contract test and confirm all assertions pass.
- [ ] Confirm only allowed files changed and commit.

### Task 3: Publish and verify with rollback ready

**Files:**
- Verify: `personalcolor.html`
- Verify: `personalcolor-terms.html`
- Verify: `personalcolor-delete.html`

**Interfaces:**
- Consumes: the reviewed feature-branch commit.
- Produces: three HTTP 200 public pages whose bodies match the commit.

- [ ] Push `fix/personalcolor-legal-206` and review its exact diff against the backup commit.
- [ ] Merge the reviewed commit to `main`.
- [ ] Poll each public URL with bounded retries until its body reflects the new commit.
- [ ] Re-run content assertions against downloaded public bodies.
- [ ] Record commit, verification, backup branch, rollback command, and remaining app-link work in issue #206.
