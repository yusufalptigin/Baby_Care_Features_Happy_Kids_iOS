//
//  Baby Care.swift
//  Happy Kids Feature
//
//  Created by Yusuf Alp Tigin Gün on 6.02.2023.
//

import SwiftUI // Uyku Emzirme Bebek Bezi

struct Baby_Care: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @AppStorage("username") var username: String = "Anonymous"
    @StateObject var hkViewModel = HKViewModel()
    
    @State private var showActionSheet: Bool = false
    @State private var showCamera: Bool = false
    @State private var showGallery: Bool = false
    @State private var page = "Yemek"
    @State private var foodPage: String = "Emzirme"
    @State private var activityPage: String = "Bebek Bezi"
    @State private var healthPage: String = "Doktor"
    @State private var showPdfSheet: Bool = false
    @AppStorage("Baby_Care_Image") var selectedImageData: Data?
    let choices: Choices = Choices()

    var body: some View {
        if #available(iOS 15.0, *) {
            ZStack(alignment: .bottomTrailing) {
                VStack {
                    Group {
                        //  if "reklam resmi koymuşsak" {
                        //      AsyncImage (iOS 15.0+), UIImage, Image vs. widgetı
                        //  } else {
                        if let data = selectedImageData, let uiImage = UIImage(data: data) { Image(uiImage: uiImage).resizable() }
                        else {Image( "baby_care").resizable() }
                        //  }
                    }.frame(width: screenWidth, height: 250)
                    Picker("", selection: $page) {
                        ForEach(choices.pages, id: \.self) { page in
                            Text(page)
                        }
                    }.padding(.all, 10.0).pickerStyle(.segmented)
                    if page == "Yemek" { Console_Model(choiceNames: choices.foodChoices).environmentObject(hkViewModel) }
                    else if page == "Aktivite" { Console_Model(choiceNames: choices.activityChoices).environmentObject(hkViewModel) }
                    else if page == "Sağlık" { Console_Model(choiceNames: choices.healthChoices).environmentObject(hkViewModel) }
                    Spacer()
                }.frame(maxHeight: .infinity)
                NavigationLink(destination: Add_Choices().environmentObject(hkViewModel)){ Floating_Action_Button() }.padding([.bottom, .trailing], 20)
            }.onAppear { onApperBabyCare(hkViewModel: hkViewModel) }.navigationTitle("Bebek Bakımı")
                .navigationBarBackButtonHidden(true)
                .navigationBarTitleDisplayMode(.inline)
            /* iOS 16.0+
             .toolbarBackground(.visible, for: .navigationBar)
             .toolbarBackground(Color.navBarColor, for: .navigationBar)
             .toolbarColorScheme(.dark, for: .navigationBar)
             */
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading){
                        Button(action: { mode.wrappedValue.dismiss() })
                        { Image(systemName: "chevron.backward").foregroundColor(.white) }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        HStack {
                            if selectedImageData != nil { Button(action: { selectedImageData = nil }) { Image(systemName: "trash") } }
                            Button(action: { showActionSheet.toggle() }) { Image(systemName: "camera") }
                        }.foregroundColor(.white)
                    }
                }.confirmationDialog("", isPresented: $showActionSheet) {
                    Button("Kamera") { showCamera.toggle() }
                    Button("Galeri") { showGallery.toggle() }
                }
                .sheet(isPresented: $showGallery) { ImagePicker(selectedImageData: $selectedImageData, sourceType: .savedPhotosAlbum).ignoresSafeArea() }
                .sheet(isPresented: $showCamera){ ImagePicker(selectedImageData: $selectedImageData, sourceType: .camera).ignoresSafeArea() }
        } else {
            ZStack(alignment: .bottomTrailing) {
                VStack {
                    Group {
                        //  if "reklam resmi koymuşsak" {
                        //      AsyncImage (iOS 15.0+), UIImage, Image vs. widgetı
                        //  } else {
                        if let data = selectedImageData, let uiImage = UIImage(data: data) { Image(uiImage: uiImage).resizable() }
                        else {Image( "baby_care").resizable() }
                        //  }
                    }.frame(width: screenWidth, height: 250)
                    Picker("", selection: $page) {
                        ForEach(choices.pages, id: \.self) { page in
                            Text(page)
                        }
                    }.padding(.all, 10.0).pickerStyle(.segmented)
                    if page == "Yemek" { Console_Model(choiceNames: choices.foodChoices).environmentObject(hkViewModel) }
                    else if page == "Aktivite" { Console_Model(choiceNames: choices.activityChoices).environmentObject(hkViewModel) }
                    else if page == "Sağlık" { Console_Model(choiceNames: choices.healthChoices).environmentObject(hkViewModel) }
                    Spacer()
                }.frame(maxHeight: .infinity)
                NavigationLink(destination: Add_Choices().environmentObject(hkViewModel)){ Floating_Action_Button() }.padding([.bottom, .trailing], 20)
            }.onAppear { onApperBabyCare(hkViewModel: hkViewModel) }.navigationTitle("Bebek Bakımı")
                .navigationBarBackButtonHidden(true).navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading){
                        Button(action: { mode.wrappedValue.dismiss() })
                        { Image(systemName: "chevron.backward").foregroundColor(.white) }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        HStack(spacing: 0) {
                            if selectedImageData != nil { Button(action: { selectedImageData = nil }) { Image(systemName: "trash") } }
                            Button(action: { showGallery.toggle() }) { Image(systemName: "photo") }
                            Button(action: { showCamera.toggle() }) { Image(systemName: "camera") }
                        }.foregroundColor(.white)
                    }
                }
                .sheet(isPresented: $showGallery) { ImagePicker(selectedImageData: $selectedImageData, sourceType: .savedPhotosAlbum).ignoresSafeArea() }
                .sheet(isPresented: $showCamera){ ImagePicker(selectedImageData: $selectedImageData, sourceType: .camera).ignoresSafeArea() }
        }
    }
}
