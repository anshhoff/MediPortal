import SwiftUI

struct DoctorsListView: View {
    @StateObject private var viewModel = DoctorsListViewModel()
    
    var body: some View {
        List {
            if viewModel.isLoading {
                ProgressView("Loading doctors...")
                    .frame(maxWidth: .infinity, alignment: .center)
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
            } else if viewModel.doctors.isEmpty && !viewModel.isLoading && viewModel.errorMessage == nil {
                Text("No doctors found")
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            } else {
                ForEach(viewModel.doctors) { doctor in
                    NavigationLink(destination: DoctorDetailView(guid: doctor.doctors_id)) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(doctor.name ?? "Unknown Name")
                                .font(.headline)
                                .foregroundColor(.primary)
                            Text(doctor.email ?? "No email")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            HStack {
                                Text("ID: \(String(doctor.doctors_id.prefix(8)))...")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Spacer()
                                Text("Gender: \(doctor.gender ?? "N/A")")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            HStack {
                                Text("Practice from: \(doctor.practice_frm_month ?? "N/A")/\(doctor.practice_frm_year ?? "N/A")")
                                    .font(.caption2)
                                    .foregroundColor(.secondary)
                                Spacer()
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
        }
        .navigationTitle("All Doctors")
        .navigationBarTitleDisplayMode(.large)
        .task {
            await viewModel.loadDoctors()
        }
        .refreshable {
            await viewModel.loadDoctors()
        }
    }
}

#Preview {
    NavigationView {
        DoctorsListView()
    }
}
