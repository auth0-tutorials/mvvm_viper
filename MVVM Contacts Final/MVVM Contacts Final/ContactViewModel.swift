
public struct ContactViewModel {
    var fullName: String
}

public func <(lhs: ContactViewModel, rhs: ContactViewModel) -> Bool {
    return lhs.fullName.lowercased() < rhs.fullName.lowercased()
}

public func >(lhs: ContactViewModel, rhs: ContactViewModel) -> Bool {
    return lhs.fullName.lowercased() > rhs.fullName.lowercased()
}
