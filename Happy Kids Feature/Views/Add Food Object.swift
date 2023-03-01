//
//  Add Food Object.swift
//  Happy Kids Feature
//
//  Created by Yusuf Alp Tigin Gün on 22.02.2023.
//

import SwiftUI

struct Add_Food_Object: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject var hkViewModel: HKViewModel
    
    @State private var showStartDatePicker: Bool = false
    @State private var showEndDatePicker: Bool = false
    @State private var showRegularDatePicker: Bool = false
    @State var note: String = ""
    @State var selectedImageData: Data? = nil
    @State var regularDate: Date = Date()
    @State var startDate: Date = Date()
    @State var endDate: Date = Date()
    @State var option: String = "Manuel"
    @State var babyFood: String = ""
    @State var nursingOption: String = "Sol"
    @State var babyBottleOption: String = "Sağılan Süt"
    @State var babyBottleAmount: String = "0"
    @State var timerLeft: Int = 0
    @State var timerRight: Int = 0
    @State var timerSleep: Int = 0
    let options: [String] = ["Manuel", "Zamanlayıcı"]
    let nursingOptions: [String] = ["Sol", "Sağ", "İkisi de"]
    let babyBottleOptions: [String] = ["Sağılan Süt", "Karışım"]
    let foodChoice: String
    var isUpdate: Bool
    var nursingObject: NursingObjectModel?
    var bottleObject: BottleObjectModel?
    var foodObject: FoodObjectModel?
    var milkingObject: MilkingObjectModel?
    
    func deleteNursingObject(_ nursingObject: NursingObjectModel) {
        hkViewModel.deleteNursingObject(nursingObject)
        hkViewModel.getAllNursingObjects()
    }
    
    func deleteBottleObject(_ bottleObject: BottleObjectModel) {
        hkViewModel.deleteBottleObject(bottleObject)
        hkViewModel.getAllBottleObjects()
    }
    
    func deleteFoodObject(_ foodObject: FoodObjectModel) {
        hkViewModel.deleteFoodObject(foodObject)
        hkViewModel.getAllFoodObjects()
    }
    
    func deleteMilkingObject(_ milkingObject: MilkingObjectModel) {
        hkViewModel.deleteMilkingObject(milkingObject)
        hkViewModel.getAllMilkingObjects()
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0) {
                if foodChoice == "Emzirme" {
                    Picker("", selection: $option) {
                        ForEach(options, id: \.self) { option in
                            Text(option)
                        }
                    }.padding(.all, 10.0).pickerStyle(.segmented)
                    if option == "Manuel" {
                        Start_and_End_Dates(
                            showStartDatePicker: $showStartDatePicker, showEndDatePicker: $showEndDatePicker,
                            startDate: $startDate, endDate: $endDate
                        )
                        Text("Meme")
                        Spacer().frame(height: screenHeight * 0.009)
                        Picker("", selection: $nursingOption) {
                            ForEach(nursingOptions, id: \.self) { nursingOption in
                                Text(nursingOption)
                            }
                        }.pickerStyle(.segmented)
                        Spacer().frame(height: screenHeight * 0.02)
                    }
                    else {
                        HStack(spacing: 0){
                            VStack{Timer_and_Button(timer: $timerLeft, timerOffText: "Sol", timerOnText: "Duraklat")}.frame(width: screenWidth*0.45)
                            VStack{Timer_and_Button(timer: $timerRight, timerOffText: "Sağ", timerOnText: "Duraklat")}.frame(width: screenWidth*0.45)
                        }
                    }
                } else {
                    Spacer().frame(height: screenHeight * 0.02)
                    if foodChoice != "Mama" {
                        Text("Miktal (mL)")
                        Spacer().frame(height: screenHeight * 0.009)
                        Custom_TextField(text: $babyBottleAmount, keyboardTpye: .decimalPad, placeholderText: "Ekleyin...")
                        if foodChoice == "Biberon" {
                            Spacer().frame(height: screenHeight * 0.02)
                            Picker("", selection: $babyBottleOption) {
                                ForEach(babyBottleOptions, id: \.self) { babyBottleOption in
                                    Text(babyBottleOption)
                                }
                            }.padding(.all, 10.0).pickerStyle(.segmented)
                        }
                        
                    } else if foodChoice == "Mama" {
                        Text("Tüketilen Gıda")
                        Spacer().frame(height: screenHeight * 0.009)
                        Custom_TextField(text: $babyFood, keyboardTpye: .default, placeholderText: "Ekleyin...")
                    }
                    Date_Selection_Button(datePicker: $showRegularDatePicker, date: $regularDate)
                    if foodChoice == "Süt Sağma" {
                        Text("Meme")
                        Spacer().frame(height: screenHeight * 0.009)
                        Picker("", selection: $nursingOption) {
                            ForEach(nursingOptions, id: \.self) { nursingOption in
                                Text(nursingOption)
                            }
                        }.pickerStyle(.segmented)
                        Spacer().frame(height: screenHeight * 0.02)
                    }
                }
                Notes_and_Picture(selectedImageData: $selectedImageData, note: $note)
                Spacer()
            }.frame(width: screenWidth * 0.9)
                .navigationTitle(foodChoice)
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
                                if isUpdate {
                                    Button(action: {
                                        if foodChoice == "Emzirme" { deleteNursingObject(nursingObject!) }
                                        else if foodChoice == "Biberon" { deleteBottleObject(bottleObject!) }
                                        else if foodChoice == "Mama" { deleteFoodObject(foodObject!) }
                                        else if foodChoice == "Süt Sağma" { deleteMilkingObject(milkingObject!) }
                                        mode.wrappedValue.dismiss()
                                    }) { Image(systemName: "trash").foregroundColor(.white) }
                                }                                
                                Button(action: {
                                    if foodChoice == "Emzirme" {
                                        if isUpdate {
                                            hkViewModel.updateNursingObject(
                                                start_date: startDate, end_date: endDate,
                                                right_timer: timerRight, left_timer: timerLeft, nursing_option: nursingOption,
                                                note: note, image_data: selectedImageData,
                                                nursingObject: nursingObject!
                                            )
                                        } else {
                                            hkViewModel.saveNursingObject(
                                                start_date: startDate, end_date: endDate,
                                                right_timer: timerRight, left_timer: timerLeft, nursing_option: nursingOption,
                                                note: note, image_data: selectedImageData
                                            )
                                        }
                                        hkViewModel.getAllNursingObjects()
                                    } else if foodChoice == "Biberon" {
                                        if isUpdate {
                                            hkViewModel.updateBottleObject(
                                                amount: babyBottleAmount, choice: babyBottleOption, date: regularDate,
                                                note: note, image_data: selectedImageData, bottleObject: bottleObject!
                                            )
                                        } else {
                                            hkViewModel.saveBottleObject(
                                                amount: babyBottleAmount, choice: babyBottleOption, date: regularDate,
                                                note: note, image_data: selectedImageData
                                            )
                                        }
                                        hkViewModel.getAllBottleObjects()
                                    } else if foodChoice == "Mama" {
                                        if isUpdate {
                                            hkViewModel.updateFoodObject(
                                                food: babyFood, date: regularDate,
                                                note: note, image_data: selectedImageData, foodObject: foodObject!
                                            )
                                        } else {
                                            hkViewModel.saveFoodObject(
                                                food: babyFood, date: regularDate,
                                                note: note, image_data: selectedImageData
                                            )
                                        }
                                        hkViewModel.getAllFoodObjects()
                                    } else if foodChoice == "Süt Sağma" {
                                        if isUpdate {
                                            hkViewModel.updateMilkingObjects(
                                                amount: babyBottleAmount, breast: nursingOption, date: regularDate,
                                                note: note, image_data: selectedImageData, milkingObject: milkingObject!
                                            )
                                        } else {
                                            hkViewModel.saveMilkingObject(
                                                amount: babyBottleAmount, breast: nursingOption, date: regularDate,
                                                note: note, image_data: selectedImageData
                                            )
                                        }
                                        hkViewModel.getAllMilkingObjects()
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
}
