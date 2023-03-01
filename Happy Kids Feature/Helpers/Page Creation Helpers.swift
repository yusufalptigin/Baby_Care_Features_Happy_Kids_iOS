//
//  Start and End Dates.swift
//  Happy Kids Feature
//
//  Created by Yusuf Alp Tigin Gün on 7.02.2023.
//

import SwiftUI
import PhotosUI

struct Long_Invisible_Text: View {
    
    var body: some View {
        Text("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa").opacity(0)
    }
}

struct Display_Image: View {
    
    var image_data: Data?
    
    var body: some View {
        if let image_data = image_data {
            Image(uiImage: UIImage(data: image_data)!)
            .resizable().aspectRatio(1.0, contentMode: .fit).clipShape(Circle()).padding([.top, .trailing, .bottom], 5) }
    }
}

struct Display_Helper_View<Content: View>: View {
    @ViewBuilder var content: Content
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                Spacer().frame(height: screenHeight * 0.02)
                content
            }
        }
    }
}

struct PDF_Display_Image: View {
    
    var image_data: Data?
    
    var body: some View {
        if let image_data = image_data, let uiImage = UIImage(data: image_data) {
            Image(uiImage: uiImage).resizable().frame(width: screenWidth * 0.1, height: screenWidth * 0.1)
        } else { Rectangle().opacity(0).frame(width: screenWidth * 0.1, height: screenWidth * 0.1) }
    }
    
}

struct Empty_Display: View {
    
    var body: some View {
        VStack(spacing: screenHeight * 0.01){
            Text("Kayıt yapmak için \"Bebek Bakımı\" sayfasında sağ alttaki").multilineTextAlignment(.center)
            Image(systemName: "plus").foregroundColor(Color.navBarColor)
            Text("simgesini kullanın.")
        }.frame(width: screenWidth * 0.94)
    }
}

struct Circle_Icon_Display: View {
    
    let iconText: String
    
    var body: some View {
        Image(systemName: iconText)
            .resizable().padding(12).background(Color.navBarColorLight).aspectRatio(1.0, contentMode: .fit)
            .clipShape(Circle()).padding([.top, .leading, .bottom], 5).foregroundColor(Color.navBarColor)
    }
}

struct Circle_Icon_Display_Image: View {
    
    let iconText: String
    
    var body: some View {
        Image(iconText).renderingMode(.template)
            .resizable().padding(12).background(Color.navBarColorLight).aspectRatio(1.0, contentMode: .fit)
            .clipShape(Circle()).padding([.top, .leading, .bottom], 5).foregroundColor(Color.navBarColor)
    }
}

struct Status_Bar_Color_Display: View {
    
    var body: some View {
        GeometryReader { reader in
            Color.navBarColor
                .frame(height: reader.safeAreaInsets.top, alignment: .top)
                .ignoresSafeArea()
        }
    }
}

struct Floating_Action_Button: View {
    
    var body: some View {
        Image(systemName: "plus")
          .resizable()
          .aspectRatio(1.0, contentMode: .fit)
          .frame(width: screenWidth * 0.08)
          .foregroundColor(.white)
          .padding(20)
          .background(Color.navBarColor)
          .clipShape(Circle())
    }
}

struct Rounded_Image_Text_Button: View {
    
    let iconText: String
    let buttonText: String
    
    var body: some View {
        HStack {
            Image(systemName: iconText)
            Text(buttonText)
        }.foregroundColor(Color.navBarColor).padding(10)
        .background(RoundedRectangle(cornerRadius: 20).fill(Color.navBarColorLight))
    }
}

struct Choice_Circle_And_Name_View: View {
    
    let iconText: String
    let choiceName: String
    let choiceTitle: String
    
