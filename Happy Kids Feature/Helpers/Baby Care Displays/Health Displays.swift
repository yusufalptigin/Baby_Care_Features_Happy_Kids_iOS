//
//  Health Displays.swift
//  Happy Kids Feature
//
//  Created by Yusuf Alp Tigin Gün on 27.02.2023.
//

import SwiftUI

struct Health_Objects_Display: View {
    
    @EnvironmentObject var hkViewModel: HKViewModel
    let healthPage: String

    var body: some View {
        
        Display_Helper_View {
            ForEach(hkViewModel.healthObjects.reversed(), id: \.id) { healthObject in
                if healthObject.choice_name == healthPage {
                    NavigationLink(destination: Add_Health_Object(
                        healthDate: healthObject.date,
                        note: healthObject.note,
                        selectedImageData: healthObject.image_data,
                        healthChoice: healthObject.name,
                        healthObject: healthObject,
                        isUpdate: true,
                        choiceName: healthObject.choice_name,
                        choiceIndex: healthObject.choice_index).environmentObject(hkViewModel)
                    ) { ZStack {
                            Rectangle().fill(Color.navBarColorLight).cornerRadius(screenWidth * 0.065)
                            HStack(alignment: .top, spacing: 0){
                                Circle_Icon_Display(iconText: getIconFromHealthPage(healthPage))
                                ZStack(alignment: .leading){
                                    Long_Invisible_Text()
                                    VStack(alignment: .leading){
                                        Text("\(healthObject.name), \(dateToString(healthObject.date))").font(.system(size: screenWidth * 0.03))
                                        if healthObject.note != "" { Text(healthObject.note).font(.system(size: screenWidth * 0.03)) }
                                    }
                                }.frame(maxWidth: .infinity, maxHeight: .infinity).padding(5)
                                Display_Image(image_data: healthObject.image_data)
                            }
                        }.frame(width: screenWidth * 0.9, height: screenWidth * 0.13)
                    }.buttonStyle(.plain)
                    Spacer().frame(height: screenHeight * 0.02)
                }
            }
        }
    }
}

