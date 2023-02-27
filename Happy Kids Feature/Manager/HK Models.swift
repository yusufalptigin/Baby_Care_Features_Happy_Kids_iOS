//
//  HK Models.swift
//  Happy Kids Feature
//
//  Created by Yusuf Alp Tigin Gün on 8.02.2023.
//

import Foundation
import CoreData

struct NursingObjectModel: Hashable {
    
    init(nursingObject: Nursing) {
        self.id = nursingObject.objectID
        self.start_date = nursingObject.start_date ?? Date()
        self.end_date = nursingObject.end_date ?? Date()
        self.right_timer = Int(nursingObject.right_timer)
        self.left_timer = Int(nursingObject.left_timer)
        self.nursing_option = nursingObject.nursing_option ?? ""
        self.note = nursingObject.note ?? ""
        self.image_data = nursingObject.image_data
    }

    var id: NSManagedObjectID
    var start_date: Date
    var end_date: Date
    var right_timer: Int
    var left_timer: Int
    var nursing_option: String
    var note: String
    var image_data: Data?
}

struct BottleObjectModel: Hashable {
    
    init(bottleObject: Bottle) {
        
        self.id = bottleObject.objectID
        self.amount = bottleObject.amount ?? "0"
        self.choice = bottleObject.choice ?? "Sağılan Süt"
        self.date = bottleObject.date ?? Date()
        self.note = bottleObject.note ?? ""
        self.image_data = bottleObject.image_data
    }
    
    var id: NSManagedObjectID
    var amount: String
    var choice: String
    var date: Date
    var note: String
    var image_data: Data?
}

struct FoodObjectModel: Hashable {
    
    init(foodObject: Food) {
        self.id = foodObject.objectID
        self.food = foodObject.food ?? ""
        self.date = foodObject.date ?? Date()
        self.note = foodObject.note ?? ""
        self.image_data = foodObject.image_data
    }
    
    var id: NSManagedObjectID
    var food: String
    var date: Date
    var note: String
    var image_data: Data?
}

struct MilkingObjectModel: Hashable {
    
    init(milkingObject: Milking) {
        self.id = milkingObject.objectID
        self.amount = milkingObject.amount ?? "0"
        self.breast = milkingObject.breast ?? "Sol"
        self.date = milkingObject.date ?? Date()
        self.note = milkingObject.note ?? ""
        self.image_data = milkingObject.image_data
    }
    
    var id: NSManagedObjectID
    var amount: String
    var breast: String
    var date: Date
    var note: String
    var image_data: Data?
}

struct DiaperObjectModel: Hashable {
    
    init(diaperObject: Diaper) {
        self.id = diaperObject.objectID
        self.date = diaperObject.date ?? Date()
        self.type = diaperObject.type ?? "Kirli"
        self.note = diaperObject.note ?? ""
        self.image_data = diaperObject.image_data
    }
    
    var id: NSManagedObjectID
    var date: Date
    var type: String
    var note: String
    var image_data: Data?
}

struct SleepObjectModel: Hashable {
    
    init(sleepObject: Sleep) {
        
        self.id = sleepObject.objectID
        self.start_date = sleepObject.start_date ?? Date()
        self.end_date = sleepObject.end_date ?? Date()
        self.timer_sleep = Int(sleepObject.timer_sleep)
        self.note = sleepObject.note ?? ""
        self.image_data = sleepObject.image_data
    }
    
    var id: NSManagedObjectID
    var start_date: Date
    var end_date: Date
    var timer_sleep: Int
    var note: String
    var image_data: Data?
}

struct TravelObjectModel: Hashable {
    
    init(travelObject: Travel) {
        
        self.id = travelObject.objectID
        self.location = travelObject.location ?? ""
        self.start_date = travelObject.start_date ?? Date()
        self.end_date = travelObject.end_date ?? Date()
        self.note = travelObject.note ?? ""
        self.image_data = travelObject.image_data
    }
    
    var id: NSManagedObjectID
    var location: String
    var start_date: Date
    var end_date: Date
    var note: String
    var image_data: Data?
}

struct BathObjectModel: Hashable {
    
    init(bathObject: Bath) {
        
        self.id = bathObject.objectID
        self.start_date = bathObject.start_date ?? Date()
        self.end_date = bathObject.end_date ?? Date()
        self.note = bathObject.note ?? ""
        self.image_data = bathObject.image_data
    }
    
    var id: NSManagedObjectID
    var start_date: Date
    var end_date: Date
    var note: String
    var image_data: Data?
}

struct HealthObjectModel: Hashable {
    
    init(healthObject: Health) {
        self.id = healthObject.objectID
        self.date = healthObject.date ?? Date()
        self.choice_index = Int(healthObject.choice_index)
        self.choice_name = healthObject.choice_name ?? "Doktor Kontrolü"
        self.name = healthObject.name ?? "Sağlık"
        self.note = healthObject.note ?? ""
        self.image_data = healthObject.image_data
    }
    
    var id: NSManagedObjectID
    var date: Date
    var choice_index: Int
    var choice_name: String
    var name: String
    var note: String
    var image_data: Data?
}