    var body: some View {
        VStack{
            Group {
                if choiceName == "Emzirme" || choiceName == "Biberon" || choiceName == "Mama" || choiceName == "Süt Sağma" || choiceName == "Bebek Bezi" {
                    Image(iconText).resizable().renderingMode(.template)
                } else { Image(systemName: iconText).resizable() }
            }.frame(width: screenWidth * 0.05, height: screenWidth * 0.05).padding(20)
                .foregroundColor(Color.navBarColor).background(Color.navBarColorLight).clipShape(Circle())
            Text(choiceName).font(.footnote).multilineTextAlignment(.center).fixedSize(horizontal: false, vertical: true)
            Spacer()
        }.frame(width: screenWidth * 0.16, height: screenHeight * 0.14).foregroundColor(.black)
    }
}

struct Date_Button: View {
    
    @Binding var showSheet: Bool
    @Binding var date: Date
   
    var body: some View {
        Button(action: {showSheet.toggle()}){
            Rectangle()
                .strokeBorder(Color.navBarColor, lineWidth: 4)
                .background(Rectangle().fill(Color.navBarColorLight))
                .cornerRadius(5)
                .overlay(HStack{
                    Spacer().frame(width: screenWidth * 0.04)
                    Text(dateToString(date)).foregroundColor(Color.black)
                    Spacer()
                })
                .frame(width: screenWidth * 0.9, height: screenHeight * 0.07)
        }
    }
}

struct Start_and_End_Dates: View {
    
    @Binding var showStartDatePicker: Bool
    @Binding var showEndDatePicker: Bool
    @Binding var startDate: Date
    @Binding var endDate: Date
    
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Başlangıç")
            Spacer().frame(height: screenHeight * 0.009)
            Date_Button(showSheet: $showStartDatePicker, date: $startDate)
            Spacer().frame(height: screenHeight * 0.02)
            Text("Bitiş")
            Spacer().frame(height: screenHeight * 0.009)
            Date_Button(showSheet: $showEndDatePicker, date: $endDate)
            Spacer().frame(height: screenHeight * 0.02)
        }.sheet(isPresented: $showStartDatePicker){
            if #available(iOS 16.0, *) {
                DatePicker("", selection: $startDate, in: dateClosedRange, displayedComponents: [.date, .hourAndMinute])
                    .datePickerStyle(.wheel).labelsHidden().presentationDetents([.fraction(0.3)])
            } else {
                DatePicker("", selection: $startDate, in: dateClosedRange, displayedComponents: [.date, .hourAndMinute])
                    .datePickerStyle(.graphical).labelsHidden()
            }
        }
        .sheet(isPresented: $showEndDatePicker){
            if #available(iOS 16.0, *) {
                DatePicker("", selection: $endDate, in: dateClosedRange, displayedComponents: [.date, .hourAndMinute])
                    .datePickerStyle(.wheel).labelsHidden().presentationDetents([.fraction(0.3)])
            } else {
                DatePicker("", selection: $startDate, in: dateClosedRange, displayedComponents: [.date, .hourAndMinute])
                    .datePickerStyle(.graphical).labelsHidden()
            }
        }
    }
}

struct Date_Selection_Button: View {
    
    @Binding var datePicker: Bool
    @Binding var date: Date
    
    var body: some View {
        VStack(alignment: .leading){
            Spacer().frame(height: screenHeight * 0.02)
            Text("Tarih ve Saat")
            Spacer().frame(height: screenHeight * 0.009)
            Date_Button(showSheet: $datePicker, date: $date)
            Spacer().frame(height: screenHeight * 0.02)
        }.sheet(isPresented: $datePicker){
            if #available(iOS 16.0, *) {
                DatePicker("", selection: $date, in: dateClosedRange, displayedComponents: [.date, .hourAndMinute])
                    .datePickerStyle(.wheel).labelsHidden().presentationDetents([.fraction(0.3)])
            } else {
                DatePicker("", selection: $date, in: dateClosedRange, displayedComponents: [.date, .hourAndMinute])
                    .datePickerStyle(.graphical).labelsHidden()
            }
        }
    }    
}

struct Timer_and_Button: View {

    @Binding var timer: Int
    @State var isTimerOn: Bool = false
    let timerOffText: String
    let timerOnText: String
    
