//
//  HK View Model.swift
//  Happy Kids Feature
//
//  Created by Yusuf Alp Tigin Gün on 8.02.2023.
//

import Foundation
import SwiftUI
import PhotosUI
import CoreData

class HKViewModel: ObservableObject {
    
    // Food
    @Published var nursingObjects: [NursingObjectModel] = []
    @Published var bottleObjects: [BottleObjectModel] = []
    @Published var foodObjects: [FoodObjectModel] = []
    @Published var milkingObjects: [MilkingObjectModel] = []
    
    //Activity
    @Published var diaperObjects: [DiaperObjectModel] = []
    @Published var sleepObjects: [SleepObjectModel] = []
    @Published var travelObjects: [TravelObjectModel] = []
    @Published var bathObjects: [BathObjectModel] = []
    
    //Health
    @Published var healthObjects: [HealthObjectModel] = []
    
    // Nursing CRUD
    
    func saveNursingObject(start_date: Date, end_date: Date, right_timer: Int, left_timer: Int, nursing_option: String, note: String, image_data: Data?) {
        let nursingObject = Nursing(context: HKModelsManager.sharedHKModels.viewContext)
        nursingObject.start_date = start_date
        nursingObject.end_date = end_date
        nursingObject.right_timer = Int64(right_timer)
        nursingObject.left_timer = Int64(left_timer)
        nursingObject.nursing_option = nursing_option
        nursingObject.note = note
        nursingObject.image_data = image_data
        HKModelsManager.sharedHKModels.save()
    }
    
    func updateNursingObject(start_date: Date, end_date: Date, right_timer: Int, left_timer: Int,nursing_option: String, note: String, image_data: Data?, nursingObject: NursingObjectModel) {
        let existingNursingObject = HKModelsManager.sharedHKModels.getNursingObjectByID(nursingObject.id)
        if let existingNursingObject = existingNursingObject {
            existingNursingObject.start_date = start_date
            existingNursingObject.end_date = end_date
            existingNursingObject.left_timer = Int64(left_timer)
            existingNursingObject.right_timer = Int64(right_timer)
            existingNursingObject.nursing_option = nursing_option
            existingNursingObject.note = note
            existingNursingObject.image_data = image_data
            HKModelsManager.sharedHKModels.save()
        } else { return }
    }
    
    func deleteNursingObject(_ nursingObject: NursingObjectModel) {
        let existingNursingObject = HKModelsManager.sharedHKModels.getNursingObjectByID(nursingObject.id)
        if let existingNursingObject = existingNursingObject { HKModelsManager.sharedHKModels.deleteNursingObject(existingNursingObject) }
        else { return }
    }
    
    func getAllNursingObjects() {
        self.nursingObjects = HKModelsManager.sharedHKModels.getAllNursingObjects().map { nursingObject in
            NursingObjectModel(nursingObject: nursingObject)
        }
    }
    
    // Bottle CRUD
    
    func saveBottleObject(amount: String, choice: String, date: Date, note: String, image_data: Data?) {
        let bottleObject = Bottle(context: HKModelsManager.sharedHKModels.viewContext)
        bottleObject.amount = amount
        bottleObject.choice = choice
        bottleObject.date = date
        bottleObject.note = note
        bottleObject.image_data = image_data
        HKModelsManager.sharedHKModels.save()
    }
    
    func updateBottleObject(amount: String, choice: String, date: Date, note: String, image_data: Data?, bottleObject: BottleObjectModel) {
        let existingBottleObject = HKModelsManager.sharedHKModels.getBottleObjectByID(bottleObject.id)
        if let existingBottleObject = existingBottleObject {
            existingBottleObject.amount = amount
            existingBottleObject.choice = choice
            existingBottleObject.date = date
            existingBottleObject.note = note
            existingBottleObject.image_data = image_data
            HKModelsManager.sharedHKModels.save()
        } else { return }
    }
    
