// SponsorAnimalSheet.swift
// ShelterApp
//
// Created by Halle Black on 11/30/24.


import SwiftUI
import FirebaseFirestore

struct SponsorAnimalSheet: View {
    @Binding var animal: PetFinderAnimal
    @Binding var showThankYouMessage: Bool
    @Binding var showDonationForm: Bool
    @Environment(\.dismiss) var dismiss

    @State private var donationAmount: String = ""
    @State private var creditCardNumber: String = ""
    @State private var expirationDate: String = ""
    @State private var cvv: String = ""

    var body: some View {
        VStack {
            if showThankYouMessage {
                // Thank you message
                Text("Thank you for sponsoring \(animal.name)!")
                    .font(.headline)
                    .padding()

                Button("Close") {
                    // Dismiss the sheet when the user presses "Close"
                    dismiss()
                    showDonationForm = false
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
            } else {
                // Donation Form
                Form {
                    Section {
                        Text("You are donating to \(animal.name), a \(animal.age) \(animal.species.lowercased()) \(animal.breeds.primary).")
                            .font(.subheadline)
                            .italic()
                            .padding(.bottom)
                    }
                    
                    Section(header: Text("Donation Details")) {
                        TextField("Donation Amount", text: $donationAmount)
                            .keyboardType(.decimalPad)
                        TextField("Credit Card Number", text: $creditCardNumber)
                            .keyboardType(.numberPad)
                        TextField("Expiration Date", text: $expirationDate)
                            .keyboardType(.numbersAndPunctuation)
                        TextField("CVV", text: $cvv)
                            .keyboardType(.numberPad)
                    }
                    
                    Button("Donate") {
                    
                        showThankYouMessage = true
                    }
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
            }
        }
        .padding()
    }
}
