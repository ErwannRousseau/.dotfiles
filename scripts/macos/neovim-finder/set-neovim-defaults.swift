import CoreServices
import Foundation
import UniformTypeIdentifiers

let bundleIdentifier = "com.erwannrousseau.neovim-finder"
let bundleID = bundleIdentifier as NSString
let checking = CommandLine.arguments.contains("--check")
let extensions = ["md", "yaml", "yml", "txt", "json", "toml", "ini", "xml", "csv", "log"]
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
