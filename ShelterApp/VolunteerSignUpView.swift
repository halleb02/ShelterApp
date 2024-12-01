//
//  VolunteerSignUpView.swift
//  ShelterApp
//
//  Created by Halle Black on 11/29/24.
//

import SwiftUI
import Firebase

struct VolunteerSignUpView: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var phoneNumber = ""
    @State private var birthDate = Date()
    @State private var availability = ""
    @State private var isUnderage = false
    @State private var isFormSubmitted = false
    @State private var errorMessage: String?
    
    let minAge: Int = 16

    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Volunteer Sign Up")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                TextField("First Name", text: $firstName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextField("Last Name", text: $lastName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .padding()
                
                TextField("Phone Number", text: $phoneNumber)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.phonePad)
                    .padding()
                
                DatePicker("Birthdate", selection: $birthDate, in: ...Date(), displayedComponents: .date)
                    .padding()
                
                TextField("Availability (e.g., Weekends, Weekdays)", text: $availability)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                if isUnderage {
                    Text("You must be at least \(minAge) years old to sign up.")
                        .foregroundColor(.red)
                }
                
                Button(action: {
                    checkAgeAndSubmitForm()
                }) {
                    Text("Submit")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                
                if isFormSubmitted {
                    Text("Thank you for signing up! You will be contacted soon.")
                        .foregroundColor(.green)
                        .padding()
                }
                
                Spacer()
            }
            .padding()
        }
    }

    
    private func checkAgeAndSubmitForm() {
        let age = Calendar.current.dateComponents([.year], from: birthDate, to: Date()).year ?? 0
        if age >= minAge {
            isUnderage = false
            isFormSubmitted = true
            submitVolunteerForm()
        } else {
            isUnderage = true
            errorMessage = "You must be at least \(minAge) years old to sign up."
        }
    }
    
    private func submitVolunteerForm() {
        let db = Firestore.firestore()
        db.collection("volunteers").addDocument(data: [
            "firstName": firstName,
            "lastName": lastName,
            "email": email,
            "phoneNumber": phoneNumber,
            "birthDate": birthDate.timeIntervalSince1970,
            "availability": availability,
            "isUnderage": isUnderage
        ]) { error in
            if let error = error {
                self.errorMessage = "Error adding volunteer: \(error.localizedDescription)"
            } else {
                self.errorMessage = nil
            }
        }
    }
}
