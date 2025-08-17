import SwiftUI

@MainActor
final class DoctorDetailViewModel: ObservableObject {
    @Published var doctor: Doctor?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func loadDoctor(guid: String) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let fetchedDoctor = try await APIClient.shared.fetchDoctorDetail(guid: guid)
            doctor = fetchedDoctor
            errorMessage = nil
        } catch {
            errorMessage = "Failed to load doctor details: \(error.localizedDescription)"
            doctor = nil
        }
        
        isLoading = false
    }
}
