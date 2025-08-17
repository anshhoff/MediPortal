import Foundation

struct RegistrationPayload: Codable {
    let Name: String
    let NameUpper: String
    let PhoneNo: String
    let WhatsappNo: String
    let CountryCode: String
    let Email: String
    let Gender: String
    let Age: String
    let AgeUnit: String
    let practice_frm_month: String
    let practice_frm_year: String
}
