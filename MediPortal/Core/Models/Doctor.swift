import Foundation

struct Doctor: Codable, Identifiable {
    let doctors_id: String
    let name: String?
    let email: String?
    let gender: String?
    let practice_frm_month: String?
    let practice_frm_year: String?
    
    var id: String { doctors_id }
}