    func deleteBottleObject(_ bottleObject: BottleObjectModel) {
        let existingBottleObject = HKModelsManager.sharedHKModels.getBottleObjectByID(bottleObject.id)
        if let existingBottleObject = existingBottleObject { HKModelsManager.sharedHKModels.deleteBottleObject(existingBottleObject) }
        else { return }
    }

    func getAllBottleObjects() {
        self.bottleObjects = HKModelsManager.sharedHKModels.getAllBottleObjects().map { bottleObject in
            BottleObjectModel(bottleObject: bottleObject)
        }
    }
    
    // Food CRUD
    
    func saveFoodObject(food: String, date: Date, note: String, image_data: Data?) {
        let foodObject = Food(context: HKModelsManager.sharedHKModels.viewContext)
        foodObject.food = food
        foodObject.date = date
        foodObject.note = note
        foodObject.image_data = image_data
        HKModelsManager.sharedHKModels.save()
    }
    
    func updateFoodObject(food: String, date: Date, note: String, image_data: Data?, foodObject: FoodObjectModel) {
        let existingFoodObject = HKModelsManager.sharedHKModels.getfoodObjectByID(foodObject.id)
        if let existingFoodObject = existingFoodObject {
            existingFoodObject.food = food
            existingFoodObject.date = date
            existingFoodObject.note = note
            existingFoodObject.image_data = image_data
            HKModelsManager.sharedHKModels.save()
        } else { return }
    }
    
    func deleteFoodObject(_ foodObject: FoodObjectModel) {
        let existingFoodObject = HKModelsManager.sharedHKModels.getfoodObjectByID(foodObject.id)
        if let existingFoodObject = existingFoodObject { HKModelsManager.sharedHKModels.deleteFoodObject(existingFoodObject) }
        else { return }
    }
    
    func getAllFoodObjects() {
        self.foodObjects = HKModelsManager.sharedHKModels.getAllFoodObjects().map { foodObject in
            FoodObjectModel(foodObject: foodObject)
        }
    }
    
    // Milking CRUD
    
    func saveMilkingObject(amount: String, breast: String, date: Date, note: String, image_data: Data?) {
        let milkingObject = Milking(context: HKModelsManager.sharedHKModels.viewContext)
        milkingObject.amount = amount
        milkingObject.breast = breast
        milkingObject.date = date
        milkingObject.note = note
        milkingObject.image_data = image_data
        HKModelsManager.sharedHKModels.save()
    }
    
    func updateMilkingObjects(amount: String, breast: String, date: Date, note: String, image_data: Data?, milkingObject: MilkingObjectModel) {
        let existingMilkingObject = HKModelsManager.sharedHKModels.getMilkingObjectByID(milkingObject.id)
        if let existingMilkingObject = existingMilkingObject {
            existingMilkingObject.amount = amount
            existingMilkingObject.breast = breast
            existingMilkingObject.date = date
            existingMilkingObject.note = note
            existingMilkingObject.image_data = image_data
            HKModelsManager.sharedHKModels.save()
        } else { return }
    }
    
    func deleteMilkingObject(_ milkingObject: MilkingObjectModel) {
        let existingMilkingObject = HKModelsManager.sharedHKModels.getMilkingObjectByID(milkingObject.id)
        if let existingMilkingObject = existingMilkingObject { HKModelsManager.sharedHKModels.deleteMilkingObject(existingMilkingObject) }
        else { return }
    }
    
    func getAllMilkingObjects() {
        self.milkingObjects = HKModelsManager.sharedHKModels.getAllMilkingObjects().map { milkingObject in
            MilkingObjectModel(milkingObject: milkingObject)
        }
    }
    
    // Diaper CRUD
    
    func saveDiaperObject(date: Date, type: String, note: String, image_data: Data?) {
        let diaperObject = Diaper(context: HKModelsManager.sharedHKModels.viewContext)
        diaperObject.date = date
        diaperObject.type = type
        diaperObject.note = note
        diaperObject.image_data = image_data
        HKModelsManager.sharedHKModels.save()
    }
    
