//
//  Segmented_Control.swift
//  Happy Kids Feature
//
//  Created by Yusuf Alp Tigin Gün on 6.02.2023.
//

import SwiftUI

struct Segmented_Control: View {
    
    init () {
        let attributesNormal = [ NSAttributedString.Key.foregroundColor : Color.UI_navBarColor ]
        let attributesSelected = [ NSAttributedString.Key.foregroundColor : UIColor.white ]
        
        UISegmentedControl.appearance().selectedSegmentTintColor = Color.UI_navBarColor
        UISegmentedControl.appearance().setTitleTextAttributes(attributesNormal, for: .normal)
        UISegmentedControl.appearance().setTitleTextAttributes(attributesSelected, for: .selected)
    }
    
    @FocusState private var focusKeyboard: Bool
    @State private var showStartDatePicker: Bool = false
    @State private var showEndDatePicker: Bool = false
    @State private var note: String = "Not Ekle (Opsiyonel)"
    @State var startDate: Date = Date()
    @State var endDate: Date = Date()
    @State var option: String = "Manuel"
    let options: [String] = ["Manuel", "Zamanlayıcı"]
    
    var body: some View {
        VStack {
            Picker("", selection: $option) {
                ForEach(options, id: \.self) { option in
                    Text(option)
                }
            }.padding(.all, 10.0).accentColor(.orange).pickerStyle(.segmented)
            VStack(spacing: 0){
                if option == "Manuel" {
                    Start_and_End_Dates(
                        showStartDatePicker: $showStartDatePicker,
                        showEndDatePicker: $showEndDatePicker,
                        startDate: $startDate,
                        endDate: $endDate)
                }
                else {
                    Text("dd")
                }
                Notes_and_Picture(note: $note)
            }.frame(width: screenWidth * 0.9)
            Spacer()
        }
    }
}

struct Segmented_Control_Previews: PreviewProvider {
    static var previews: some View {
        Segmented_Control()
    }
}
