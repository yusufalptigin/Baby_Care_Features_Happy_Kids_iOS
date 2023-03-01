//
//  Activity Displays.swift
//  Happy Kids Feature
//
//  Created by Yusuf Alp Tigin Gün on 21.02.2023.
//

import SwiftUI

struct Diaper_Objects_Display: View {
    
    @EnvironmentObject var hkViewModel: HKViewModel
    
    var body: some View {
        Display_Helper_View {
            ForEach(hkViewModel.diaperObjects.reversed(), id: \.id) { diaperObject in
                NavigationLink(destination: Add_Activity_Object(
                    note: diaperObject.note,
                    selectedImageData: diaperObject.image_data,
                    diaperDate: diaperObject.date,
                    diapersActive: getActiveDiapers(diaperObject.type),
                    diaperObject: diaperObject,
                    activityChoice: "Bebek Bezi", isUpdate: true).environmentObject(hkViewModel)
                ) { ZStack {
                        Rectangle().fill(Color.navBarColorLight).cornerRadius(screenWidth * 0.065)
                        HStack(alignment: .top, spacing: 0){
                            Circle_Icon_Display_Image(iconText: "diaper")
                            ZStack (alignment: .leading){
                                Long_Invisible_Text()
                                VStack(alignment: .leading){
                                    Text("\(diaperObject.type), \(dateToString(diaperObject.date))").font(.system(size: screenWidth * 0.03))
                                    if diaperObject.note != "" { Text(diaperObject.note).font(.system(size: screenWidth * 0.03)) }
                                }
                            }.frame(maxWidth: .infinity, maxHeight: .infinity).padding(5)
                            Display_Image(image_data: diaperObject.image_data)
                        }
                    }.frame(width: screenWidth * 0.9, height: screenWidth * 0.13)
                }.buttonStyle(.plain)
                Spacer().frame(height: screenHeight * 0.02)
            }
        }
    }
}

struct Sleep_Objects_Display: View {
    
    @EnvironmentObject var hkViewModel: HKViewModel    
    
    var body: some View {
        Display_Helper_View {
            ForEach(hkViewModel.sleepObjects.reversed(), id: \.id) { sleepObject in
                NavigationLink(destination: Add_Activity_Object(
                    note: sleepObject.note,
                    selectedImageData: sleepObject.image_data,
                    startDate: sleepObject.start_date,
                    endDate: sleepObject.end_date,
                    timerSleep: sleepObject.timer_sleep,
                    sleepObject: sleepObject,
                    activityChoice: "Uyku", isUpdate: true).environmentObject(hkViewModel)
                ) { ZStack {
                        Rectangle().fill(Color.navBarColorLight).cornerRadius(screenWidth * 0.065)
                        HStack(alignment: .top, spacing: 0){
                            Circle_Icon_Display(iconText: "powersleep")
                            ZStack (alignment: .leading){
                                Long_Invisible_Text()
                                VStack(alignment: .leading){
                                    Text("\(sleepObject.timer_sleep / 60) dk, \(dateToString(sleepObject.start_date)) - \(dateToString(sleepObject.end_date))")
                                        .font(.system(size: screenWidth * 0.03))
                                    if sleepObject.note != "" { Text(sleepObject.note).font(.system(size: screenWidth * 0.03)) }
                                }
                            }.frame(maxWidth: .infinity, maxHeight: .infinity).padding(5)
                            Display_Image(image_data: sleepObject.image_data)
                        }
                    }.frame(width: screenWidth * 0.9, height: screenWidth * 0.13)
                }.buttonStyle(.plain)
                Spacer().frame(height: screenHeight * 0.02)
            }
        }
    }
}

struct Travel_Objects_Display: View {
    
    @EnvironmentObject var hkViewModel: HKViewModel
    
    var body: some View {
        Display_Helper_View {
            ForEach(hkViewModel.travelObjects.reversed(), id: \.id) { travelObject in
                NavigationLink(destination: Add_Activity_Object(
                    note: travelObject.note,
                    selectedImageData: travelObject.image_data,
                    startDate: travelObject.start_date,
                    endDate: travelObject.end_date,
                    travelLocation: travelObject.location,
                    travelObject: travelObject,
                    activityChoice: "Gezinti", isUpdate: true).environmentObject(hkViewModel)
                ) { ZStack {
                        Rectangle().fill(Color.navBarColorLight).cornerRadius(screenWidth * 0.065)
                        HStack(alignment: .top, spacing: 0){
                            Circle_Icon_Display(iconText: "stroller.fill")
                            ZStack (alignment: .leading){
                                Long_Invisible_Text()
                                VStack(alignment: .leading){
                                    if travelObject.location != "" { Text(travelObject.location).font(.system(size: screenWidth * 0.03)) }
                                    Text("\(dateToString(travelObject.start_date)) - \(dateToString(travelObject.end_date))")
                                        .font(.system(size: screenWidth * 0.03))
                                    if travelObject.note != "" { Text(travelObject.note).font(.system(size: screenWidth * 0.03)) }
                                }
                            }.frame(maxWidth: .infinity, maxHeight: .infinity).padding(5)
                            Display_Image(image_data: travelObject.image_data)
                        }
                    }.frame(width: screenWidth * 0.9, height: screenWidth * 0.13)
                }.buttonStyle(.plain)
                Spacer().frame(height: screenHeight * 0.02)
            }
        }
    }
}

struct Bath_Objects_Display: View {
    
    @EnvironmentObject var hkViewModel: HKViewModel
    
    var body: some View {
        Display_Helper_View {
            ForEach(hkViewModel.bathObjects.reversed(), id: \.id) { bathObject in
                NavigationLink(destination: Add_Activity_Object(
                    note: bathObject.note,
                    selectedImageData: bathObject.image_data,
                    startDate: bathObject.start_date,
                    endDate: bathObject.end_date,
                    bathObject: bathObject,
                    activityChoice: "Banyo", isUpdate: true).environmentObject(hkViewModel)
                ) { ZStack {
                        Rectangle().fill(Color.navBarColorLight).cornerRadius(screenWidth * 0.065)
                        HStack(alignment: .top, spacing: 0){
                            Circle_Icon_Display(iconText: "bathtub.fill")
                            ZStack (alignment: .leading){
                                Long_Invisible_Text()
                                VStack(alignment: .leading){
                                    Text("\(dateToString(bathObject.start_date)) - \(dateToString(bathObject.end_date))")
                                        .font(.system(size: screenWidth * 0.03))
                                    if bathObject.note != "" { Text(bathObject.note).font(.system(size: screenWidth * 0.03)) }
                                }
                            }.frame(maxWidth: .infinity, maxHeight: .infinity).padding(5)
                            Display_Image(image_data: bathObject.image_data)
                        }
                    }.frame(width: screenWidth * 0.9, height: screenWidth * 0.13)
                }.buttonStyle(.plain)
                Spacer().frame(height: screenHeight * 0.02)
            }
        }
    }
}
