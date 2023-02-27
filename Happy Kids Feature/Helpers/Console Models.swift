//
//  Console Models.swift
//  Happy Kids Feature
//
//  Created by Yusuf Alp Tigin Gün on 22.02.2023.
//

import SwiftUI

struct Console_Model: View {
    
    @EnvironmentObject var hkViewModel: HKViewModel
    let choiceNames: [String]
    
    var body: some View {
        VStack(spacing: 10) {
            ForEach(0...(choiceNames.count - 1), id: \.self) { index in
                if index == 0 || index == (choiceNames.count - 1) {
                    HStack { Console_Model_Circle(pageChoice: choiceNames[index]) }
                } else if index == 1 {
                    HStack(spacing: 10){
                        ForEach(0...(choiceNames.count - 3), id: \.self) { innerIndex in
                            Console_Model_Circle(pageChoice: choiceNames[innerIndex + 1])
                            if innerIndex == 0 && choiceNames.count == 4 { Console_Model_Circle(pageChoice: "").opacity(0) }
                        }
                    }
                }
            }
        }
    }
}

struct Console_Model_Circle: View {
    
    @EnvironmentObject var hkViewModel: HKViewModel
    let pageChoice: String
    
    var body: some View {
        NavigationLink(destination: Objects_Display(pageChoice: pageChoice).environmentObject(hkViewModel)) {
            Circle().fill(Color.navBarColor)
                .frame(width: screenWidth * 0.25, height: screenWidth * 0.25)
                .overlay(Text(pageChoice).foregroundColor(.white))
                .shadow(radius: 2)
        }
    }
}
