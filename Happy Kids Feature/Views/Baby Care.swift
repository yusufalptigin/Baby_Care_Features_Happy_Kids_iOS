//
//  Baby Care.swift
//  Happy Kids Feature
//
//  Created by Yusuf Alp Tigin Gün on 6.02.2023.
//

import SwiftUI // Uyku Emzirme Bebek Bezi

struct Baby_Care: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @StateObject var hkViewModel = HKViewModel()
    
    @State private var page = "Yemek"
    @State private var foodPage: String = "Emzirme"
    @State private var activityPage: String = "Bebek Bezi"
    @State private var healthPage: String = "Doktor"
    @State private var showPdfSheet: Bool = false
    let choices: Choices = Choices()

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack {
                Image("baby_care").resizable().frame(width: screenWidth, height: 250)
                Picker("", selection: $page) {
                    ForEach(choices.pages, id: \.self) { page in
                        Text(page)
                    }
                }.padding(.all, 10.0).pickerStyle(.segmented)
                if page == "Yemek" { Console_Model(choiceNames: choices.foodChoices).environmentObject(hkViewModel) }
                else if page == "Aktivite" { Console_Model(choiceNames: choices.activityChoices).environmentObject(hkViewModel) }
                else if page == "Sağlık" { Console_Model(choiceNames: choices.healthChoices).environmentObject(hkViewModel) }
                Spacer()
            }.frame(maxHeight: .infinity)
            NavigationLink(destination: Add_Choices().environmentObject(hkViewModel)){ Floating_Action_Button() }.padding([.bottom, .trailing], 20)
        }.onAppear {
            
            let segmentedControlAppearance = UISegmentedControl.appearance()
            let attributesNormal = [ NSAttributedString.Key.foregroundColor : Color.UI_navBarColor ]
            let attributesSelected = [ NSAttributedString.Key.foregroundColor : UIColor.white ]
            
            segmentedControlAppearance.selectedSegmentTintColor = Color.UI_navBarColor
            segmentedControlAppearance.setTitleTextAttributes(attributesNormal, for: .normal)
            segmentedControlAppearance.setTitleTextAttributes(attributesSelected, for: .selected)
          
            let navigationBarAppeareance = UINavigationBarAppearance()
            navigationBarAppeareance.configureWithOpaqueBackground()
            navigationBarAppeareance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navigationBarAppeareance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            navigationBarAppeareance.backgroundColor = Color.UI_navBarColor
            UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppeareance
            UINavigationBar.appearance().standardAppearance = navigationBarAppeareance

            // Get Food Objects
            
            hkViewModel.getAllNursingObjects()
            hkViewModel.getAllBottleObjects()
            hkViewModel.getAllFoodObjects()
            hkViewModel.getAllMilkingObjects()
            
            // Get Activity Objects
            
            hkViewModel.getAllDiaperObjects()
            hkViewModel.getAllSleepObjects()
            hkViewModel.getAllTravelObjects()
            hkViewModel.getAllBathObjects()
            
            // Get Health Objects
            
            hkViewModel.getAllHealthObjects()
            
        }.navigationTitle("Bebek Bakımı")
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            /* iOS 16.0+
             .toolbarBackground(.visible, for: .navigationBar)
             .toolbarBackground(Color.navBarColor, for: .navigationBar)
             .toolbarColorScheme(.dark, for: .navigationBar)
            */
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading){
                    Button(action: {mode.wrappedValue.dismiss()})
                    {Image(systemName: "chevron.backward").foregroundColor(.white)}
                }
            }
    }
}
