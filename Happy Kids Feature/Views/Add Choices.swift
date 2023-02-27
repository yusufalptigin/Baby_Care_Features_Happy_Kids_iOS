//
//  Add Choices.swift
//  Happy Kids Feature
//
//  Created by Yusuf Alp Tigin Gün on 21.02.2023.
//

import SwiftUI

struct Add_Choices: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject var hkViewModel: HKViewModel
    let firstTitle: String = "Yemek"
    let secondTitle: String = "Aktivite"
    let thirdTitle: String = "Sağlık"
    let choices: Choices = Choices()
   
    
    var body: some View {
        VStack(alignment: .leading){
            Text(firstTitle).font(.system(size: screenWidth * 0.05)).fontWeight(.medium)
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    ForEach(0...(choices.foodChoices.count - 1), id: \.self) { index in
                        Choice_Circle_And_Name(
                            iconText: choices.foodIcons[index], choiceName: choices.foodChoices[index], choiceTitle: firstTitle, index: index)
                        Spacer().frame(width: screenWidth * 0.05)
                    }
                }
            }
            Divider()
            Text(secondTitle).font(.system(size: screenWidth * 0.05)).fontWeight(.medium)
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    ForEach(0...(choices.activityChoices.count - 1), id: \.self) { index in
                        Choice_Circle_And_Name(
                            iconText: choices.activityIcons[index], choiceName: choices.activityChoices[index], choiceTitle: secondTitle, index: index)
                        Spacer().frame(width: screenWidth * 0.05)
                    }
                }
            }
            Divider()
            Text(thirdTitle).font(.system(size: screenWidth * 0.05)).fontWeight(.medium)
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    ForEach(0...(choices.healthChoices.count - 1), id: \.self) { index in
                        Choice_Circle_And_Name(
                            iconText: choices.healthIcons[index], choiceName: choices.healthChoices[index], choiceTitle: thirdTitle, index: index)
                        Spacer().frame(width: screenWidth * 0.05)
                    }
                }
            }
            Divider()
            Spacer()
        }.padding()
            .navigationTitle("Ekle")
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            /* iOS 16.0+
             .toolbarBackground(.visible, for: .navigationBar)
             .toolbarBackground(Color.navBarColor, for: .navigationBar)
             .toolbarColorScheme(.dark, for: .navigationBar)
            */
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    Button(action: {mode.wrappedValue.dismiss()})
                    {Image(systemName: "chevron.backward").foregroundColor(.white)}
                }
            }
    }
}

struct Choice_Circle_And_Name: View {
    
    @EnvironmentObject var hkViewModel: HKViewModel
    @FocusState private var focusKeyboard: Bool
    
    @State private var showHealthMenu: Bool = false
    @State private var showAddCustom: Bool = false
    @State private var navigateWithChosen: Bool = false
    @State private var navigateWithCustom: Bool = false
    @State private var chosenText: String = ""
    @State private var customText: String = ""
    
    let health: Choices = Choices()
    let iconText: String
    let choiceName: String
    let choiceTitle: String
    let index: Int
    
    var body: some View {
        VStack{
            ZStack{
                NavigationLink(isActive: $navigateWithChosen, destination: {
                    Add_Health_Object(healthChoice: chosenText, isUpdate: false, choiceName: choiceName, choiceIndex: index).environmentObject(hkViewModel)
                }, label: { Text("").opacity(0) })
                NavigationLink(isActive: $navigateWithCustom, destination: {
                    Add_Health_Object(healthChoice: customText, isUpdate: false, choiceName: choiceName, choiceIndex: index).environmentObject(hkViewModel)
                }, label: { Text("").opacity(0) })
                if choiceTitle == "Sağlık" {
                    Button(action: {showHealthMenu.toggle()}) {
                        Choice_Circle_And_Name_View(iconText: iconText, choiceName: choiceName, choiceTitle: choiceTitle).foregroundColor(.black) }
                } else if choiceTitle == "Aktivite" {
                    NavigationLink(destination: Add_Activity_Object(activityChoice: choiceName, isUpdate: false).environmentObject(hkViewModel))
                    { Choice_Circle_And_Name_View(iconText: iconText, choiceName: choiceName, choiceTitle: choiceTitle).foregroundColor(.black) }
                    
                } else if choiceTitle == "Yemek" {
                    NavigationLink(destination: Add_Food_Object(foodChoice: choiceName, isUpdate: false).environmentObject(hkViewModel))
                    { Choice_Circle_And_Name_View(iconText: iconText, choiceName: choiceName, choiceTitle: choiceTitle).foregroundColor(.black) }
                }
            }
        }.alert("Seçiniz", isPresented: $showHealthMenu) {
            Button("Ekle", action: { showAddCustom.toggle() })
            ForEach(0...(health.healthChoiceSpecifics[index].count - 1), id: \.self) { choiceIndex in
                Button(action: {
                    chosenText = health.healthChoiceSpecifics[index][choiceIndex]
                    navigateWithChosen.toggle()
                }) { Text(health.healthChoiceSpecifics[index][choiceIndex]) }
            }
            Button("İptal", action: {}).keyboardShortcut(.defaultAction)
        }.alert("", isPresented: $showAddCustom) {
            TextField("Ekleyin...", text: $customText).disableAutocorrection(true).textInputAutocapitalization(.never)
                .ignoresSafeArea(.keyboard, edges: .bottom)
                .keyboardType(index == 2 ? .decimalPad : .default)
                .onAppear { DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { focusKeyboard = true } }.focused($focusKeyboard)
                .toolbar { ToolbarItemGroup(placement: .keyboard) {
                        Text("")
                        Button(action: { focusKeyboard = false }){ Text("Bitti").foregroundColor(Color.navBarColor) } } }
            Button("İptal", action: {}).keyboardShortcut(.defaultAction)
            Button(action: { navigateWithCustom.toggle() }){ Text("Ekle") }
        }
    }
}


