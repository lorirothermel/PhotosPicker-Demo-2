//
//  ContentView.swift
//  PhotosPicker Demo 2
//
//  Created by Lori Rothermel on 4/8/23.
//

import SwiftUI
import PhotosUI


struct ContentView: View {
    
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    
    
    var body: some View {
        
        ZStack {
            
            Color.indigo
                .ignoresSafeArea()
            
            VStack {
                
                Spacer()
                
                if let selectedImageData, let image = UIImage(data: selectedImageData) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250)
                }  // if let
                
                Spacer()
                
                PhotosPicker(
                    selection: $selectedItem,
                    matching: .images,
                    photoLibrary: .shared()) {
                        Label("Select a photo", systemImage: "photo")
                    }  // PhotosPicker
                    .tint(.cyan)
                    .controlSize(.large)
                    .buttonBorderShape(.roundedRectangle(radius: 10))
                    .buttonStyle(.borderedProminent)
                    .onChange(of: selectedItem) { newItem in
                        Task {
                            // Retrieve selected asset in the form of Data
                            if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                selectedImageData = data
                            }  // if let data
                        }  // Task
                    }  // .onChange
            }  // VStack
            
        }  // ZStack
        
        
    }  // some View
}  // ContentView

        
        
        
        
        
        
        
//        PhotosPicker(selection: $selectedItem, matching: .images, photoLibrary: .shared()) {
//            Text("Select a Photo")
//        }  // PhotosPicker
//        .onChange(of: selectedItem) { newItem in
//            Task {
//                if let data = try? await newItem?.loadTransferable(type: Data.self) {
//                    selectedImage = data
//                }  // if let data
//            }  // Task
//        }  // .onChange
//
//        if let selectedImage,
//           let uiImage = UIImage(data: selectedImage) {
//            Image(uiImage: uiImage)
//                .resizable()
//                .scaledToFit()
//                .frame(width: 300, height: 300, alignment: .center)
//        }
//
//
//    }  // some View
//}  // ContentView

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
