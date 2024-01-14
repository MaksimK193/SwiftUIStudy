//
//  AvatarViewModel.swift
//  SwiftUIStudy
//
//  Created by USER on 12.01.2024.
//

import Foundation
import CoreData
import UIKit

class AvatarViewModel: ObservableObject {
    let coreDataManager = CoreDataManager.shared
    @Published var avatars: [AvatarEntity] = []
    @Published var image: UIImage = UIImage()
    
    init() {
        coreDataManager.setupDataModel(name: .Avatars)
        getEntity()
    }
    
    func getEntity() {
        let request = NSFetchRequest<AvatarEntity>(entityName: "AvatarEntity")
        do {
            avatars = try coreDataManager.context.fetch(request)
        } catch let error {
            print("Error fetching entity: \(error.localizedDescription)")
        }
    }
    
    func reset(entity: String) {
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do {
            try coreDataManager.context.execute(deleteRequest)
            try coreDataManager.context.save()
        } catch {
            print ("There was an error")
        }
    }
    
    func addAvatar(avatar: Data, id: UUID? = UUID()) {
        let newAvatar = AvatarEntity(context: coreDataManager.context)
        newAvatar.id = id
        newAvatar.avatar = avatar
        save()
    }
    
    func delete(_ object: NSManagedObject) {
        coreDataManager.delete(object)
        save()
    }
    
    func save() {
        coreDataManager.save()
        getEntity()
    }
    
    func drawAvatar(hash: Int) {
        let flatArray = Array(String(abs(hash)))
        
        let bitMap = flatArray.flatMap {
            Int(String($0))
        }
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 64, height: 64))
        
        let colors: [CGColor] = [UIColor.red.cgColor, UIColor.blue.cgColor, UIColor.green.cgColor, UIColor.white.cgColor, UIColor.purple.cgColor, UIColor.gray.cgColor, UIColor.cyan.cgColor, UIColor.magenta.cgColor, UIColor.systemPink.cgColor, UIColor.orange.cgColor]

        let rectangles: [CGRect] = [
            CGRect(x: 0, y: 0, width: 16, height: 16), CGRect(x: 16, y: 0, width: 16, height: 16), CGRect(x: 32, y: 0, width: 16, height: 16), CGRect(x: 48, y: 0, width: 16, height: 16),
            CGRect(x: 0, y: 16, width: 16, height: 16), CGRect(x: 16, y: 16, width: 16, height: 16), CGRect(x: 32, y: 16, width: 16, height: 16), CGRect(x: 48, y: 16, width: 16, height: 16),
            CGRect(x: 0, y: 32, width: 16, height: 16), CGRect(x: 16, y: 32, width: 16, height: 16), CGRect(x: 32, y: 32, width: 16, height: 16), CGRect(x: 48, y: 32, width: 16, height: 16),
            CGRect(x: 0, y: 48, width: 16, height: 16), CGRect(x: 16, y: 48, width: 16, height: 16), CGRect(x: 32, y: 48, width: 16, height: 16), CGRect(x: 48, y: 48, width: 16, height: 16),
        ]
        
        let img = renderer.image { ctx in
            for (index, value) in rectangles.enumerated() {
                let rectangle = value
                ctx.cgContext.setFillColor(colors[bitMap[index]])
                ctx.cgContext.addRect(rectangle)
                ctx.cgContext.drawPath(using: .fill)
            }
        }

        image = img
        guard let data = img.pngData() else { return }
        addAvatar(avatar: data)
    }
}

