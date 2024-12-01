//
//  ContentView.swift
//  ShelterApp
//
//  Created by Halle Black on 11/29/24.
//

import Foundation
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        VStack {
            Text("Welcome to the Shelter App!")
                .font(.largeTitle)
                .padding()
            
            Button(action: {
                authViewModel.signOut()
            }) {
                Text("Sign Out")
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
    }
}
