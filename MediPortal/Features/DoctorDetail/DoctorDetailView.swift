import SwiftUI

struct DoctorDetailView: View {
    let guid: String
    @StateObject private var viewModel = DoctorDetailViewModel()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                
                if viewModel.isLoading {
                    VStack(spacing: 16) {
                        ProgressView().scaleEffect(1.5)
                        Text("Loading doctor details...").foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 100)
                } else if let errorMessage = viewModel.errorMessage {
                    VStack(spacing: 20) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.orange)
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                        Button("Retry") { 
                            Task { await viewModel.loadDoctor(guid: guid) } 
                        }
                        .padding(.horizontal, 24)
                        .padding(.vertical, 12)
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 80)
                } else if let doctor = viewModel.doctor {
                    VStack(alignment: .leading, spacing: 20) {
                        
                        // Header Section
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Doctor Information")
                                .font(.title2)
                                .bold()
                                .foregroundColor(.primary)
                            
                            Rectangle()
                                .fill(Color.orange)
                                .frame(width: 50, height: 3)
                        }
                        .padding(.top)
                        
                        // Doctor Details Cards
                        VStack(spacing: 16) {
                            DetailCard(icon: "person.fill", title: "Full Name", value: doctor.name ?? "Not specified")
                            DetailCard(icon: "envelope.fill", title: "Email Address", value: doctor.email ?? "Not specified")
                            DetailCard(icon: "person.badge.shield.checkmark.fill", title: "Doctor ID", value: String(doctor.doctors_id.prefix(20)) + (doctor.doctors_id.count > 20 ? "..." : ""))
                            DetailCard(icon: "figure.stand", title: "Gender", value: doctor.gender ?? "Not specified")
                            DetailCard(icon: "calendar.badge.clock", title: "Practicing Since", value: "\(doctor.practice_frm_month ?? "N/A")/\(doctor.practice_frm_year ?? "N/A")")
                        }
                        
                        Spacer(minLength: 30)
                        
                        // Dashboard Button
                        NavigationLink(destination: DashboardView(doctorName: doctor.name ?? "Doctor")) {
                            HStack {
                                Image(systemName: "chart.line.uptrend.xyaxis.circle.fill")
                                    .font(.title2)
                                    .foregroundColor(.orange)
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("View Dashboard")
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                    Text("Access your personalized health dashboard")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.orange)
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                        }
                    }
                }
            }
        }
        .padding()
        .navigationTitle("Doctor Details")
        .navigationBarTitleDisplayMode(.large)
        .task {
            await viewModel.loadDoctor(guid: guid)
        }
    }
}

struct DetailCard: View {
    let icon: String
    let title: String  
    let value: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(.orange)
                .frame(width: 24, height: 24)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(value)
                    .font(.body)
                    .foregroundColor(.primary)
            }
            Spacer()
        }
        .padding()
        .background(Color(.systemBackground))
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color(.systemGray5), lineWidth: 1)
        )
        .cornerRadius(8)
    }
}

#Preview {
    NavigationView {
        DoctorDetailView(guid: "sample-guid")
    }
}
