//
//  PetFinderAPI.swift
//  ShelterApp
//
//  Created by Halle Black on 11/30/24.
//


import Foundation
import Combine

class PetFinderAPI: ObservableObject {
    @Published var animals: [PetFinderAnimal] = []
    private let clientId = "UD2koBldxIGQUTxy3rn4vQ7Asm69frKNxWksK9049FUek7unmk"
    private let clientSecret = "nf5Nf4c4iynid02vrldnpQ4K6N6Y7hvQtKkOAFq9"
    private var accessToken: String?

    func fetchAccessToken(completion: @escaping () -> Void) {
        let url = URL(string: "https://api.petfinder.com/v2/oauth2/token")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        let body = "grant_type=client_credentials&client_id=\(clientId)&client_secret=\(clientSecret)"
        request.httpBody = body.data(using: .utf8)

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("Error fetching access token: \(error)")
                return
            }

            guard let data = data else { return }
            do {
                let response = try JSONDecoder().decode(TokenResponse.self, from: data)
                self.accessToken = response.accessToken
                completion()
            } catch {
                print("Error decoding access token response: \(error)")
            }
        }.resume()
    }

    func fetchAnimals() {
        guard let accessToken = accessToken else {
            fetchAccessToken { self.fetchAnimals() }
            return
        }

        let url = URL(string: "https://api.petfinder.com/v2/animals")!
        var request = URLRequest(url: url)
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("Error fetching animals: \(error)")
                return
            }

            guard let data = data else { return }
            do {
                let response = try JSONDecoder().decode(AnimalResponse.self, from: data)
                DispatchQueue.main.async {
                    self.animals = response.animals
                }
            } catch {
                print("Error decoding animal data: \(error)")
            }
        }.resume()
    }
}

struct TokenResponse: Decodable {
    let accessToken: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
    }
}

struct AnimalResponse: Decodable {
    let animals: [PetFinderAnimal]
}

struct PetFinderAnimal: Identifiable, Codable {
    var id: Int 
    var name: String
    var species: String
    var breeds: Breeds
    var age: String
    var gender: String
    var photos: [Photo]
}


struct Breeds: Codable {
    var primary: String
}

struct Photo: Codable {
    var medium: String
}

