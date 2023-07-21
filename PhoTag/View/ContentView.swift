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
    
    var body: some View {
        ZStack {
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
            } else {
                NavigationView {
                    List(viewModel.taggedPhotos) { taggedPhoto in
                        NavigationLink(destination: TaggedPhotoDetailView(taggedPhoto: taggedPhoto)) {
                            TaggedPhotoListRow(taggedPhoto: taggedPhoto)
                        }
                    }
                    .navigationTitle("PhoTag")
                }
            }
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button {
                        showingAddSheet = true
                    } label: {
                        Image(systemName: "photo.stack")
                            .padding(8)
                            .background(.blue)
                            .foregroundColor(.white)
                            .font(.title)
                            .clipShape(Circle())
                            .padding(.trailing)
                    }
                }
            }
            .sheet(isPresented: $showingAddSheet) {
                ImagePicker(image: $newImage)
            }
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
        showingDescriptionSheet = true
    }
    
    func addNewImage() {
        guard newImageDescription != "" else { return }
        guard let img = newImage else { return }
        
        var tp = TaggedPhoto()
        tp.description = newImageDescription
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
        viewModel.taggedPhotos.append(newTaggedPhoto!)
        viewModel.save()
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
        for _ in 1...30 {
            vm.taggedPhotos.append(TaggedPhoto.example)
        }
        
        return Group {
            ContentView()
            ContentView(viewModel: vm)
        }
    }
}
