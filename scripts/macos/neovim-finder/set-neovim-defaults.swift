import CoreServices
import Foundation
import UniformTypeIdentifiers

let bundleIdentifier = "com.erwannrousseau.neovim-finder"
let bundleID = bundleIdentifier as NSString
let checking = CommandLine.arguments.contains("--check")
let extensions = [
    "md", "yaml", "yml", "txt", "json", "toml", "ini", "conf", "xml", "csv", "log",
    "zshrc", "zprofile", "zshenv", "zlogin", "zlogout", "zsh_history",
    "bashrc", "bash_profile", "bash_login", "bash_logout", "profile", "inputrc",
    "npmrc", "nvmrc", "node-version", "yarnrc", "npmignore", "yarnignore", "pnpmfile", "pnpmrc",
    "gitconfig", "gitignore", "gitattributes", "gitmodules", "gitmessage", "gitkeep",
    "editorconfig", "prettierrc", "prettierignore", "eslintrc", "eslintignore", "stylelintrc", "babelrc", "browserslistrc", "commitlintrc", "lintstagedrc", "dockerignore", "helmignore",
    "env", "envrc", "tool-versions", "python-version", "ruby-version", "go-version", "java-version", "terraform-version", "sdkmanrc",
    "vimrc", "gvimrc", "exrc", "ideavimrc", "curlrc", "wgetrc", "netrc", "hushlogin", "mailrc", "gemrc", "irbrc", "pryrc", "rspec", "simplecov"
]
var failed = [String]()

for ext in extensions {
    guard let contentType = UTType(filenameExtension: ext) else {
        failed.append(ext)
        continue
    }
    let roles = LSRolesMask(rawValue: 0x00000004)
    let contentTypeIdentifier = contentType.identifier as CFString
    let status = checking ? noErr : LSSetDefaultRoleHandlerForContentType(contentTypeIdentifier, roles, bundleID)
    let handler = LSCopyDefaultRoleHandlerForContentType(contentTypeIdentifier, roles)?.takeRetainedValue()
    if ext == "conf", status != noErr {
        continue
    }
    guard status == noErr, let handler, String(handler) == bundleIdentifier else {
        failed.append(ext)
        continue
    }
}

if !failed.isEmpty {
    print("Could not \(checking ? "verify" : "set"): \(failed.joined(separator: ", "))")
    exit(1)
}

print(checking ? "Neovim Finder defaults: OK" : "Neovim Finder defaults applied")
