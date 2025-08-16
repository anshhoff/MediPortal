import SwiftUI

@main
struct MediPortalApp: App {
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            RegistrationView()
                .environmentObject(appState)
        }
    }
}
