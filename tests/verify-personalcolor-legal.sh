#!/bin/sh
set -eu

repo=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
privacy="$repo/personalcolor.html"
terms="$repo/personalcolor-terms.html"
deletion="$repo/personalcolor-delete.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

require() {
  pattern=$1
  file=$2
  label=$3
  rg -q --fixed-strings "$pattern" "$file" || fail "$label"
}

reject() {
  pattern=$1
  file=$2
  label=$3
  if rg -q --fixed-strings "$pattern" "$file"; then
    fail "$label"
  fi
}

for file in "$privacy" "$terms" "$deletion"; do
  [ -s "$file" ] || fail "missing or empty page: $file"
  require '<html lang="ko">' "$file" "missing Korean document language"
  require '컬러핏' "$file" "missing current app identity"
  require 'com.minminworld.personalcolor' "$file" "missing package anchor"
  require 'minminworld2013@gmail.com' "$file" "missing operator contact"
  require '2026-09-27' "$file" "missing current publication date"
  reject 'Color:me' "$file" "stale product identity remains"
  reject 'api.minminworld.com' "$file" "unsupported backend claim remains"
done

require '임시 복사본' "$privacy" "privacy page omits picker temporary-copy boundary"
require 'SQLite' "$privacy" "privacy page omits local diagnosis storage"
require 'Google Mobile Ads' "$privacy" "privacy page omits advertising SDK"
require 'ML Kit' "$privacy" "privacy page omits on-device ML Kit boundary"
require '자체 백엔드 계정' "$privacy" "privacy page omits no-backend-account boundary"
reject '본 앱은 광고를 표시하지 않으며' "$privacy" "stale no-advertising claim remains"
reject '세부 톤 가이드는 유료' "$privacy" "stale paid-guide claim remains"

require '모든 진단 및 가이드는 무료' "$terms" "terms omit current free-service mode"
require '로그인 없이' "$terms" "terms omit no-required-login mode"
reject '1회 구매' "$terms" "stale purchase terms remain"
reject '구매 복원' "$terms" "stale purchase-restore terms remain"

require '진단 기록 삭제' "$deletion" "deletion page omits in-app diagnosis deletion"
require '앱 데이터 삭제' "$deletion" "deletion page omits OS clear-data path"
require '제공자 계정은 삭제되지 않습니다' "$deletion" "deletion page overstates provider deletion"
require '운영자 서버 계정은 없습니다' "$deletion" "deletion page omits no-server-account boundary"
reject '계정 삭제' "$deletion" "nonexistent in-app account-deletion flow remains"
reject '구매 영수증' "$deletion" "stale purchase-receipt claim remains"

require 'href="personalcolor-terms.html"' "$privacy" "privacy page does not link Terms"
require 'href="personalcolor-delete.html"' "$privacy" "privacy page does not link deletion guide"
require 'href="personalcolor.html"' "$terms" "Terms do not link privacy page"
require 'href="personalcolor-delete.html"' "$terms" "Terms do not link deletion guide"
require 'href="personalcolor.html"' "$deletion" "deletion guide does not link privacy page"
require 'href="personalcolor-terms.html"' "$deletion" "deletion guide does not link Terms"

printf 'PASS: 컬러핏 legal-page contract\n'
