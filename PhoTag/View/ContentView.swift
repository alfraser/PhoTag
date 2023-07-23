//
//  ContentView.swift
//  PhoTag
//
//  Created by Al Fraser on 18/07/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    
    @State var showingAddSheet = false
    @State var newImage: UIImage?
    
    @State var showingDescriptionSheet = false
    @State var newImageDescription = ""
    @State var newTaggedPhoto: TaggedPhoto?
    
    let locationFetcher = LocationFetcher()
    
    var body: some View {
        Group {
            if viewModel.taggedPhotos.count == 0 {
                VStack {
                    Image(systemName: "text.below.photo")
                        .font(.largeTitle)
                        .foregroundColor(.blue)
                    Text("PhoTag")
                        .font(.custom("Verdana", size: 48))
                        .bold()
                        .italic()
                        .padding()
                    Text("Click add below to get tagging")
                }
                .withSystemImageButton(systemImage: "photo.stack") {
                    showingAddSheet = true
                }
            } else {
                NavigationView {
                    List(viewModel.taggedPhotos) { taggedPhoto in
                        NavigationLink(destination: TaggedPhotoDetailView(taggedPhoto: taggedPhoto, viewModel: viewModel)) {
                            TaggedPhotoListRow(taggedPhoto: taggedPhoto)
                        }
                    }
                    .withSystemImageButton(systemImage: "photo.stack") {
                        showingAddSheet = true
                    }
                    .navigationTitle("PhoTag")
                }
            }
        }
        .sheet(isPresented: $showingAddSheet) {
            ImagePicker(image: $newImage)
        }
        .sheet(isPresented: $showingDescriptionSheet) {
            Form {
                TextField("Photo description", text: $newImageDescription)
                HStack {
                    Spacer()
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                        .onTapGesture {
                            reset()
                            showingDescriptionSheet = false
                        }
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.blue)
                        .onTapGesture {
                            addNewImage()
                            showingDescriptionSheet = false
                        }
                    Spacer()
                }
            }
        }
        .onChange(of: newImage) { _ in
            loadNewImage()
        }
    }
    
    func loadNewImage() {
        guard newImage != nil else { return }
        newImageDescription = ""
        locationFetcher.start()
        showingDescriptionSheet = true
    }
    
    func addNewImage() {
        guard newImageDescription != "" else { return }
        guard let img = newImage else { return }
        
        var tp = TaggedPhoto()
        tp.description = newImageDescription
        
        if let loc = locationFetcher.lastKnownLocation {
            print("Adding location")
            tp.latitude = loc.latitude
            tp.longitude = loc.longitude
        } else {
            print("No location available")
        }
        
        newTaggedPhoto = tp
        
        let imgSaver = ImageSaver()
        imgSaver.successHandler = imageSaved
        imgSaver.writeToDocumentsDirectoryAsJPEG(image: img, id: tp.id)
    }
    
    func reset() {
        newImage = nil
        newTaggedPhoto = nil
        newImageDescription = ""
    }
    
    func imageSaved() {
        guard newTaggedPhoto != nil else {
            print("State error - image was saved but no newTaggedPhoto available")
            reset()
            return
        }
        viewModel.appendPhoto(newTaggedPhoto!)
        reset()
    }
    
    func imageSaveFailed(error: Error?) {
        print("Error in saving image to filesystem: \(error?.localizedDescription ?? "Error in JPG conversion")")
        reset()
    }
}

struct TaggedPhotoListRow: View {
    @State var taggedPhoto: TaggedPhoto
    
    var body: some View {
        HStack() {
            if taggedPhoto.image == nil {
                Rectangle()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.blue)
            } else {
                Image(uiImage: taggedPhoto.image!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 30, height: 30)
                    .clipped()
            }
            Text(taggedPhoto.description)
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = ContentView.ViewModel()
        for i in 1...30 {
            let e = TaggedPhoto(id: UUID(), description: "Example \(i)")
            vm.taggedPhotos.append(e)
        }
        
        return Group {
            ContentView()
            ContentView(viewModel: vm)
        }
    }
}