/* iOS 16.0+
struct Choice_Circle_And_Name: View {
     
     @EnvironmentObject var hkViewModel: HKViewModel
     @FocusState private var focusKeyboard: Bool
     
     @State private var showHealthMenu: Bool = false
     @State private var showAddCustom: Bool = false
     @State private var healthChoiceText = ""
     
     let health: Choices = Choices()
     let iconText: String
     let choiceName: String
     let choiceTitle: String
     let index: Int
     
     var body: some View {
         VStack{
             if choiceTitle == "Sağlık" {
                 Button(action: {showHealthMenu.toggle()}) {
                     Choice_Circle_And_Name_View(iconText: iconText, choiceName: choiceName, choiceTitle: choiceTitle).foregroundColor(.black) }
             } else if choiceTitle == "Aktivite" {
                 NavigationLink(destination: Add_Activity_Object(activityChoice: choiceName, isUpdate: false).environmentObject(hkViewModel))
                 { Choice_Circle_And_Name_View(iconText: iconText, choiceName: choiceName, choiceTitle: choiceTitle).foregroundColor(.black) }
                 
             } else if choiceTitle == "Yemek" {
                 NavigationLink(destination: Add_Food_Object(foodChoice: choiceName, isUpdate: false).environmentObject(hkViewModel))
                 { Choice_Circle_And_Name_View(iconText: iconText, choiceName: choiceName, choiceTitle: choiceTitle).foregroundColor(.black) }
             }
         }.alert("Seçiniz", isPresented: $showHealthMenu) {
             Button("Ekle", action: { showAddCustom.toggle() })
             ForEach(0...(health.healthChoiceSpecifics[index].count - 1), id: \.self) { choiceIndex in
                 NavigationLink(health.healthChoiceSpecifics[index][choiceIndex],
                                destination: Add_Health_Object(
                                 healthChoice: health.healthChoiceSpecifics[index][choiceIndex],
                                 isUpdate: false,
                                 choiceName: choiceName,
                                 choiceIndex: index).environmentObject(hkViewModel))
             }
             Button("İptal", action: {}).keyboardShortcut(.defaultAction)
         }.alert("", isPresented: $showAddCustom) {
             TextField("Ekleyin...", text: $healthChoiceText).disableAutocorrection(true).textInputAutocapitalization(.never)
                 .ignoresSafeArea(.keyboard, edges: .bottom)
                 .keyboardType(index == 2 ? .decimalPad : .default)
                 .onAppear { DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { focusKeyboard = true } }.focused($focusKeyboard)
                 .toolbar { ToolbarItemGroup(placement: .keyboard) {
                         Text("")
                         Button(action: { focusKeyboard = false }){ Text("Bitti").foregroundColor(Color.navBarColor) } } }
             Button("İptal", action: {}).keyboardShortcut(.defaultAction)
             NavigationLink("Ekle", destination: Add_Health_Object(
                 healthChoice: healthChoiceText,
                 isUpdate: false,
                 choiceName: choiceName,
                 choiceIndex: index).environmentObject(hkViewModel))
         }
     }
 }
 */