    func updateDiaperObject(date: Date, type: String, note: String, image_data: Data?, diaperObject: DiaperObjectModel) {
        let existingDiaperObject = HKModelsManager.sharedHKModels.getDiaperObjectByID(diaperObject.id)
        if let existingDiaperObject = existingDiaperObject {
            existingDiaperObject.date = date
            existingDiaperObject.type = type
            existingDiaperObject.note = note
            existingDiaperObject.image_data = image_data
            HKModelsManager.sharedHKModels.save()
        } else { return }
    }
    
    func deleteDiaperObject(_ diaperObject: DiaperObjectModel) {
        let existingDiaperObject = HKModelsManager.sharedHKModels.getDiaperObjectByID(diaperObject.id)
        if let existingDiaperObject = existingDiaperObject { HKModelsManager.sharedHKModels.deleteDiaperObject(existingDiaperObject) }
        else { return  }
    }
    
    func getAllDiaperObjects() {
        self.diaperObjects = HKModelsManager.sharedHKModels.getAllDiaperObjects().map { diaperObject in
            DiaperObjectModel(diaperObject: diaperObject)
        }
    }
    
    // Sleep CRUD
    
    func saveSleepObject(start_date: Date, end_date: Date, timer_sleep: Int, note: String, image_data: Data?) {
        let sleepObject = Sleep(context: HKModelsManager.sharedHKModels.viewContext)
        sleepObject.start_date = start_date
        sleepObject.end_date = end_date
        sleepObject.timer_sleep = Int64(timer_sleep)
        sleepObject.note = note
        sleepObject.image_data = image_data
        HKModelsManager.sharedHKModels.save()
    }
    
    func updateSleepObject(start_date: Date, end_date: Date, timer_sleep: Int, note: String, image_data: Data?, sleepObject: SleepObjectModel) {
        let existingSleepObject = HKModelsManager.sharedHKModels.getSleepObjectByID(sleepObject.id)
        if let existingSleepObject = existingSleepObject {
            existingSleepObject.start_date = start_date
            existingSleepObject.end_date = end_date
            existingSleepObject.timer_sleep = Int64(timer_sleep)
            existingSleepObject.note = note
            existingSleepObject.image_data = image_data
            HKModelsManager.sharedHKModels.save()
        } else { return }
    }
    
    func deleteSleepObject(_ sleepObject: SleepObjectModel) {
        let existingSleepObject = HKModelsManager.sharedHKModels.getSleepObjectByID(sleepObject.id)
        if let existingSleepObject = existingSleepObject { HKModelsManager.sharedHKModels.deleteSleepObject(existingSleepObject) }
        else { return }
    }
    
    func getAllSleepObjects() {
        self.sleepObjects = HKModelsManager.sharedHKModels.getAllSleepObjects().map { sleepObject in
            SleepObjectModel(sleepObject: sleepObject)
        }
    }
    
    // Travel CRUD
    
    func saveTravelObject(location: String, start_date: Date, end_date: Date, note: String, image_data: Data?) {
        let travelObject = Travel(context: HKModelsManager.sharedHKModels.viewContext)
        travelObject.location = location
        travelObject.start_date = start_date
        travelObject.end_date = end_date
        travelObject.note = note
        travelObject.image_data = image_data
        HKModelsManager.sharedHKModels.save()
    }
    
    func updateTravelObject(location: String, start_date: Date, end_date: Date, note: String, image_data: Data?, travelObject: TravelObjectModel) {
        let existingTravelObject = HKModelsManager.sharedHKModels.getTravelObjectByID(travelObject.id)
        if let existingTravelObject = existingTravelObject {
            existingTravelObject.location = location
            existingTravelObject.start_date = start_date
            existingTravelObject.end_date = end_date
            existingTravelObject.note = note
            existingTravelObject.image_data = image_data
            HKModelsManager.sharedHKModels.save()
        } else { return }
    }
    
