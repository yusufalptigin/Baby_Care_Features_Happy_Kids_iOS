//
//  HK Models Manager.swift
//  Happy Kids Feature
//
//  Created by Yusuf Alp Tigin Gün on 7.02.2023.
//

import CoreData
import Foundation

class HKModelsManager {
    
    let persistentContainer: NSPersistentContainer
    static let sharedHKModels = HKModelsManager()
    var viewContext: NSManagedObjectContext { return persistentContainer.viewContext }
    
    private init() {
        self.persistentContainer = NSPersistentContainer(name: "HK Models")
        self.persistentContainer.loadPersistentStores{ (description, error) in
            if let error = error {
                fatalError("Core data store failed \(error.localizedDescription)")
            }
        }
    }
    
    // Share Save Function
    
    func save() {
        do { try viewContext.save() }
        catch { viewContext.rollback() }
    }
    
    // Nursing Object Functions
    
    func deleteNursingObject(_ nursingObject: Nursing) {
        viewContext.delete(nursingObject)
        save()
    }
    
    func getNursingObjectByID(_ id: NSManagedObjectID) -> Nursing? {
        do { return try viewContext.existingObject(with: id) as? Nursing }
        catch { return nil }
    }
    
    func getAllNursingObjects() -> [Nursing] {
        let request: NSFetchRequest<Nursing> = Nursing.fetchRequest()
        do { return try viewContext.fetch(request) }
        catch { return [] }
    }
    
    // Bottle Object Functions
    
    func deleteBottleObject(_ bottleObject: Bottle) {
        viewContext.delete(bottleObject)
        save()
    }

    func getBottleObjectByID(_ id: NSManagedObjectID) -> Bottle? {
        do { return try viewContext.existingObject(with: id) as? Bottle }
        catch { return nil }
    }
    
    func getAllBottleObjects() -> [Bottle] {
        let request: NSFetchRequest<Bottle> = Bottle.fetchRequest()
        do { return try viewContext.fetch(request) }
        catch { return [] }
    }
    
    // Food Object Functions
    
    func deleteFoodObject(_ foodObject: Food) {
        viewContext.delete(foodObject)
        save()
    }
    
    func getfoodObjectByID(_ id: NSManagedObjectID) -> Food? {
        do { return try viewContext.existingObject(with: id) as? Food }
        catch { return nil }
    }
    
    func getAllFoodObjects() -> [Food] {
        let request: NSFetchRequest<Food> = Food.fetchRequest()
        do { return try viewContext.fetch(request) }
        catch { return [] }
    }
    
    // Milking Object Functions
    
    func deleteMilkingObject(_ milkingObject: Milking) {
        viewContext.delete(milkingObject)
        save()
    }
    
    func getMilkingObjectByID(_ id: NSManagedObjectID) -> Milking? {
        do { return try viewContext.existingObject(with: id) as? Milking }
        catch { return nil }
    }
    
    func getAllMilkingObjects() -> [Milking] {
        let request: NSFetchRequest<Milking> = Milking.fetchRequest()
        do { return try viewContext.fetch(request) }
        catch { return [] }
    }
    
    // Diaper Object Functions
    
    func deleteDiaperObject(_ diaperObject: Diaper) {
        viewContext.delete(diaperObject)
        save()
    }
    
    func getDiaperObjectByID(_ id: NSManagedObjectID) -> Diaper? {
        do { return try viewContext.existingObject(with: id) as? Diaper }
        catch { return nil }
    }
    
    func getAllDiaperObjects() -> [Diaper] {
        let request: NSFetchRequest<Diaper> = Diaper.fetchRequest()
        do { return try viewContext.fetch(request) }
        catch { return [] }
    }
    
    // Sleep Object Functions
    
    func deleteSleepObject(_ sleepObject: Sleep) {
        viewContext.delete(sleepObject)
        save()
    }
    
    func getSleepObjectByID(_ id: NSManagedObjectID) -> Sleep? {
        do { return try viewContext.existingObject(with: id) as? Sleep }
        catch { return nil }
    }
    
    func getAllSleepObjects() -> [Sleep] {
        let request: NSFetchRequest<Sleep> = Sleep.fetchRequest()
        do { return try viewContext.fetch(request) }
        catch { return [] }
    }
    
    // Travel Object Functions
    
    func deleteTraveObject(_ travelObject: Travel) {
        viewContext.delete(travelObject)
        save()
    }
    
    func getTravelObjectByID(_ id: NSManagedObjectID) -> Travel? {
        do { return try viewContext.existingObject(with: id) as? Travel }
        catch { return nil }
    }
    
    func getAllTravelObjects() -> [Travel] {
        let request: NSFetchRequest<Travel> = Travel.fetchRequest()
        do { return try viewContext.fetch(request) }
        catch { return [] }
    }

    // Bath Object Functions
    
    func deleteBathObject(_ bathObject: Bath) {
        viewContext.delete(bathObject)
        save()
    }
    
    func getBathObjectByID(_ id: NSManagedObjectID) -> Bath? {
        do { return try viewContext.existingObject(with: id) as? Bath }
        catch { return nil }
    }
    
    func getAllBathObjects() -> [Bath] {
        let request: NSFetchRequest<Bath> = Bath.fetchRequest()
        do { return try viewContext.fetch(request) }
        catch { return [] }
    }
    
    // Health Object Functions
    
    func deleteHealthObject(_ healthObject: Health) {
        viewContext.delete(healthObject)
        save()
    }
    
    func getHealthObjectByID(_ id: NSManagedObjectID) -> Health? {
        do { return try viewContext.existingObject(with: id) as? Health }
        catch { return nil }
    }
    
    func getAllHealthObjects() -> [Health] {
        let request: NSFetchRequest<Health> = Health.fetchRequest()
        do { return try viewContext.fetch(request) }
        catch { return [] }
    }
}
