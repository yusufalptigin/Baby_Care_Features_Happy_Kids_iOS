//
//  PDF Displays.swift
//  Happy Kids Feature
//
//  Created by Yusuf Alp Tigin Gün on 20.02.2023.
//

import SwiftUI

struct PDF_Displays: View {
    
    @EnvironmentObject var hkViewModel: HKViewModel
    let pageName: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer().frame(height: screenHeight * 0.01)
            HStack{
                Spacer().frame(width: screenWidth * 0.02)
                Text(pageName).font(.system(size: screenWidth * 0.05))
            }
            if pageName == "Emzirme" && !hkViewModel.nursingObjects.isEmpty { Nursing_PDF_Display() }
            else if pageName == "Biberon" && !hkViewModel.bottleObjects.isEmpty { Bottle_PDF_Display() }
            else if pageName == "Mama" && !hkViewModel.foodObjects.isEmpty { Food_PDF_Display() }
            else if pageName == "Süt Sağma" && !hkViewModel.milkingObjects.isEmpty { Milking_PDF_Display() }
            else if pageName == "Bebek Bezi" && !hkViewModel.diaperObjects.isEmpty { Diaper_PDF_Display() }
            else if pageName == "Uyku" && !hkViewModel.sleepObjects.isEmpty { Sleep_PDF_Display() }
            else if pageName == "Gezinti" && !hkViewModel.travelObjects.isEmpty { Travel_PDF_Display() }
            else if pageName == "Banyo" && !hkViewModel.bathObjects.isEmpty { Bath_PDF_Display() }
            else { Health_PDF_Display(pageChoice: pageName) }
            Spacer()
        }.frame(maxHeight: .infinity)
    }
}

struct Nursing_PDF_Display: View {
    
    @EnvironmentObject var hkViewModel: HKViewModel
    
    var body: some View {
        PDF_Display_Titles(firstTitle: "Başlangıç, Bitiş, Emzirme Tercihi, Sol Süre, Sağ Süre")
        ForEach(hkViewModel.nursingObjects.reversed(), id: \.self.id) { nursingObject in
            HStack(alignment: .top, spacing: 0) {
                Spacer().frame(width: screenWidth * 0.02)
                ZStack(alignment: .leading) {
                    Text("").opacity(0).frame(width: screenWidth * 0.3)
                    VStack(alignment: .leading) {
                        Text("\(dateToString(nursingObject.start_date))")
                        Text("\(dateToString(nursingObject.end_date))")
                        Text(nursingObject.nursing_option)
                        Text("\(timeToString(nursingObject.left_timer))")
                        Text("\(timeToString(nursingObject.right_timer))")
                    }
                }
                Spacer().frame(width: screenWidth * 0.02)
                PDF_Display_Note(note: nursingObject.note)
                Spacer().frame(width: screenWidth * 0.02)
                PDF_Display_Image(image_data: nursingObject.image_data)
                Spacer().frame(width: screenWidth * 0.02)
            }.font(.system(size: screenWidth * 0.03))
            Divider()
        }
    }
}

struct Bottle_PDF_Display: View {
    
    @EnvironmentObject var hkViewModel: HKViewModel
    
    var body: some View {
        PDF_Display_Titles(firstTitle: "Tarih, Miktar, Seçim")
        ForEach(hkViewModel.bottleObjects.reversed(), id: \.self.id) { bottleObject in
            HStack(alignment: .top, spacing: 0) {
                Spacer().frame(width: screenWidth * 0.02)
                ZStack(alignment: .leading) {
                    Text("").opacity(0).frame(width: screenWidth * 0.3)
                    VStack(alignment: .leading) {
                        Text("\(dateToString(bottleObject.date))")
                        Long_Text_Display(text: bottleObject.amount)
                        Text(bottleObject.choice)
                    }
                }
                Spacer().frame(width: screenWidth * 0.02)
                PDF_Display_Note(note: bottleObject.note)
                Spacer().frame(width: screenWidth * 0.02)
                PDF_Display_Image(image_data: bottleObject.image_data)
                Spacer().frame(width: screenWidth * 0.02)
            }.font(.system(size: screenWidth * 0.03))
            Divider()
        }
    }
}

struct Food_PDF_Display: View {
    
    @EnvironmentObject var hkViewModel: HKViewModel
    
