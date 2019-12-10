//
//  Student+CoreDataProperties.swift
//  CoredataApp
//
//  Created by Brahmastra on 09/12/19.
//  Copyright © 2019 Brahmastra. All rights reserved.
//
//

import Foundation
import CoreData


extension Student {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Student> {
        return NSFetchRequest<Student>(entityName: "Student")
    }

    @NSManaged public var address: String?
    @NSManaged public var city: String?
    @NSManaged public var mobile: String?
    @NSManaged public var name: String?

}
