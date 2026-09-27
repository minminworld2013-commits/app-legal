# 컬러핏 Legal Pages Design

## Goal

Keep the three existing public URLs stable while replacing stale Color:me,
paid-product, backend-account, and no-advertising claims with statements that
match the current 컬러핏 app (`com.minminworld.personalcolor`).

## Scope

- Revise `personalcolor.html`, `personalcolor-terms.html`, and
  `personalcolor-delete.html` in place.
- Do not change k-bazi pages, app code, store configuration, or another app.
- Preserve bilingual Korean/English presentation and lightweight CSS.

## Truth Boundaries

- Identity is `컬러핏`; the package identifier is the durable app anchor.
- The current release is free and does not require sign-in. Do not promise paid
  content, purchase restore, or refunds.
- Photos are analyzed on-device and are not sent by the app to an operator
  backend or external AI. Picker-created temporary copies can exist and are
  deleted after successful reading, with best-effort residue cleanup.
- Diagnosis records are local SQLite data. Settings deletes diagnosis records;
  OS clear-data or uninstall removes broader local app data.
- Optional Google/Apple authentication creates an app session. Signing out does
  not delete or revoke the provider account, and no operator backend account
  deletion is promised.
- Google Mobile Ads is integrated and may process advertising/device data when
  configured. Do not claim NPA-only, personalized ads, universal consent, or
  child-directed treatment without release evidence.
- On-device ML Kit processing and possible vendor diagnostics are disclosed.
  No separate analytics/crash-reporting SDK is claimed.
- Voluntary support emails are used to answer the inquiry and retained only as
  needed for that purpose or a legal obligation.

## Publication and Rollback

The source commit before this change is `8288f48074632c6b4e2651955f28968d7bcd17df`.
It is preserved in remote branch `backup/personalcolor-pre-206-20260927` and in
the checksummed tar backup recorded in issue #206. Rollback restores the three
HTML files from that commit, commits the restoration, and republishes `main`.

## Verification

A repository test rejects stale product/payment/backend claims and requires the
current identity, local-data boundaries, SDK disclosures, deletion limits,
cross-links, and dates. After publication, all three URLs must return HTTP 200
and their bodies must match the committed files after cache expiry.
