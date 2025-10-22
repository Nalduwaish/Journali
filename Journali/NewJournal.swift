////
////  New Journal.swift
////  Journali
////
////  Created by Najla on 29/04/1447 AH.
////
//
//import SwiftUI
//
//struct NewJournal: View {
//    private let purple = Color(red: 127/255, green: 129/255, blue: 255/255) // #D4C8FF
//    @State private var titleText = ""
//    @State private var bodyText = ""
//    
//    var body: some View {
//        ZStack(alignment: .top) {
//            
//            
//            
//        ContainerRelativeShape()
//            .fill(Color(red: 28/255, green: 28/255, blue: 30/255))
//        
//            Capsule()
//                    .fill(Color.gray.opacity(0.5))
//                    .frame(width: 40, height: 5)
//                    .padding(.top, 12)
//        //checkmark button
//            HStack{
//                
//                Button(action: {
//                })  {
//                    Image(systemName: "xmark")
//                        .font(.system(size: 20, weight: .medium))
//                        .foregroundColor(.white)
//                        .frame(width: 44, height:44)
//                        .glassEffect(.clear .interactive())
//                    
//                    Spacer()
//                    
//                    //Cancel button
//                    Button(action: {
//                    })  {
//                        Image(systemName: "checkmark")
//                            .font(.system(size: 20, weight: .medium))
//                            .foregroundColor(.black)
//                            .frame(width: 44, height:44)
//                            .glassEffect(.regular.tint(purple).interactive())
//                        
//                        
//                        
//                    }
//                
//            }
//                .padding(.horizontal, 24)
//                .padding(.top, 30)
//              //  Spacer()
//            }
//            VStack (alignment: .leading, spacing: 12)  {
//                TextField("Title", text: $titleText)
//                    .font(Font.largeTitle.bold())
//                    .foregroundColor(Color(.white))
//                    
//
//                
//                
//                Text(Date.now.formatted(.dateTime.day().month().year()))
//                    .padding(.bottom, 10)
//                
//                    .font(.title3)
//                    .foregroundColor(Color(.gray))
//                
//                TextField("Type your Journal…", text: $bodyText)
//                    .font(.title.weight(.regular))
//                    .foregroundColor(Color(.white))
//                    .padding(.top, 26)
//                    
//                    
//                ZStack {
//                    
//                    Rectangle()
//                    
//                        .frame(width: 300, height: 212)
//                        .cornerRadius(50)
//                        .glassEffect(.clear, in: .rect(cornerRadius: 50))
//                    
//                    VStack {
//                    Text("Are you sure you want to discard \nchanges on this journal?")
//                        .font(.system(size: 17, weight: .regular))
//                        .foregroundColor(.white)
//                        
//                    
//                    
//                               
//                            
//                        }
//                    }
//                }
//                    
//                
//                
//            }
//            .padding(.horizontal, 24)
//            .padding(.top, 100)
//            
//        }
//        
//        }
//    }
//
//       
//    
//
//
//#Preview {
//    NewJournal()
//}
//
import SwiftUI

struct NewJournal: View {
    private let purple = Color(red: 127/255, green: 129/255, blue: 255/255)

    @State private var titleText = ""
    @State private var bodyText  = ""
    @State private var showDiscard = false

    var body: some View {
        ZStack(alignment: .top) {
            // ===== Background
            ContainerRelativeShape()
                .fill(Color(red: 28/255, green: 28/255, blue: 30/255))
                .ignoresSafeArea()

            // ===== Grabber
            Capsule()
                .fill(Color.gray.opacity(0.5))
                .frame(width: 40, height: 5)
                .padding(.top, 12)

            // ===== Top bar
            VStack(spacing: 0) {
                HStack {
                    // X (left)
                    Button {
                        showDiscard = true
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(.white)
                            .frame(width: 44, height: 44)
                    }
//                    .background(Circle().fill(.ultraThinMaterial))
                    .glassEffect(.clear.interactive())

                    Spacer()

                    // Checkmark (right)
                    Button {
                        // save action here
                    } label: {
                        Image(systemName: "checkmark")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(.black)
                            .frame(width: 44, height: 44)
                    }
//                    .background(
//                        Circle().fill(.ultraThinMaterial)
                    .glassEffect(.regular.tint(purple).interactive())
                    
                }
                .padding(.horizontal, 24)
                .padding(.top, 30)

                // ===== Editor content
                VStack(alignment: .leading, spacing: 12)  {
                    TextField("Title", text: $titleText)
                                        .font(Font.largeTitle.bold())
                                        .foregroundColor(Color(.white))
                                        .tint(purple)
                    
                    
                    
                    
                                    Text(Date.now.formatted(.dateTime.day().month().year()))
                                        .padding(.bottom, 10)
                    
                                        .font(.title3)
                                        .foregroundColor(Color(.gray))
                    
                                    TextField("Type your Journal…", text: $bodyText)
                                        .font(.title.weight(.regular))
                                        .foregroundColor(Color(.white))
                                        .padding(.top, 26)
                                        .tint(purple)
                }
                .padding(.horizontal, 24)
                .padding(.top, 24)
               
                Spacer(minLength: 24)
            }

            // ===== Confirm Discard Dialog (overlay)
            if showDiscard {
                Color.black.opacity(0.35)
                    .ignoresSafeArea()
                    .onTapGesture { withAnimation { showDiscard = false } }

                VStack(spacing: 40) {
                    // Grabber inside dialog
//                    Capsule()
//                        .fill(Color.white.opacity(0.35))
//                        .frame(width: 36, height: 5)
//                        .padding(.top, 10)

                    Text("Are you sure you want to discard\nchanges on this journal?")
                        .font(.headline)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.white.opacity(0.9))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 20)
                        .padding(.top, 20)

                    VStack(spacing: 10) {
                        // Destructive
                        Button {
                            // discard action
                            withAnimation { showDiscard = false }
                            titleText = ""
                            bodyText = ""
                        } label: {
                            Text("Discard Changes")
                                .font(.headline)
                                .foregroundColor(.red)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                                .background(
                                    Capsule()
                                        .fill(.ultraThinMaterial)
                                        .overlay(Capsule().stroke(Color.white.opacity(0.10)))
                                )
                        }

                        // Cancel
                        Button {
                            withAnimation { showDiscard = false }
                        } label: {
                            Text("Keep Editing")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                                .background(
                                    Capsule()
                                        .fill(.ultraThinMaterial)
                                        .overlay(Capsule().stroke(Color.white.opacity(0.08)))
                                )
                        }
                    }
                    .padding(.horizontal, 14)
                    .padding(.bottom, 14)
                }
                .frame(width: 300, height: 212)
                .background(
                   RoundedRectangle(cornerRadius: 28, style: .continuous)
                      // .fill(.ultraThinMaterial)
                       .glassEffect(.clear, in: .rect(cornerRadius: 28))
                     
                )
                .padding(.horizontal, 50)
                .transition(.scale(scale: 0.96).combined(with: .opacity))
                .zIndex(1)
                

            }
        }
        .animation(.spring(response: 0.35, dampingFraction: 0.9), value: showDiscard)
    }
}

#Preview { NewJournal() }

