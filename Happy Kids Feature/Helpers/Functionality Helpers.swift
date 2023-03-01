//
//  Screen Resolutions.swift
//  Happy Kids Feature
//
//  Created by Yusuf Alp Tigin Gün on 6.02.2023.
//

import Foundation
import UIKit
import SwiftUI

// Screen Resolutions

let screenSize = UIScreen.main.bounds.size
let screenWidth: CGFloat = screenSize.width
let screenHeight: CGFloat = screenSize.height

// Colors

extension Color {
    
    public static let UI_navBarColor: UIColor = UIColor(red: 190/255, green: 61/255, blue: 88/255, alpha: 1)
    public static let UI_navBarColorLight: UIColor = UIColor(red: 190/255, green: 61/255, blue: 88/255, alpha: 0.2)
    public static let navBarColor = Color(red: 190/255, green: 61/255, blue: 88/255, opacity: 1)
    public static let navBarColorLight = Color(red: 190/255, green: 61/255, blue: 88/255, opacity: 0.2)
}

// Baby Care Main Page

func onApperBabyCare(hkViewModel: HKViewModel) {
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
}

// PDF Displays

func checkIfPdfDisplayExists(pageName: String, hkViewModel: HKViewModel) -> Bool {
    if pageName == "Emzirme" && !hkViewModel.nursingObjects.isEmpty { return true }
    else if pageName == "Biberon" && !hkViewModel.bottleObjects.isEmpty { return true }
    else if pageName == "Mama" && !hkViewModel.foodObjects.isEmpty { return true }
    else if pageName == "Süt Sağma" && !hkViewModel.milkingObjects.isEmpty { return true }
    else if pageName == "Bebek Bezi" && !hkViewModel.diaperObjects.isEmpty { return true }
    else if pageName == "Uyku" && !hkViewModel.sleepObjects.isEmpty { return true }
    else if pageName == "Gezinti" && !hkViewModel.travelObjects.isEmpty { return true }
    else if pageName == "Banyo" && !hkViewModel.bathObjects.isEmpty { return true }
    else { if checkIfHealthObjectExistsForPage(healthPage: pageName, healthObjects: hkViewModel.healthObjects){ return true } }
    return false
}

// Date Functions

var dateClosedRange: ClosedRange<Date> {
    let todayDate = Calendar(identifier: .gregorian).dateComponents([.year, .month, .day], from: Date())
    let startDateComponents = DateComponents(
        timeZone: TimeZone.current,
        year: todayDate.year! - 5, month: todayDate.month, day: todayDate.day, hour: 0, minute: 0, second: 0)
    let endDateComponents = DateComponents(
        timeZone: TimeZone.current,
        year: todayDate.year! + 5, month: todayDate.month, day: todayDate.day, hour: 0, minute: 0, second: 0)
    let min = Calendar(identifier: .gregorian).date(from: startDateComponents)!
    let max = Calendar(identifier: .gregorian).date(from: endDateComponents)!
    return min...max
}

func dateToString(_ date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
    return dateFormatter.string(from: date)
}

// Time Functions

func timeToString(_ timer: Int) -> String {
    
    if timer >= 86400 { return String("24:00:00") }
    
    let timerSeconds = timer % 60
    let timerMinutes = (timer % 3600) / 60
    let timerHours = (timer % 86400) / 60 / 60
    let timerSecondsString = timerSeconds < 10 ? String("0\(timerSeconds)") : String(timerSeconds)
    let timerMinutesString = timerMinutes < 10 ? String("0\(timerMinutes)") : String(timerMinutes)
    let timerHoursString = timerHours < 10 ? String("0\(timerHours)") : String(timerHours)
    
    return String(timerHoursString + ":" + timerMinutesString + ":" + timerSecondsString)
}

// Segmented Control Functions

func getActiveDiaperText(diapersText: [String], diapersActive: [Bool]) -> String {
    var index: Int = 0
    for i in 0...(diapersActive.count - 1) {
        if diapersActive[i] {
            index = i
            break
        }
    }
    return diapersText[index]
}

func getActiveDiapers(_ type: String) -> [Bool] {
    var diapersActive: [Bool] = [false, false, false, false]
    let diapersText: [String] = ["Islak", "Kirli", "Karışık", "Temiz"]
    for i in 0...(diapersText.count - 1) {
        if diapersText[i] == type {
            diapersActive[i] = true
            break
        }
    }
    return diapersActive
}

func checkIfHealthObjectExistsForPage(healthPage: String, healthObjects: [HealthObjectModel]) -> Bool {
    for healthObject in healthObjects { if healthObject.choice_name == healthPage { return true } }
    return false
}

func getIconFromHealthPage(_ healthPage: String) -> String {
    let choices: Choices = Choices()
    var index: Int = 0
    
    for i in 0...(choices.healthChoices.count - 1) {
        if choices.healthChoices[i] == healthPage {
            index = i
            break
        }
    }
    return choices.healthIcons[index]
}

// Choice Classes

class Choices {
    
    let pages: [String] = ["Yemek", "Aktivite", "Sağlık"]
    let foodChoices: [String] = ["Emzirme", "Biberon", "Mama", "Süt Sağma"]
    let activityChoices: [String] = ["Bebek Bezi", "Uyku", "Gezinti", "Banyo"]
    let healthChoices: [String] = ["Doktor", "Aşı", "Ateş", "Hastalık", "İlaç"]
    let foodIcons: [String] = ["breast_feeding", "baby_bottle", "food", "milking"]
    let activityIcons: [String] = ["diaper", "powersleep", "stroller.fill", "bathtub.fill"]
    let healthIcons: [String] = ["cross.case.fill", "syringe.fill", "medical.thermometer", "heart.fill", "pill.fill"]

    let healthChoiceSpecifics: [[String]] = [
        ["Çocuk Doktoru", "Kulak Burun Boğaz", "Diş Doktoru", "Göz Doktoru", "İç Hastalıkları", "Aile Hekimi", "Nörolojist", "Ortopedist", "Psikiyatrist", "Hastane", "Aile Hekimi"], // 11
        ["Hepatit B", "Verem Aşısı (BCG)", "KPA", "DaBT - İPA - Hib", "Hepatit A", "Su Çiçeği", "OPA", "Grip", "Kızamış", "Kabakulak", "Difteri", "Tetanoz", "Boğmaca"], // 13
        ["35,6", "36", "36,4", "36,8", "37", "37,2", "37,4", "37,6", "37,8", "38", "38,4", "38,8"],
        ["Grip", "Soğuk Algınlığı", "Burun Akıntısı", "Kuru Öksürük", "Balgamlı Öksürük", "Diş Çıkarma", "Kızamık", "Solunum Yolu Enfeksiyonu", "Bronşit", "Sinüzit", "İshal", "Zehirlenme"], // 12
        ["Damla", "Sprey", "Ateş Düşürücü", "Ağrı Kesici", "Antibiyotik", "Antiseptik", "C Vitamini", "D Vitamini", "Merhem", "Krem"] // 10
    ]
}

