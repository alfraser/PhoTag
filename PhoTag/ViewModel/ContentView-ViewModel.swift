//
//  ContentView-ViewModel.swift
//  PhoTag
//
//  Created by Al Fraser on 18/07/2023.
//

import Foundation

extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        @Published var taggedPhotos: [TaggedPhoto]
        
        let savePath = FileManager.documentsDirectory.appendingPathComponent("taggedPhotos")
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                taggedPhotos = try JSONDecoder().decode([TaggedPhoto].self, from: data)
            } catch {
                taggedPhotos = []
            }
        }
        
        func save() {
            do {
                let data = try JSONEncoder().encode(taggedPhotos)
                try data.write(to: savePath, options: [.atomicWrite, .completeFileProtection])
            } catch {
                print("Unable to save data")
            }
        }
    }
}

