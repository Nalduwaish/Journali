//
//  ContentView.swift
//  Journali
//
//  Created by Najla on 27/04/1447 AH.
//

import SwiftUI

struct SplashScreen: View {
    var body: some View {
        VStack {
            Image("Journali logo")
                .resizable()
                .frame(width: 77.7 , height: 101)
                .padding(24.23)
            Text("Journali")
                .font(.system(size: 42, weight: .black))
                .padding(11)
            Text("Your thoughts, your story")
                .font(.system(size: 18, weight: .light))
        }
        .padding()
    }
}

#Preview {
    SplashScreen()
}
