//
//  Add Activity Object.swift
//  Happy Kids Feature
//
//  Created by Yusuf Alp Tigin Gün on 21.02.2023.
//

import SwiftUI

struct Add_Activity_Object: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject var hkViewModel: HKViewModel
    
    @State private var showStartDatePicker: Bool = false
    @State private var showEndDatePicker: Bool = false
    @State private var showDiaperDatePicker: Bool = false
    @State var note: String = ""
    @State var selectedImageData: Data? = nil
    @State var diaperDate: Date = Date()
    @State var startDate: Date = Date()
    @State var endDate: Date = Date()
    @State var travelLocation: String = ""
    @State var option: String = "Manuel"
    @State var timerSleep: Int = 0
    let options: [String] = ["Manuel", "Zamanlayıcı"]
    @State var diapersActive: [Bool] = [true, false, false, false]
    @State var diapersText: [String] = ["Islak", "Kirli", "Karışık", "Temiz"]
    var diaperObject: DiaperObjectModel?
    var sleepObject: SleepObjectModel?
    var travelObject: TravelObjectModel?
    var bathObject: BathObjectModel?
    let activityChoice: String
    var isUpdate: Bool
    
    func deleteDiaperObject(_ diaperObject: DiaperObjectModel) {
        hkViewModel.deleteDiaperObject(diaperObject)
        hkViewModel.getAllDiaperObjects()
    }
    
    func deleteSleepObject(_ sleepObject: SleepObjectModel) {
        hkViewModel.deleteSleepObject(sleepObject)
        hkViewModel.getAllSleepObjects()
    }
    
    func deleteTravelObject(_ travelObject: TravelObjectModel) {
        hkViewModel.deleteTravelObject(travelObject)
        hkViewModel.getAllTravelObjects()
    }
    
    func deleteBathObject(_ bathObject: BathObjectModel) {
        hkViewModel.deleteBathObject(bathObject)
        hkViewModel.getAllBathObjects()
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack{
                if activityChoice != "Bebek Bezi" {
                    if activityChoice == "Uyku" {
                        Picker("", selection: $option) {
                            ForEach(options, id: \.self) { option in
                                Text(option)
                            }
                        }.padding(.all, 10.0).pickerStyle(.segmented)
                    } else { Spacer().frame(height: screenHeight * 0.02) }
                    VStack(alignment: .leading, spacing: 0){
                        if activityChoice == "Uyku" {
                            if option == "Manuel" {
                                Start_and_End_Dates(
                                    showStartDatePicker: $showStartDatePicker, showEndDatePicker: $showEndDatePicker,
                                    startDate: $startDate, endDate: $endDate
                                )
                            } else { Timer_and_Button(timer: $timerSleep, timerOffText: "Uykuya Daldı", timerOnText: "Uyandı") }
                        } else {
                            if activityChoice == "Gezinti" {
                                Text("Konum")
                                Spacer().frame(height: screenHeight * 0.009)
                                Custom_Dropdown_Button(bindingText: $travelLocation, isDecimalPadKeyboard: false)
                                Spacer().frame(height: screenHeight * 0.02)
                            }
                            Start_and_End_Dates(
                                showStartDatePicker: $showStartDatePicker, showEndDatePicker: $showEndDatePicker,
                                startDate: $startDate, endDate: $endDate
                            )
                        }
                    }.frame(width: screenWidth * 0.9)
                } else if activityChoice == "Bebek Bezi" {
                    ForEach(0...1, id: \.self) { rowCount in
                        Spacer().frame(height: screenHeight * 0.02)
                        HStack{
                            ForEach(0...1, id: \.self) { columnCount in
                                Group{
                                    if diapersActive[rowCount * 2 + columnCount] { RoundedRectangle(cornerRadius: 20).fill(Color.navBarColor) }
                                    else { RoundedRectangle(cornerRadius: 20).fill(Color.navBarColorLight) }
                                }.frame(height: screenHeight * 0.05)
                                .overlay( HStack{Text(diapersText[rowCount * 2 + columnCount])}
                                    .foregroundColor(diapersActive[rowCount * 2 + columnCount] ? Color.white : Color.navBarColor))
                                .onTapGesture {
                                    diapersActive[rowCount * 2 + columnCount].toggle()
                                    for i in 0...diapersActive.count - 1 { if i != rowCount * 2 + columnCount { diapersActive[i] = false } }
                                }
                            }
                        }.frame(maxWidth: .infinity)
                    }
                    Date_Selection_Button(datePicker: $showDiaperDatePicker, date: $diaperDate)
                }
                Notes_and_Picture(selectedImageData: $selectedImageData, note: $note)
                Spacer()
            }
        }.frame(width: screenWidth * 0.9)
            .navigationTitle(activityChoice)
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
                            Button(action: {
                                if isUpdate {
                                    if activityChoice == "Bebek Bezi" { deleteDiaperObject(diaperObject!) }
                                    else if activityChoice == "Uyku" { deleteSleepObject(sleepObject!) }
                                    else if activityChoice == "Gezinti" { deleteTravelObject(travelObject!) }
                                    else if activityChoice == "Banyo" { deleteBathObject(bathObject!) }
                                }
                            }) { Image(systemName: "trash").foregroundColor(.white) }
                            Button(action: {
                                if activityChoice == "Bebek Bezi" {
                                    if isUpdate {
                                        hkViewModel.updateDiaperObject(
                                            date: diaperDate, type: getActiveDiaperText(diapersText: diapersText, diapersActive: diapersActive),
                                            note: note, image_data: selectedImageData, diaperObject: diaperObject!
                                        )
                                    } else {
                                        hkViewModel.saveDiaperObject(
                                            date: diaperDate, type: getActiveDiaperText(diapersText: diapersText, diapersActive: diapersActive),
                                            note: note, image_data: selectedImageData
                                        )
                                    }
                                    hkViewModel.getAllDiaperObjects()
                                } else if activityChoice == "Uyku" {
                                    if isUpdate {
                                        hkViewModel.updateSleepObject(
                                            start_date: startDate, end_date: endDate,
                                            timer_sleep: timerSleep,
                                            note: note, image_data: selectedImageData, sleepObject: sleepObject!
                                        )
                                    } else {
                                        hkViewModel.saveSleepObject(
                                            start_date: startDate, end_date: endDate,
                                            timer_sleep: timerSleep, note: note, image_data: selectedImageData
                                        )
                                    }
                                    hkViewModel.getAllSleepObjects()
                                } else if activityChoice == "Gezinti" {
                                    if isUpdate {
                                        hkViewModel.updateTravelObject(
                                            location: travelLocation, start_date: startDate, end_date: endDate,
                                            note: note, image_data: selectedImageData, travelObject: travelObject!
                                        )
                                    } else {
                                        hkViewModel.saveTravelObject(
                                            location: travelLocation, start_date: startDate, end_date: endDate,
                                            note: note, image_data: selectedImageData
                                        )
                                    }
                                    hkViewModel.getAllTravelObjects()
                                } else if activityChoice == "Banyo" {
                                    if isUpdate {
                                        hkViewModel.updateBathObject(
                                            start_date: startDate, end_date: endDate,
                                            note: note, image_data: selectedImageData, bathObject: bathObject!)
                                    } else {
                                        hkViewModel.saveBathObject(
                                            start_date: startDate, end_date: endDate,
                                            note: note, image_data: selectedImageData
                                        )
                                    }
                                    hkViewModel.getAllBathObjects()
                                }
                                mode.wrappedValue.dismiss()
                            }) { Image("save_icon") }
                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading){
                        Button(action: { mode.wrappedValue.dismiss() }) { Image(systemName: "chevron.backward").foregroundColor(.white) }
                    }
                }
    }
}


