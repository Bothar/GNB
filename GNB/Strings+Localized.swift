import Foundation

func NSLocalizedString(_ key: String) -> String {
    return NSLocalizedString(key, comment: "")
}

extension String {
    static let DVTotal = NSLocalizedString("DVTotal")
    static let ERTitle = NSLocalizedString("ERTitle")
    static let EROkButtok = NSLocalizedString("EROkButtok")
}
