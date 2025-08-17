import Foundation

final class APIClient {
    static let shared = APIClient()
    
    private init() {}
    
    // MARK: - Doctor Registration
    func registerDoctor(payload: RegistrationPayload) async throws -> Doctor {
        let url = URL(string: Endpoints.baseURL + Endpoints.registerPath)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let bodyData = try JSONEncoder().encode(payload)
        
        do {
            let (data, response) = try await URLSession.shared.upload(for: request, from: bodyData)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw URLError(.badServerResponse)
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                print("HTTP Error: Status code \(httpResponse.statusCode)")
                throw URLError(.badServerResponse)
            }
            
            print("Raw response for registration: \(String(data: data, encoding: .utf8) ?? "Unable to decode")")
            
            let wrapped = try JSONDecoder().decode(ODataSingle<Doctor>.self, from: data)
            return wrapped.d
            
        } catch let decodingError as DecodingError {
            print("Decoding error for registration: \(decodingError)")
            throw decodingError
        } catch {
            print("Network error for registration: \(error)")
            throw error
        }
    }
    
    // MARK: - Fetch Doctors List
    func fetchDoctorsList() async throws -> [Doctor] {
        let url = URL(string: Endpoints.baseURL + Endpoints.listPath)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw URLError(.badServerResponse)
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                print("HTTP Error: Status code \(httpResponse.statusCode)")
                throw URLError(.badServerResponse)
            }
            
            print("Raw response for doctors list: \(String(data: data, encoding: .utf8) ?? "Unable to decode")")
            
            let wrapped = try JSONDecoder().decode(ODataCollection<Doctor>.self, from: data)
            return wrapped.d.results
            
        } catch let decodingError as DecodingError {
            print("Decoding error for doctors list: \(decodingError)")
            throw decodingError
        } catch {
            print("Network error for doctors list: \(error)")
            throw error
        }
    }
    
    // MARK: - Fetch Doctor Detail
    func fetchDoctorDetail(guid: String) async throws -> Doctor {
        let url = URL(string: Endpoints.baseURL + Endpoints.detailPath + "(guid'\(guid)')")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw URLError(.badServerResponse)
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                print("HTTP Error: Status code \(httpResponse.statusCode)")
                throw URLError(.badServerResponse)
            }
            
            print("Raw response for doctor detail: \(String(data: data, encoding: .utf8) ?? "Unable to decode")")
            
            let wrapped = try JSONDecoder().decode(ODataSingle<Doctor>.self, from: data)
            return wrapped.d
            
        } catch let decodingError as DecodingError {
            print("Decoding error for doctor detail: \(decodingError)")
            throw decodingError
        } catch {
            print("Network error for doctor detail: \(error)")
            throw error
        }
    }
}
