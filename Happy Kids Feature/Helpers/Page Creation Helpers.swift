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
        }.frame(width: screenWidth * 0.16, height: screenHeight * 0.14)
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

struct Dropdown_Button: View {
    
    @Binding var text: String
    
    var body: some View {
        Rectangle()
            .strokeBorder(Color.navBarColor, lineWidth: 4)
            .background(Rectangle().fill(Color.navBarColorLight))
            .cornerRadius(5)
            .overlay(HStack{
                Spacer().frame(width: screenWidth * 0.04)
                Text(text).foregroundColor(Color.black)
                Spacer()
                Image(systemName: "chevron.down").foregroundColor(.black)
                Spacer().frame(width: screenWidth * 0.04)
            })
            .frame(width: screenWidth * 0.9, height: screenHeight * 0.07)
    }
}

struct Custom_Dropdown_Button: View {
    
    @FocusState private var focusKeyboard: Bool
    @State var showLocation: Bool = false
    @State var choiceText: String = ""
    @Binding var bindingText: String
    let isDecimalPadKeyboard: Bool
    
    var body: some View {
        VStack {
            Button(action: { showLocation.toggle() }){ Dropdown_Button(text: $bindingText) }
        }.alert("", isPresented: $showLocation) {
            TextField("Ekleyin...", text: $choiceText).disableAutocorrection(true).textInputAutocapitalization(.never).padding()
                .onAppear { DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { focusKeyboard = true } }.focused($focusKeyboard)
                .keyboardType(isDecimalPadKeyboard ? .decimalPad : .default)
                .toolbar { ToolbarItemGroup(placement: .keyboard) {
                        Text("")
                        Button(action: { focusKeyboard = false }){ Text("Bitti").foregroundColor(Color.navBarColor) } } }
            Button("İptal", action: {}).keyboardShortcut(.defaultAction)
            Button("Ekle", action: { bindingText = choiceText } )
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
            DatePicker("", selection: $startDate, in: dateClosedRange, displayedComponents: [.date, .hourAndMinute])
                .datePickerStyle(.wheel).labelsHidden().frame(height: screenHeight * 0.3)
        }
        .sheet(isPresented: $showEndDatePicker){
            DatePicker("", selection: $endDate, in: dateClosedRange, displayedComponents: [.date, .hourAndMinute])
                .datePickerStyle(.wheel).labelsHidden().frame(height: screenHeight * 0.3)
                /*
                 .presentationDetents([.fraction(0.3)])
                 */
                
        }.onAppear{
            //UIPopoverPresentationController().preferredContentSize = CGSize(width: 100, height: 100)
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
            DatePicker("", selection: $date, in: dateClosedRange, displayedComponents: [.date, .hourAndMinute])
                .datePickerStyle(.wheel).labelsHidden().frame(height: screenHeight * 0.3)
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

struct Custom_Textfield: View {
    
    @FocusState private var focusKeyboard: Bool
    @Binding var text: String
    
    var body: some View {
        ZStack{
            TextEditor(text: $text).toolbar { ToolbarItemGroup(placement: .keyboard) {
                Text("")
                Button(action: { focusKeyboard = false }){ Text("Bitti").foregroundColor(Color.navBarColor) } } }
            if text == "" { Text("Not Ekle...").foregroundColor(.gray) }
        }
        /*
         TextField(text: $text, axis: .vertical) {Text("Not Ekle...").foregroundColor(.gray)}
                 .disableAutocorrection(true).textInputAutocapitalization(.never).padding()
                 .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.navBarColor, lineWidth: 4))
                 .onAppear { DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { focusKeyboard = true } }
                 .focused($focusKeyboard)
                 .toolbar { ToolbarItemGroup(placement: .keyboard) {
                         Text("")
                         Button(action: { focusKeyboard = false }){ Text("Bitti").foregroundColor(Color.navBarColor) } } }*/
    }
}

struct Notes_and_Picture: View {
    
    @EnvironmentObject var hkViewModel: HKViewModel
    @FocusState private var focusKeyboard: Bool
    @Binding var selectedImageData: Data?
    @Binding var note: String
    @State var errorText: String = ""
    @State var showError: Bool = false
    @State var showActionSheet: Bool = false
    @State var showPhotosPicker: Bool = false
    @State var showCamera: Bool = false
    @State var showGallery: Bool = false
    /* iOS 16
     @State var selectedPhotos: [PhotosPickerItem] = []
     */
    
    var body: some View {
        VStack{
            VStack(alignment: .leading){
                Divider().frame(height: screenHeight * 0.001).overlay(.gray)
                Spacer().frame(height: screenHeight * 0.02)
                Text("Notlarım")
                Spacer().frame(height: screenHeight * 0.009)
                UITextFieldViewRepresentable(text: $note, placeholderText: "Not Ekle...").frame(width: screenWidth * 0.9)
                TextField(text: $note) {Text("Not Ekle...").foregroundColor(.gray)}
                        .disableAutocorrection(true).textInputAutocapitalization(.never).padding()
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.navBarColor, lineWidth: 4))
                        .onAppear { DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { focusKeyboard = true } }
                        .focused($focusKeyboard)
                        .toolbar { ToolbarItemGroup(placement: .keyboard) {
                                Text("")
                                Button(action: { focusKeyboard = false }){ Text("Bitti").foregroundColor(Color.navBarColor) } } }
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
        .alert("Hata!", isPresented: $showError, actions: {Button("Ok") {}}, message: {Text(errorText)})
        .sheet(isPresented: $showGallery) { ImagePicker(selectedImageData: $selectedImageData, sourceType: .savedPhotosAlbum).ignoresSafeArea() }
        .sheet(isPresented: $showCamera){ ImagePicker(selectedImageData: $selectedImageData, sourceType: .camera).ignoresSafeArea() }
        /* iOS 16 Gallery Photo Picker
         .photosPicker(isPresented: $showPhotosPicker, selection: $selectedPhotos, maxSelectionCount: 1,  matching:.images)
        */
    }
}

