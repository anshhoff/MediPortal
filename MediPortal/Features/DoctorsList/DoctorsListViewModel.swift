import SwiftUI

@MainActor
final class DoctorsListViewModel: ObservableObject {
    @Published var doctors: [Doctor] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func loadDoctors() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let fetchedDoctors = try await APIClient.shared.fetchDoctorsList()
            doctors = fetchedDoctors
            errorMessage = nil
        } catch {
            errorMessage = "Failed to load doctors: \(error.localizedDescription)"
            doctors = []
        }
        
        isLoading = false
    }
}
