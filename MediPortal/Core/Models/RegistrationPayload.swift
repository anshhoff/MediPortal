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
}
