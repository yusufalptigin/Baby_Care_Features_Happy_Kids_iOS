//
//  Food Displays.swift
//  Happy Kids Feature
//
//  Created by Yusuf Alp Tigin Gün on 21.02.2023.
//

import SwiftUI

struct Nursing_Objects_Display: View {
    
    @EnvironmentObject var hkViewModel: HKViewModel
    
    var body: some View {
        Display_Helper_View {
            ForEach(hkViewModel.nursingObjects.reversed(), id: \.id) { nursingObject in
                NavigationLink(destination: Add_Food_Object(
                    note: nursingObject.note,
                    selectedImageData: nursingObject.image_data,
                    startDate: nursingObject.start_date,
                    endDate: nursingObject.end_date,
                    nursingOption: nursingObject.nursing_option,
                    timerLeft: nursingObject.left_timer,
                    timerRight: nursingObject.right_timer,
                    foodChoice: "Emzirme",
                    isUpdate: true,
                    nursingObject: nursingObject).environmentObject(hkViewModel)
                ) { ZStack {
                        Rectangle().fill(Color.navBarColorLight).cornerRadius(screenWidth * 0.065)
                        HStack(alignment: .top, spacing: 0){
                            Circle_Icon_Display_Image(iconText: "breast_feeding")
                            ZStack (alignment: .leading){
                                Long_Invisible_Text()
                                VStack(alignment: .leading){
                                    Text("\(dateToString(nursingObject.start_date)) - \(dateToString(nursingObject.end_date))")
                                        .font(.system(size: screenWidth * 0.03))
                                    Text("\(nursingObject.nursing_option); Sol: \(nursingObject.left_timer / 60) dk, Sağ: \(nursingObject.right_timer / 60) dk")
                                        .font(.system(size: screenWidth * 0.03))
                                    if nursingObject.note != "" { Text(nursingObject.note).font(.system(size: screenWidth * 0.03)) }
                                }
                            }.frame(maxWidth: .infinity, maxHeight: .infinity).padding(5)
                            Display_Image(image_data: nursingObject.image_data)
                        }
                    }.frame(width: screenWidth * 0.9, height: screenWidth * 0.13)
                }.buttonStyle(.plain)
                Spacer().frame(height: screenHeight * 0.02)
            }
        }
    }
}

struct Bottle_Objects_Display: View {
    
    @EnvironmentObject var hkViewModel: HKViewModel
    
    var body: some View {
        Display_Helper_View {
            ForEach(hkViewModel.bottleObjects.reversed(), id: \.id) { bottleObject in
                NavigationLink(destination: Add_Food_Object(
                    note: bottleObject.note,
                    selectedImageData: bottleObject.image_data,
                    regularDate: bottleObject.date,
                    babyBottleOption: bottleObject.choice,
                    babyBottleAmount: bottleObject.amount,
                    foodChoice: "Biberon",
                    isUpdate: true,
                    bottleObject: bottleObject).environmentObject(hkViewModel)
                ) { ZStack {
                        Rectangle().fill(Color.navBarColorLight).cornerRadius(screenWidth * 0.065)
                        HStack(alignment: .top, spacing: 0){
                            Circle_Icon_Display_Image(iconText: "baby_bottle")
                            ZStack (alignment: .leading){
                                Long_Invisible_Text()
                                VStack(alignment: .leading){
                                    Text("\(dateToString(bottleObject.date)), \(bottleObject.choice), \(bottleObject.amount) mL")
                                        .font(.system(size: screenWidth * 0.03))
                                    if bottleObject.note != "" { Text(bottleObject.note).font(.system(size: screenWidth * 0.03)) }
                                }
                            }.frame(maxWidth: .infinity, maxHeight: .infinity).padding(5)
                            Display_Image(image_data: bottleObject.image_data)
                        }
                    }.frame(width: screenWidth * 0.9, height: screenWidth * 0.13)
                }.buttonStyle(.plain)
                Spacer().frame(height: screenHeight * 0.02)
            }
        }
    }
}

struct Food_Objects_Display: View {
    
    @EnvironmentObject var hkViewModel: HKViewModel
    
    var body: some View {
        Display_Helper_View {
            ForEach(hkViewModel.foodObjects.reversed(), id: \.id) { foodObject in
                NavigationLink(destination: Add_Food_Object(
                    note: foodObject.note,
                    selectedImageData: foodObject.image_data,
                    regularDate: foodObject.date,
                    babyFood: foodObject.food,
                    foodChoice: "Mama",
                    isUpdate: true,
                    foodObject: foodObject).environmentObject(hkViewModel)
                ) { ZStack {
                        Rectangle().fill(Color.navBarColorLight).cornerRadius(screenWidth * 0.065)
                        HStack(alignment: .top, spacing: 0){
                            Circle_Icon_Display_Image(iconText: "food")
                            ZStack (alignment: .leading){
                                Long_Invisible_Text()
                                VStack(alignment: .leading){
                                    Text("\(dateToString(foodObject.date)), \(foodObject.food)").font(.system(size: screenWidth * 0.03))
                                    if foodObject.note != "" { Text(foodObject.note).font(.system(size: screenWidth * 0.03)) }
                                }
                            }.frame(maxWidth: .infinity, maxHeight: .infinity).padding(5)
                            Display_Image(image_data: foodObject.image_data)
                        }
                    }.frame(width: screenWidth * 0.9, height: screenWidth * 0.13)
                }.buttonStyle(.plain)
                Spacer().frame(height: screenHeight * 0.02)
            }
        }
    }
}

struct Milking_Objects_Display: View {
    
    @EnvironmentObject var hkViewModel: HKViewModel
    
    var body: some View {
        Display_Helper_View {
            ForEach(hkViewModel.milkingObjects.reversed(), id: \.id) { milkingObject in
                NavigationLink(destination: Add_Food_Object(
                    note: milkingObject.note,
                    selectedImageData: milkingObject.image_data,
                    regularDate: milkingObject.date,
                    nursingOption: milkingObject.breast,
                    babyBottleAmount: milkingObject.amount,
                    foodChoice: "Süt Sağma",
                    isUpdate: true,
                    milkingObject: milkingObject).environmentObject(hkViewModel)
                ) { ZStack {
                        Rectangle().fill(Color.navBarColorLight).cornerRadius(screenWidth * 0.065)
                        HStack(alignment: .top, spacing: 0){
                            Circle_Icon_Display_Image(iconText: "milking")
                            ZStack (alignment: .leading){
                                Long_Invisible_Text()
                                VStack(alignment: .leading){
                                    Text("\(dateToString(milkingObject.date)), \(milkingObject.breast), \(milkingObject.amount) mL")
                                        .font(.system(size: screenWidth * 0.03))
                                    if milkingObject.note != "" { Text(milkingObject.note).font(.system(size: screenWidth * 0.03)) }
                                }
                            }.frame(maxWidth: .infinity, maxHeight: .infinity).padding(5)
                            Display_Image(image_data: milkingObject.image_data)
                        }
                    }.frame(width: screenWidth * 0.9, height: screenWidth * 0.13)
                }.buttonStyle(.plain)
                Spacer().frame(height: screenHeight * 0.02)
            }
        }
    }
}
