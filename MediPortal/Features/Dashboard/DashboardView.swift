import SwiftUI

struct DashboardView: View {
    let doctorName: String
    @State private var searchText = ""
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 24) {
                
                // Header Section with greeting
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Hello,")
                            .font(.title2)
                            .foregroundColor(.primary)
                        Text("\(doctorName)!")
                            .font(.title)
                            .bold()
                            .foregroundColor(.primary)
                    }
                    Spacer()
                    Button(action: {}) {
                        Image(systemName: "bell.fill")
                            .font(.title2)
                            .foregroundColor(.orange)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 8)
                
                // Search Bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .padding(.leading, 12)
                    TextField("Search...", text: $searchText)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding(.vertical, 12)
                    Spacer()
                }
                .background(Color(.systemGray6))
                .cornerRadius(25)
                .padding(.horizontal)
                
                // Health Information Card
                VStack(alignment: .leading, spacing: 12) {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Stay Safe")
                                .font(.title3)
                                .bold()
                                .foregroundColor(.white)
                            Text("Stay Healthy!")
                                .font(.title3)
                                .bold()
                                .foregroundColor(.white)
                            Text("An apple a day\nkeeps the\ndoctor away.")
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.9))
                                .lineLimit(nil)
                        }
                        Spacer()
                        VStack {
                            Image(systemName: "cross.case.fill")
                                .font(.system(size: 40))
                                .foregroundColor(.white.opacity(0.8))
                            Image(systemName: "stethoscope")
                                .font(.system(size: 30))
                                .foregroundColor(.white.opacity(0.6))
                                .offset(x: 10, y: -10)
                        }
                    }
                }
                .padding(20)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.8)]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .cornerRadius(16)
                .padding(.horizontal)
                
                // Services Section
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text("At your Fingertip")
                            .font(.title3)
                            .bold()
                            .foregroundColor(.primary)
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 3), spacing: 16) {
                        ForEach(ServiceItem.allServices, id: \.id) { service in
                            ServiceTileView(service: service)
                        }
                    }
                    .padding(.horizontal)
                }
                
                Spacer()
            }
        }
        .navigationBarHidden(true)
        .background(Color(.systemBackground))
    }
}

struct ServiceItem: Identifiable {
    let id = UUID()
    let icon: String
    let title: String
    let backgroundColor: Color
    let iconColor: Color
    
    static let allServices = [
        ServiceItem(icon: "qrcode.viewfinder", title: "Scan", backgroundColor: .orange, iconColor: .white),
        ServiceItem(icon: "cross.vial", title: "Vaccine", backgroundColor: Color(.systemGray6), iconColor: .blue),
        ServiceItem(icon: "calendar.badge.clock", title: "My Bookings", backgroundColor: Color(.systemGray6), iconColor: .blue),
        ServiceItem(icon: "building.2.crop.circle", title: "Clinic", backgroundColor: Color(.systemGray6), iconColor: .blue),
        ServiceItem(icon: "cross.circle", title: "Ambulance", backgroundColor: Color(.systemGray6), iconColor: .blue),
        ServiceItem(icon: "stethoscope.circle", title: "Nurse", backgroundColor: Color(.systemGray6), iconColor: .blue)
    ]
}

struct ServiceTileView: View {
    let service: ServiceItem
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: service.icon)
                .font(.system(size: 24, weight: .medium))
                .foregroundColor(service.iconColor)
                .frame(width: 48, height: 48)
                .background(service.backgroundColor)
                .cornerRadius(12)
            
            Text(service.title)
                .font(.caption)
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
        .background(Color(.systemBackground))
        .onTapGesture {
            // Handle service selection
            print("Selected: \(service.title)")
        }
    }
}

#Preview {
    NavigationView {
        DashboardView(doctorName: "Dr. John Doe")
    }
}
