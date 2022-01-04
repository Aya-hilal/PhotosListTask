//
//  PersistDataManager.swift
//  PhotosListTask
//
//  Created by Aya Mohamed Hilal on 04/01/2022.
//

import Foundation
import RealmSwift

protocol Persistable {
    associatedtype ManagedObject: RealmSwift.Object
    
    init(managedObject: ManagedObject)
    func getManagedObject() -> ManagedObject
}

class PersistDataManager {
    static let shared = PersistDataManager()
    private var realm: Realm?
    
    private init() {
        do {
          self.realm = try Realm()
        }
        catch {
            print("can not initiate Realm")
        }
    }
    
    func saveObject<T: Persistable>(_ value: T) {
        do {
            try realm?.write({
                realm?.add(value.getManagedObject(), update: .modified)
            })
        }
        catch {
            print("can not write data with Realm")
        }
    }
    
    func getObjects<T: Persistable>(_ type: T.Type, filter: NSPredicate? = nil) -> [T.ManagedObject] {
        if let result = realm?.objects(T.ManagedObject.self) {
            if let filter = filter {
                return Array(result.filter(filter))
            }
            else {
               return Array(result)
            }
        }
        return []
    }

    func deleteObjects<T: Persistable>(_ type: T.Type, filter: NSPredicate? = nil) {
        let objects = getObjects(type, filter: filter)
        do {
            try realm?.write({
                realm?.delete(objects)
            })
        }
        catch {
           print("can not write data with Realm")
        }
    }
}
