import Foundation

struct ODataSingle<T: Codable>: Codable {
    let d: T
}

struct ODataCollection<T: Codable>: Codable {
    struct Results<U: Codable>: Codable {
        let results: [U]
    }
    
    let d: Results<T>
}
