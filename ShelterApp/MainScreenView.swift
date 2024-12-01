// MainScreenView.swift
// ShelterApp
//
// Created by Halle Black on 11/29/24.

import SwiftUI

struct MainScreenView: View {
    @EnvironmentObject private var authViewModel: AuthViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Text("Welcome to Lee County Humane Society!")
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Text("Auburn, Alabama")
                        .font(.title3)
                        .padding()
                    
                    Text("""
                    At the Lee County Humane Society, we are dedicated to improving the lives of animals through rescue, shelter, and adoption services. We aim to create a compassionate community for all animals.
                    """)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    
                    Text("Our mission is to save and enhance the lives of animals in our care while advocating for their safety, health, and wellbeing.")
                        .italic()
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    // Sign Up to Volunteer Button
                    NavigationLink(destination: VolunteerSignUpView()) {
                        Text("Sign Up to Volunteer")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)

                    // Donate Supplies via Amazon Button
                    Link("Donate Supplies via Amazon", destination: URL(string: "https://www.amazon.com/s?k=animal+shelter+supplies&crid=3UQJXKAMAV2VS&sprefix=animal+shelter+supplie%2Caps%2C365&ref=nb_sb_noss_2")!)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.yellow)
                        .cornerRadius(10)
                    .padding(.horizontal)
                    
                    // Sponsor an Animal Button
                    NavigationLink(destination: SponsorAnimalView()) {
                        Text("Sponsor an Animal")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    // Log Out Button
                    Button(action: {
                        authViewModel.signOut()
                    }) {
                        Text("Log Out")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                }
                .padding(.top) 
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

