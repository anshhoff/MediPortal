import Foundation

struct ODataSingle<T: Codable>: Codable {
    let d: T
}

struct ODataCollection<T: Codable>: Codable {
    struct Results<T: Codable>: Codable {
        let results: [T]
    }
    
    let d: Results<T>
}
