import SwiftUI

struct RegistrationView: View {
    @StateObject private var viewModel = RegistrationViewModel()
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    
                    // Step indicator
                    VStack(spacing: 8) {
                        Text("MediPortal").font(.title2).bold()
                        Text("Basic Details").font(.title2).bold()
                        Text("Fill Basic Details Below").font(.caption).foregroundColor(.secondary)
                        Rectangle().fill(Color.orange).frame(height: 3).frame(width: 60)
                    }
                    .padding(.top, 20)
                    
                    // Form Fields
                    VStack(spacing: 20) {
                        
                        // Full Name
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Full Name").font(.subheadline).foregroundColor(.secondary)
                            TextField("", text: $viewModel.name)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        
                        // Email ID  
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Email ID").font(.subheadline).foregroundColor(.secondary)
                            TextField("", text: $viewModel.email)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.emailAddress)
                        }
                        
                        // Gender with toggle buttons
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Gender").font(.subheadline).foregroundColor(.secondary)
                            HStack(spacing: 12) {
                                ForEach([("Female", "F"), ("Male", "M"), ("Others", "O")], id: \.0) { (title, value) in
                                    Button(title) {
                                        viewModel.gender = value
                                    }
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background(viewModel.gender == value ? Color.orange : Color.gray.opacity(0.1))
                                    .foregroundColor(viewModel.gender == value ? .white : .primary)
                                    .cornerRadius(20)
                                }
                                Spacer()
                            }
                        }
                        
                        // Practicing From
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Practicing From").font(.subheadline).foregroundColor(.secondary)
                            HStack {
                                TextField("Month", text: Binding(
                                    get: { viewModel.practiceMonth },
                                    set: { viewModel.practiceMonth = $0 }
                                ))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.numberPad)
                                
                                TextField("Year", text: Binding(
                                    get: { viewModel.practiceYear },
                                    set: { viewModel.practiceYear = $0 }
                                ))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.numberPad)
                            }
                        }
                        
                        // Phone and other hidden fields for API
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Phone Number").font(.subheadline).foregroundColor(.secondary)
                            TextField("", text: $viewModel.phone)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.numberPad)
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Age").font(.subheadline).foregroundColor(.secondary)
                            TextField("", text: $viewModel.age)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.numberPad)
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    Spacer(minLength: 40)
                    
                    // Next Button (Register)
                    VStack(spacing: 16) {
                        Button(action: {
                            Task { await viewModel.submit() }
                        }) {
                            if viewModel.isLoading {
                                ProgressView().progressViewStyle(CircularProgressViewStyle(tint: .white))
                            } else {
                                Image(systemName: "arrow.right")
                                    .font(.title2)
                                    .foregroundColor(.white)
                            }
                        }
                        .frame(width: 56, height: 56)
                        .background(Color.orange)
                        .cornerRadius(28)
                        .disabled(viewModel.isLoading || viewModel.name.isEmpty || viewModel.email.isEmpty)
                        .opacity((viewModel.isLoading || viewModel.name.isEmpty || viewModel.email.isEmpty) ? 0.6 : 1.0)
                        
                        // Success/Error message
                        if let message = viewModel.message {
                            Text(message)
                                .foregroundColor(viewModel.registeredDoctor != nil ? .green : .red)
                                .multilineTextAlignment(.center)
                                .padding()
                        }
                        
                        // Navigation to list (temporary)
                        NavigationLink("View All Doctors", destination: DoctorsListView())
                            .padding()
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    RegistrationView()
        .environmentObject(AppState())
}