    var body: some View {
        VStack{
            Text(verbatim: timeToString(timer)).font(Font.largeTitle.monospacedDigit())
            Button(action: {isTimerOn.toggle()}){
                Rounded_Image_Text_Button(
                    iconText: "stopwatch",
                    buttonText: isTimerOn ? timerOnText : timerOffText)
            }.buttonStyle(.plain)
            Spacer().frame(height: screenHeight * 0.02)
        }.onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()){ _ in
            if isTimerOn {
                timer += 1
            }
        }
    }
}

struct Custom_TextField: View {
    
    @Binding var text: String
    @State var textStyle = UIFont.TextStyle.body
    let keyboardTpye: UIKeyboardType
    let placeholderText: String
    
    var body: some View {
        ZStack(alignment: .topLeading){
            UITextFieldViewRepresentable(text: $text, textStyle: $textStyle, keyboardType: keyboardTpye)
            if text == "" {Text(placeholderText).padding(EdgeInsets(top: 10, leading: 9, bottom: 0, trailing: 0)).foregroundColor(.gray) }
        }.frame(height: screenHeight * 0.05)
    }
}

struct Notes_and_Picture: View {
    
    @EnvironmentObject var hkViewModel: HKViewModel
    // iOS 15.0+ @FocusState private var focusKeyboard: Bool
    @Binding var selectedImageData: Data?
    @Binding var note: String
    @State var textStyle = UIFont.TextStyle.body
    @State var textHeight: CGFloat = .zero
    @State var errorText: String = ""
    @State var showError: Bool = false
    @State var showActionSheet: Bool = false
    @State var showPhotosPicker: Bool = false
    @State var showCamera: Bool = false
    @State var showGallery: Bool = false
    @State private var message = ""

    /* iOS 16
     @State var selectedPhotos: [PhotosPickerItem] = []
     */
    
