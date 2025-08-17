import SwiftUI

@MainActor
final class RegistrationViewModel: ObservableObject {
    @Published var name = ""
    @Published var phone = ""
    @Published var whatsapp = ""
    @Published var country = "IN"
    @Published var email = ""
    @Published var gender = "M"
    @Published var age = "21"
    @Published var ageUnit = "Y"
    @Published var practiceMonth = ""
    @Published var practiceYear = ""
    @Published var isLoading = false
    @Published var message: String?
    @Published var registeredDoctor: Doctor?
    
    func submit() async {
        isLoading = true
        message = nil
        
        let payload = RegistrationPayload(
            Name: name,
            NameUpper: name.uppercased(),
            PhoneNo: phone,
            WhatsappNo: whatsapp.isEmpty ? phone : whatsapp,
            CountryCode: country,
            Email: email,
            Gender: gender,
            Age: age,
            AgeUnit: ageUnit,
            practice_frm_month: practiceMonth,
            practice_frm_year: practiceYear
        )
        
        do {
            let doctor = try await APIClient.shared.registerDoctor(payload: payload)
            registeredDoctor = doctor
            message = "Registration successful! Doctor ID: \(doctor.doctors_id)"
        } catch {
            message = "Registration failed: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
}
