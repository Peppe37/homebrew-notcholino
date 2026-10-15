#!/bin/bash
# Checks the cask against the real release: the style, the checksum of the DMG, and that the app inside has
# the version the cask says. Runs on macOS (it mounts the DMG).
set -euo pipefail
cd "$(dirname "$0")/.."

cask=Casks/notcholino.rb
version=$(sed -n 's/^  version "\(.*\)"/\1/p' "$cask")
sha=$(sed -n 's/^  sha256 "\(.*\)"/\1/p' "$cask")
url="https://github.com/Peppe37/Notcholino/releases/download/v${version}/Notcholino-${version}.dmg"

echo "== style"
brew style --cask "$cask"

echo "== download $url"
dmg=$(mktemp -d)/Notcholino.dmg
curl -fsSL -o "$dmg" "$url"
actual=$(shasum -a 256 "$dmg" | cut -d' ' -f1)
[ "$actual" = "$sha" ] || { echo "checksum mismatch: cask $sha, download $actual"; exit 1; }
echo "checksum ok"

echo "== the app inside"
mount=$(mktemp -d)
hdiutil attach -nobrowse -readonly -mountpoint "$mount" "$dmg" >/dev/null
trap 'hdiutil detach "$mount" >/dev/null 2>&1 || true' EXIT
plist="$mount/Notcholino.app/Contents/Info.plist"
[ -f "$plist" ] || { echo "no Notcholino.app in the DMG"; exit 1; }
built=$(/usr/libexec/PlistBuddy -c "Print CFBundleShortVersionString" "$plist")
expected="${version%-alpha}"
[ "$built" = "$expected" ] || { echo "the app is version $built, the cask says $version"; exit 1; }
echo "version $built ok"
