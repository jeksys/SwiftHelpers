private protocol _Optional {
    func unwrappedString() -> String
}

extension Optional: _Optional {
    fileprivate func unwrappedString() -> String {
        switch self {
        case .some(let wrapped as _Optional): return wrapped.unwrappedString()
        case .some(let wrapped): return String(describing: wrapped)
        case .none: return String(describing: self)
        }
    }
}

postfix operator ~?
public postfix func ~? <X> (x: X?) -> String {
    return x.unwrappedString()
}

extension Optional {
    // True if the Optional is .None. Useful to avoid if-let.
    var isNil: Bool {
        if case .none = self {
            return true
        }
        return false
    }
}