    var body: some View {
        PDF_Display_Titles(firstTitle: "Tarih, Gıda")
        ForEach(hkViewModel.foodObjects.reversed(), id: \.self.id) { foodObject in
            HStack(alignment: .top, spacing: 0) {
                Spacer().frame(width: screenWidth * 0.02)
                ZStack(alignment: .leading) {
                    Text("").opacity(0).frame(width: screenWidth * 0.3)
                    VStack(alignment: .leading) {
                        Text("\(dateToString(foodObject.date))")
                        Long_Text_Display(text: foodObject.food)
                    }
                }
                Spacer().frame(width: screenWidth * 0.02)
                PDF_Display_Note(note: foodObject.note)
                Spacer().frame(width: screenWidth * 0.02)
                PDF_Display_Image(image_data: foodObject.image_data)
                Spacer().frame(width: screenWidth * 0.02)
            }.font(.system(size: screenWidth * 0.03))
            Divider()
        }
    }
}

struct Milking_PDF_Display: View {
    
    @EnvironmentObject var hkViewModel: HKViewModel
    
    var body: some View {
        PDF_Display_Titles(firstTitle: "Tarih, Miktar, Meme")
        ForEach(hkViewModel.milkingObjects.reversed(), id: \.self.id) { milkingObject in
            HStack(alignment: .top, spacing: 0) {
                Spacer().frame(width: screenWidth * 0.02)
                ZStack(alignment: .leading) {
                    Text("").opacity(0).frame(width: screenWidth * 0.3)
                    VStack(alignment: .leading) {
                        Text("\(dateToString(milkingObject.date))")
                        Long_Text_Display(text: milkingObject.amount)
                        Text(milkingObject.breast)
                    }
                }
                Spacer().frame(width: screenWidth * 0.02)
                PDF_Display_Note(note: milkingObject.note)
                Spacer().frame(width: screenWidth * 0.02)
                PDF_Display_Image(image_data: milkingObject.image_data)
                Spacer().frame(width: screenWidth * 0.02)
            }.font(.system(size: screenWidth * 0.03))
            Divider()
        }
    }
}

struct Diaper_PDF_Display: View {
    
    @EnvironmentObject var hkViewModel: HKViewModel
    
    var body: some View {
        PDF_Display_Titles(firstTitle: "Bez, Tarih")
        ForEach(hkViewModel.diaperObjects.reversed(), id: \.self.id) { diaperObject in
            HStack(alignment: .top, spacing: 0) {
                Spacer().frame(width: screenWidth * 0.02)
                ZStack(alignment: .leading) {
                    Text("").opacity(0).frame(width: screenWidth * 0.3)
                    VStack(alignment: .leading) {
                        Text(diaperObject.type)
                        Text("\(dateToString(diaperObject.date))")
                    }
                }
                Spacer().frame(width: screenWidth * 0.02)
                PDF_Display_Note(note: diaperObject.note)
                Spacer().frame(width: screenWidth * 0.02)
                PDF_Display_Image(image_data: diaperObject.image_data)
                Spacer().frame(width: screenWidth * 0.02)
            }.font(.system(size: screenWidth * 0.03))
            Divider()
        }
    }
}

struct Sleep_PDF_Display: View {
    
    @EnvironmentObject var hkViewModel: HKViewModel
    
    var body: some View {
        PDF_Display_Titles(firstTitle: "Başlangıç, Bitiş, Süre")
        ForEach(hkViewModel.sleepObjects.reversed(), id: \.self.id) { sleepObject in
            HStack(alignment: .top, spacing: 0) {
                Spacer().frame(width: screenWidth * 0.02)
                ZStack(alignment: .leading) {
                    Text("").opacity(0).frame(width: screenWidth * 0.3)
                    VStack(alignment: .leading) {
                        Text("\(dateToString(sleepObject.start_date))")
                        Text("\(dateToString(sleepObject.end_date))")
                        Text("\(timeToString(sleepObject.timer_sleep))")
                    }
                }
                Spacer().frame(width: screenWidth * 0.02)
                PDF_Display_Note(note: sleepObject.note)
                Spacer().frame(width: screenWidth * 0.02)
                PDF_Display_Image(image_data: sleepObject.image_data)
                Spacer().frame(width: screenWidth * 0.02)
            }.font(.system(size: screenWidth * 0.03))
            Divider()
        }
    }
}

struct Travel_PDF_Display: View {
    
