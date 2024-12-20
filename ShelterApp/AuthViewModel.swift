//
//  AuthViewModel.swift
//  ShelterApp
//
//  Created by Halle Black on 11/29/24.
//

import SwiftUI
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var isUserAuthenticated: Bool = false
    @Published var errorMessage: String?

    init() {
        // Check if user is already logged in
        self.isUserAuthenticated = Auth.auth().currentUser != nil
    }

    func signInUser(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    self.isUserAuthenticated = false
                } else {
                    self.isUserAuthenticated = true
                }
            }
        }
    }

    func registerUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    self.isUserAuthenticated = false
                } else {
                    self.isUserAuthenticated = true
                }
            }
        }
    }

    func resetErrorMessage() {
        self.errorMessage = nil
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
            self.isUserAuthenticated = false
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
}