    func deleteTravelObject(_ travelObject: TravelObjectModel) {
        let existingTravelObject = HKModelsManager.sharedHKModels.getTravelObjectByID(travelObject.id)
        if let existingTravelObject = existingTravelObject { HKModelsManager.sharedHKModels.deleteTraveObject(existingTravelObject) }
        else { return }
    }
    
    func getAllTravelObjects() {
        self.travelObjects = HKModelsManager.sharedHKModels.getAllTravelObjects().map { travelObject in
            TravelObjectModel(travelObject: travelObject)
        }
    }
    
    // Bath CRUD
    
    func saveBathObject(start_date: Date, end_date: Date, note: String, image_data: Data?) {
        let bathObject = Bath(context: HKModelsManager.sharedHKModels.viewContext)
        bathObject.start_date = start_date
        bathObject.end_date = end_date
        bathObject.note = note
        bathObject.image_data = image_data
        HKModelsManager.sharedHKModels.save()
    }
    
    func updateBathObject(start_date: Date, end_date: Date, note: String, image_data: Data?, bathObject: BathObjectModel) {
        let existingBathObject = HKModelsManager.sharedHKModels.getBathObjectByID(bathObject.id)
        if let existingBathObject = existingBathObject {
            existingBathObject.start_date = start_date
            existingBathObject.end_date = end_date
            existingBathObject.note = note
            existingBathObject.image_data = image_data
            HKModelsManager.sharedHKModels.save()
        } else { return }
    }
    
    func deleteBathObject(_ bathObject: BathObjectModel) {
        let existingBathObject = HKModelsManager.sharedHKModels.getBathObjectByID(bathObject.id)
        if let existingBathObject = existingBathObject { HKModelsManager.sharedHKModels.deleteBathObject(existingBathObject) }
        else { return }
    }
    
    func getAllBathObjects() {
        self.bathObjects = HKModelsManager.sharedHKModels.getAllBathObjects().map { bathObject in
            BathObjectModel(bathObject: bathObject)
        }
    }

    // Health CRUD
    
    func saveHealthObject(date: Date, choice_index: Int, choice_name: String, name: String, note: String, image_data: Data?) {
        let healthObject = Health(context: HKModelsManager.sharedHKModels.viewContext)
        healthObject.date = date
        healthObject.choice_index = Int64(choice_index)
        healthObject.choice_name = choice_name
        healthObject.name = name
        healthObject.note = note
        healthObject.image_data = image_data
        HKModelsManager.sharedHKModels.save()
    }
    
    func updateHealthObject(
        date: Date, choice_index: Int, choice_name: String, name: String, note: String, image_data: Data?, healthObject: HealthObjectModel) {
        let existingHealthObject = HKModelsManager.sharedHKModels.getHealthObjectByID(healthObject.id)
        if let existingHealthObject = existingHealthObject {
            existingHealthObject.date = date
            existingHealthObject.choice_index = Int64(choice_index)
            existingHealthObject.choice_name = choice_name
            existingHealthObject.name = name
            existingHealthObject.note = note
            existingHealthObject.image_data = image_data
            HKModelsManager.sharedHKModels.save()
        } else { return }
    }
    
    func deleteHealthObject(_ healthObject: HealthObjectModel) {
        let existingHealthObject = HKModelsManager.sharedHKModels.getHealthObjectByID(healthObject.id)
        if let existingHealthObject = existingHealthObject { HKModelsManager.sharedHKModels.deleteHealthObject(existingHealthObject) }
        else { return }
    }

    func getAllHealthObjects() {
        self.healthObjects = HKModelsManager.sharedHKModels.getAllHealthObjects().map { healthObject in
            HealthObjectModel(healthObject: healthObject)
        }
    }
    
}
