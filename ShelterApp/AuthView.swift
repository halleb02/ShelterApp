// AuthView.swift
// ShelterApp
//
// Created by Halle Black on 11/29/24.

import SwiftUI
import FirebaseAuth

struct AuthView: View {
    @EnvironmentObject private var authViewModel: AuthViewModel

    @State private var email = ""
    @State private var password = ""
    @State private var isSignUp = false

    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome to Lee County Humane Society!")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 40)

                Spacer().frame(height: 50)

                VStack(spacing: 20) {
                    TextField("Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)

                    SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    if let errorMessage = authViewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding()
                    }

                    Button(action: {
                        if isSignUp {
                            authViewModel.registerUser(email: email, password: password)
                        } else {
                            authViewModel.signInUser(email: email, password: password)
                        }
                    }) {
                        Text(isSignUp ? "Sign Up" : "Sign In")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }

                    Button(action: {
                        isSignUp.toggle()
                    }) {
                        Text(isSignUp ? "Already have an account? Sign In" : "Don't have an account? Sign Up")
                            .foregroundColor(.blue)
                    }
                }
                .padding()
            }
            .navigationBarHidden(true) 
        }
    }
}

