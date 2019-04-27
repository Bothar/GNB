import Foundation

extension Array where Element: Equatable {
    
    func removeDuplicates() -> Array {
        return reduce(into: [], { (result, element) in
            if !result.contains(element) {
                result.append(element)
            }
        })
    }
}