    var body: some View {
        if #available(iOS 15.0, *) {
            VStack{
                VStack(alignment: .leading){
                    Rectangle().fill(.gray).frame(height: screenHeight * 0.001).cornerRadius(50)
                    Spacer().frame(height: screenHeight * 0.02)
                    Text("Notlarım")
                    Spacer().frame(height: screenHeight * 0.009)
                    ZStack(alignment: .topLeading){
                        UITextFieldViewRepresentable(text: $note, textStyle: $textStyle, keyboardType: .default)
                        if note == "" { Text("Not Ekle...").padding(EdgeInsets(top: 10, leading: 9, bottom: 0, trailing: 0)).foregroundColor(.gray) }
                    }.frame(width: screenWidth * 0.9, height: screenHeight * 0.1)
                    /* iOS 15.0+
                     TextField(text: $note) {Text("Not Ekle...").foregroundColor(.gray)}
                             .disableAutocorrection(true).textInputAutocapitalization(.never).padding()
                             .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.navBarColor, lineWidth: 4))
                             .onAppear { DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { focusKeyboard = true } }
                             .focused($focusKeyboard)
                             .toolbar { ToolbarItemGroup(placement: .keyboard) {
                                     Text("")
                                     Button(action: { focusKeyboard = false }){ Text("Bitti").foregroundColor(Color.navBarColor) } } }
                     */
                    Spacer().frame(height: screenHeight * 0.02)
                }
                if let data = selectedImageData, let uiImage = UIImage(data: data) {
                    ZStack(alignment: .topTrailing) {
                        Button(action: {showActionSheet.toggle()}){
                            Image(uiImage: uiImage).resizable().frame(maxHeight: screenHeight * 0.4).cornerRadius(20)
                        }.buttonStyle(.plain)
                        Button(action: { selectedImageData = nil }) {
                            Circle().fill(Color.navBarColor)
                                .frame(width: screenWidth * 0.1, height: screenWidth * 0.1)
                                .overlay(Image(systemName: "trash").foregroundColor(.white))
                                .shadow(radius: 2).padding(5)
                        }.buttonStyle(.plain)
                    }
                } else {
                    VStack{
                        Button(action: {showActionSheet.toggle()}){
                            Rounded_Image_Text_Button(iconText: "camera", buttonText: "Foğraf Ekle")
                        }.buttonStyle(.plain)
                    }
                }
            }
            /* iOS 16
              .onChange(of: selectedPhotos){ photos in
                  guard let item = selectedPhotos.first else {
                      errorText = "Resim Yüklenemedi"
                      showError.toggle()
                      return
                  }
                  item.loadTransferable(type: Data.self){ result in
                      switch result {
                      case .success(let data):
                          if let data = data { selectedImageData = data } else {
                              errorText = "Resim Yüklenemedi"
                              showError.toggle()
                              return
                          }
                      case .failure(_):
                          errorText = "Resim Yüklenemedi"
                          showError.toggle()
                          return
                      }
                  }
              }
              */
            .confirmationDialog("", isPresented: $showActionSheet) {
                Button("Kamera") { showCamera.toggle() }
                Button("Galeri") { showGallery.toggle() }
            }
            /* iOS 16.0+
             .alert("Hata!", isPresented: $showError, actions: {Button("Ok") {}}, message: {Text(errorText)})
             .photosPicker(isPresented: $showPhotosPicker, selection: $selectedPhotos, maxSelectionCount: 1,  matching:.images)
            */
            .sheet(isPresented: $showGallery) { ImagePicker(selectedImageData: $selectedImageData, sourceType: .savedPhotosAlbum).ignoresSafeArea() }
            .sheet(isPresented: $showCamera){ ImagePicker(selectedImageData: $selectedImageData, sourceType: .camera).ignoresSafeArea() }
        } else {
            VStack{
                VStack(alignment: .leading){
                    Rectangle().fill(.gray).frame(height: screenHeight * 0.001).cornerRadius(50)
                    Spacer().frame(height: screenHeight * 0.02)
                    Text("Notlarım")
                    Spacer().frame(height: screenHeight * 0.009)
                    ZStack(alignment: .topLeading){
                        UITextFieldViewRepresentable(text: $note, textStyle: $textStyle, keyboardType: .default)
                        if note == "" { Text("Not Ekle...").padding(EdgeInsets(top: 10, leading: 9, bottom: 0, trailing: 0)).foregroundColor(.gray) }
                    }.frame(width: screenWidth * 0.9, height: screenHeight * 0.1)
                    
                    Spacer().frame(height: screenHeight * 0.02)
                }
                if let data = selectedImageData, let uiImage = UIImage(data: data) {
                    ZStack(alignment: .topTrailing) {
                        Button(action: {showActionSheet.toggle()}){
                            Image(uiImage: uiImage).resizable().frame(maxHeight: screenHeight * 0.4).cornerRadius(20)
                        }.buttonStyle(.plain)
                        Button(action: { selectedImageData = nil }) {
                            Circle().fill(Color.navBarColor)
                                .frame(width: screenWidth * 0.1, height: screenWidth * 0.1)
                                .overlay(Image(systemName: "trash").foregroundColor(.white))
                                .shadow(radius: 2).padding(5)
                        }.buttonStyle(.plain)
                    }
                } else {
                    HStack {
                        Group {
                            Button(action: { showGallery.toggle() }) { Rounded_Image_Text_Button(iconText: "photo", buttonText: "Galeriden Ekle") }
                            Button(action: { showCamera.toggle() }) { Rounded_Image_Text_Button(iconText: "camera", buttonText: "Kameradan Ekle") }
                        }.buttonStyle(.plain)
                    }
                }
            }
            .sheet(isPresented: $showGallery) { ImagePicker(selectedImageData: $selectedImageData, sourceType: .savedPhotosAlbum).ignoresSafeArea() }
            .sheet(isPresented: $showCamera){ ImagePicker(selectedImageData: $selectedImageData, sourceType: .camera).ignoresSafeArea() }
        }
    }
}




