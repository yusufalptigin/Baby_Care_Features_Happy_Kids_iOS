//
//  Health.swift
//  Happy Kids Feature
//
//  Created by Yusuf Alp Tigin Gün on 21.02.2023.
//

import SwiftUI

struct Add_Health_Object: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject var hkViewModel: HKViewModel
    
    @State private var showHealthDatePicker: Bool = false
    @State var healthDate: Date = Date()
    @State var note: String = ""
    @State var selectedImageData: Data? = nil
    @State var healthChoice: String = ""
    var healthObject: HealthObjectModel?
    var isUpdate: Bool
    let choices: Choices = Choices()
    let choiceName: String
    let choiceIndex: Int
    
    func deleteHealthObject(_ healthObject: HealthObjectModel) {
        hkViewModel.deleteHealthObject(healthObject)
        hkViewModel.getAllHealthObjects()
    }
    
    var body: some View {
        ScrollView(showsIndicators: false){
            VStack(alignment: .leading){
                Spacer().frame(height: screenHeight * 0.02)
                Custom_TextField(text: $healthChoice, keyboardTpye: choiceIndex == 2 ? .decimalPad : .default, placeholderText: "Ekleyin..")
                Date_Selection_Button(datePicker: $showHealthDatePicker, date: $healthDate)
                Notes_and_Picture(selectedImageData: $selectedImageData, note: $note)
                Spacer()
            }
        }.frame(width: screenWidth * 0.9)
            .navigationTitle(choices.healthChoices[choiceIndex])
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            /* iOS 16.0+
             .toolbarBackground(.visible, for: .navigationBar)
             .toolbarBackground(Color.navBarColor, for: .navigationBar)
             .toolbarColorScheme(.dark, for: .navigationBar)
            */
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        if isUpdate { Button(action: { deleteHealthObject(healthObject!) }) { Image(systemName: "trash").foregroundColor(.white) } }
                        Button(action: {
                            if isUpdate {
                                hkViewModel.updateHealthObject(
                                    date: healthDate, choice_index: choiceIndex, choice_name: choiceName, name: healthChoice,
                                    note: note, image_data: selectedImageData,
                                    healthObject: healthObject!
                                )
                            } else {
                                hkViewModel.saveHealthObject(
                                    date: healthDate, choice_index: choiceIndex, choice_name: choiceName, name: healthChoice,
                                    note: note, image_data: selectedImageData
                                )
                            }
                            hkViewModel.getAllHealthObjects()
                            mode.wrappedValue.dismiss()
                        }) { Image("save_icon") } } }
                ToolbarItem(placement: .navigationBarLeading){
                    Button(action: { mode.wrappedValue.dismiss() }) { Image(systemName: "chevron.backward").foregroundColor(.white) }
                }
            }
    }
}
