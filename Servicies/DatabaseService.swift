//
//  DatabaseService.swift
//  WeatherApp
//
//  Created by Art on 13.09.2021.
//

import RealmSwift

protocol DatabaseService {
    func save<T: Object> (_ items: [T]) throws -> Realm
    func get<T: Object, KeyType> (_ type: T.Type, primaryKey: KeyType) throws -> T?
    func get<T: Object> (_ type: T.Type) throws -> Results<T>
    func delete<T: Object>(_ item: T) throws
}

class DatabaseServiceImpl: DatabaseService {
    
    func save<T: Object> (_ items: [T]) throws -> Realm {
        let realm = try Realm(configuration: .defaultConfiguration)
        try realm.write{
            realm.add(items)
        }
        return realm
    }
    
    func get<T: Object, KeyType> (_ type: T.Type, primaryKey: KeyType) throws -> T? {
        let realm = try Realm()
        return realm.object(ofType: type, forPrimaryKey: primaryKey)
    }
    
    func get<T: Object> (_ type: T.Type) throws -> Results<T> {
        let realm = try Realm()
        return realm.objects(type)
    }
    
    func delete<T: Object>(_ item: T) throws {
        let realm = try Realm()
        try realm.write {
            realm.delete(item)
        }
    }
}
