#!/usr/bin/env zsh
set -euo pipefail

source_dir="${0:A:h}"
application_name='Neovim Finder'
bundle_id='com.erwannrousseau.neovim-finder'
applications_dir="${NEOVIM_FINDER_APPLICATIONS_DIR:-$HOME/Applications}"
launcher='/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister'
mode="${1:-install}"
destination="$applications_dir/$application_name.app"

bundle_identifier() {
	/usr/libexec/PlistBuddy -c 'Print :CFBundleIdentifier' "$1/Contents/Info.plist" 2>/dev/null
}

case "$mode" in
	install|--check|--build-check) ;;
	*) print -u2 "Usage: $0 [--check|--build-check]"; exit 2 ;;
esac

workspace="$(mktemp -d)"
trap 'rm -rf "$workspace"' EXIT
bundle="$workspace/$application_name.app"
defaults_tool="$workspace/set-neovim-defaults"

osacompile -o "$bundle" "$source_dir/Neovim Finder.applescript"
plutil -replace CFBundleIdentifier -string "$bundle_id" "$bundle/Contents/Info.plist"
plutil -replace CFBundleName -string "$application_name" "$bundle/Contents/Info.plist"
plutil -replace NSAppleEventsUsageDescription -string 'Neovim Finder needs to control Ghostty to open files in Neovim.' "$bundle/Contents/Info.plist"
plutil -extract CFBundleDocumentTypes xml1 -o "$workspace/document-types.plist" "$source_dir/Info.plist"
/usr/libexec/PlistBuddy -c 'Delete :CFBundleDocumentTypes' -c "Import :CFBundleDocumentTypes $workspace/document-types.plist" "$bundle/Contents/Info.plist"
codesign --force --sign - "$bundle"
codesign --verify --deep --strict "$bundle"
swiftc "$source_dir/set-neovim-defaults.swift" -framework CoreServices -framework Foundation -o "$defaults_tool"

if [[ "$mode" == '--build-check' ]]; then
	print 'Neovim Finder build: OK'
	exit 0
fi

if [[ "$mode" == '--check' ]]; then
	[[ -d "$destination" && ! -L "$destination" ]] || { print -u2 "Missing $destination"; exit 1; }
	[[ "$(bundle_identifier "$destination")" == "$bundle_id" ]] || { print -u2 "Unexpected app at $destination"; exit 1; }
	codesign --verify --deep --strict "$destination"
	"$defaults_tool" --check
	exit 0
fi

mkdir -p "$applications_dir"
if [[ -e "$destination" || -L "$destination" ]]; then
	[[ -d "$destination" && ! -L "$destination" && "$(bundle_identifier "$destination")" == "$bundle_id" ]] || {
		print -u2 "Refusing to replace unexpected app: $destination"
		exit 1
	}
fi
ditto "$bundle" "$destination"
codesign --force --sign - "$destination"
"$launcher" -f "$destination"
"$defaults_tool"
print "Installed $application_name in $applications_dir"
