//
//  SwiftUIView.swift
//  Journali
//
//  Created by Najla on 28/04/1447 AH.
//

import SwiftUI

struct EmptyState: View {
    
    private let purple = Color(red: 212/255, green: 200/255, blue: 255/255) // #D4C8FF
    @State private var text = ""
    var body: some View {
        VStack {
            
            HStack {
                Text("Journal")
                    .font(Font.largeTitle.bold())
                Spacer()
                
                HStack(spacing:20) {
                    Button(action: {
                        // sort action
                    }) {
                        Image(systemName: "line.3.horizontal.decrease")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(.gray)
                            .frame(width: 36, height:36)
                            
                        
                        
                    }
                    // Add journal button
                    Button(action: {
                    })  {
                        Image(systemName: "plus")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(.gray)
                            .frame(width: 36, height:36)
                            
                        
                    }
                }
                .frame(width: 104, height:48)
                .padding(.horizontal, 6)
                .padding(.vertical, 6)
                .glassEffect(.clear .interactive())
                
            
            }
            
            .padding(.horizontal)
            .padding(.top, 1)
            
        }
        ZStack { // this fills the screen by default
            Color(.systemBackground) // optional background
                .ignoresSafeArea() // ensures it covers edges
            
            VStack(alignment: .center) {
                Image("Book")
                    .resizable()
                    .frame(width: 151.39 , height: 97.32)
                    .padding(34.62)
                
                Text("Begin Your Journal")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(purple)
                    .padding(16)
                
                Text("Craft your personal diary,Tap the \nplus icon to begin")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 18, weight: .light))
                    .foregroundColor(.gray)
                    .padding(.horizontal)
            }
            // This centers the VStack inside the ZStack
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        //        HStack {
        //            // search bar
        //            Button(action: {
        //            })  {
        //
        //                Image(systemName: "magnifyingglass")
        //                    .font(.system(size: 17, weight: .medium))
        //                    .foregroundColor(.gray)
        //                    .frame(width: 36, height:36)
        //                Text("Search")
        //                    .font(.system(size: 17, weight: .light))
        //                    .foregroundColor(.gray)
        //
        //            }
        //
        //            Spacer()
        //
        //
        //
        //            // Mic button
        //            Button(action: {
        //            })  {
        //                Image(systemName: "microphone")
        //                    .font(.system(size: 17, weight: .medium))
        //                    .foregroundColor(.gray)
        //                    .frame(width: 36, height:36)
        //            }
        //            .frame(width: 393, height:56)
        //            .padding(.horizontal, 6)
        //            .padding(.vertical, 6)
        //            .glassEffect(.clear, in: .rect(cornerRadius: 50))
        //        }
        //    }
        
        HStack {
            // Search (left)
            Button(action: {}) {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 17, weight: .medium))
                        .foregroundColor(.gray)
                        .frame(width: 36, height: 36)
                    
                    TextField("Search", text: $text)
                        .multilineTextAlignment(.leading)
                        .padding()
                     //   .font(.system(size: 17, weight: .light))
                        .foregroundColor(.gray)
                      //  .glassEffect()
                   
                }
            }
            
            Spacer() // pushes mic to the far right
            
            // Mic (right)
            Button(action: {}) {
                Image(systemName: "microphone")
                    .font(.system(size: 17, weight: .medium))
                    .foregroundColor(.gray)
                    .frame(width: 36, height: 36)
                   // .scaleEffect(isPressed ? 0.9 : 1.0)
                
                    
            }
        }
        .padding(.horizontal, 12)
        .frame(maxWidth: 393, minHeight: 56)     // responsive width
        .background(                                   // apply style to the container, not a button
            Capsule()
                .fill(Color.clear)
                
        )
        .clipShape(Capsule())
        .glassEffect(.clear.interactive())
    }
}

#Preview {
    EmptyState()
}