    @EnvironmentObject var hkViewModel: HKViewModel
    
    var body: some View {
        PDF_Display_Titles(firstTitle: "Başlangıç, Bitiş, Lokasyon")
        ForEach(hkViewModel.travelObjects.reversed(), id: \.self.id) { travelObject in
            HStack(alignment: .top, spacing: 0) {
                Spacer().frame(width: screenWidth * 0.02)
                ZStack(alignment: .leading) {
                    Text("").opacity(0).frame(width: screenWidth * 0.3)
                    VStack(alignment: .leading) {
                        Text("\(dateToString(travelObject.start_date))")
                        Text("\(dateToString(travelObject.end_date))")
                        Long_Text_Display(text: travelObject.location)
                    }
                }
                Spacer().frame(width: screenWidth * 0.02)
                PDF_Display_Note(note: travelObject.note)
                Spacer().frame(width: screenWidth * 0.02)
                PDF_Display_Image(image_data: travelObject.image_data)
                Spacer().frame(width: screenWidth * 0.02)
            }.font(.system(size: screenWidth * 0.03))
            Divider()
        }
    }
}

struct Bath_PDF_Display: View {
    
    @EnvironmentObject var hkViewModel: HKViewModel
    
    var body: some View {
        PDF_Display_Titles(firstTitle: "Başlangıç, Bitiş")
        ForEach(hkViewModel.bathObjects.reversed(), id: \.self.id) { bathObject in
            HStack(alignment: .top, spacing: 0) {
                Spacer().frame(width: screenWidth * 0.02)
                ZStack(alignment: .leading) {
                    Text("").opacity(0).frame(width: screenWidth * 0.3)
                    VStack(alignment: .leading) {
                        Text("\(dateToString(bathObject.start_date))")
                        Text("\(dateToString(bathObject.end_date))")
                    }
                }
                Spacer().frame(width: screenWidth * 0.02)
                PDF_Display_Note(note: bathObject.note)
                Spacer().frame(width: screenWidth * 0.02)
                PDF_Display_Image(image_data: bathObject.image_data)
                Spacer().frame(width: screenWidth * 0.02)
            }.font(.system(size: screenWidth * 0.03))
            Divider()
        }
    }
}

struct Health_PDF_Display: View {
        
    @EnvironmentObject var hkViewModel: HKViewModel
    let pageChoice: String
    
    var body: some View {
        PDF_Display_Titles(firstTitle: "Olay, Tarih")
        ForEach(hkViewModel.healthObjects.reversed(), id: \.self.id) { healthObject in
            if pageChoice == healthObject.choice_name {
                HStack(alignment: .top, spacing: 0) {
                    Spacer().frame(width: screenWidth * 0.02)
                    ZStack(alignment: .leading) {
                        Text("").opacity(0).frame(width: screenWidth * 0.3)
                        VStack(alignment: .leading) {
                            Long_Text_Display(text: healthObject.name)
                            Text("\(dateToString(healthObject.date))")
                        }
                    }
                    Spacer().frame(width: screenWidth * 0.02)
                    PDF_Display_Note(note: healthObject.note)
                    Spacer().frame(width: screenWidth * 0.02)
                    PDF_Display_Image(image_data: healthObject.image_data)
                    Spacer().frame(width: screenWidth * 0.02)
                }.font(.system(size: screenWidth * 0.03))
                Divider()
            }
        }
    }
}

struct PDF_Display_Titles: View {
    
    let firstTitle: String
    
    var body: some View {
        Spacer().frame(height: screenHeight * 0.01)
        HStack(alignment: .top, spacing: 0) {
            Spacer().frame(width: screenWidth * 0.02)
            Text(firstTitle + " - Not - Resim")
        }.font(.system(size: screenWidth * 0.03))
        Divider()
    }
}

struct PDF_Display_Note: View {
    
    let note: String
    
    var body: some View {
        HStack(alignment: .top){
            Text(note).multilineTextAlignment(.leading).fixedSize(horizontal: false, vertical: true)
            Spacer()
        }.frame(width: screenWidth * 0.52)
    }
}

struct Long_Text_Display: View {
    
    let text: String
    
    var body: some View {
        HStack(alignment: .top){
            Text(text).multilineTextAlignment(.leading).fixedSize(horizontal: false, vertical: true)
            Spacer()
        }.frame(width: screenWidth * 0.3)
    }
}
