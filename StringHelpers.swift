extension String {
    func appendingPathComponent(_ string: String) -> String {
        return URL(fileURLWithPath: self).appendingPathComponent(string).path
    }
}

extension String {
    var hex: Int? {
        return Int(self, radix: 16)
    }
}

extension String {
    // NSLocalizedString shorthand
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
