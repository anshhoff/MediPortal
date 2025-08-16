import SwiftUI

struct RegistrationView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack {
            Text("Registration View")
                .font(.title)
                .padding()
            
            Text("Welcome to MediPortal")
                .font(.headline)
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    RegistrationView()
        .environmentObject(AppState())
}
