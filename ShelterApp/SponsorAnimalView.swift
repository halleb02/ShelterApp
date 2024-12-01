//
//  SponsorAnimalView.swift
//  ShelterApp
//
//  Created by Halle Black on 11/29/24.
//

import SwiftUI

struct SponsorAnimalView: View {
    @StateObject private var api = PetFinderAPI()
    @State private var showDonationForm: Bool = false
    @State private var selectedAnimal: PetFinderAnimal = PetFinderAnimal(id: 0, name: "", species: "", breeds: Breeds(primary: ""), age: "", gender: "", photos: [])
    @State private var showThankYouMessage: Bool = false

    var body: some View {
        NavigationView {
            List(api.animals) { animal in
                HStack {
                    if let photoURL = URL(string: animal.photos.first?.medium ?? "") {
                        AsyncImage(url: photoURL) { phase in
                            switch phase {
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(10)
                            case .failure(_):
                                Image(systemName: "photo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(10)
                            case .empty:
                                ProgressView()
                                    .frame(width: 100, height: 100)
                            @unknown default:
                                EmptyView()
                            }
                        }
                    } else {
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .cornerRadius(10)
                    }

                    VStack(alignment: .leading) {
                        Text(animal.name)
                            .font(.headline)
                        Text("\(animal.species) - \(animal.breeds.primary)")
                            .font(.subheadline)
                        Text("Age: \(animal.age), Gender: \(animal.gender)")
                            .font(.caption)
                    }

                    Spacer()

                    Button(action: {
                        selectedAnimal = animal
                        showThankYouMessage = false
                        showDonationForm = true
                    }) {
                        Text("Sponsor")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
            }
            .onAppear {
                api.fetchAnimals()
            }
            .navigationTitle("Sponsor an Animal")
            .sheet(isPresented: $showDonationForm) {
                SponsorAnimalSheet(animal: $selectedAnimal, showThankYouMessage: $showThankYouMessage, showDonationForm: $showDonationForm)
            }
            .onChange(of: showThankYouMessage) { newValue in
                if newValue {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        showDonationForm = false
                    }
                }
            }
        }
    }
}

