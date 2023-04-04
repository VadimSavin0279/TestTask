//
//  CoreDataManager.swift
//  TaskTestFood
//
//  Created by 123 on 04.04.2023.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func getContent() -> Content {
        let fetchReqForContent = ContentForDatabase.fetchRequest()
        var newContent: Content = Content(docs: [])
        do {
            let content = try context.fetch(fetchReqForContent)
            for element in content {
                let docs = Content.Docs(name: element.name ?? "", shortDescription: element.descriptionOfContent, poster: Content.Docs.Poster(url: element.poster?.url ?? ""), type: element.type ?? "")
                newContent.docs.append(docs)
            }
            return newContent
        } catch {
            print(error)
        }
        return newContent
    }
    
    func saveViewModelsOfMovies(model: Content) {
        deleteData()
        for content in model.docs {
            guard let entityForContent = NSEntityDescription.entity(forEntityName: "ContentForDatabase", in: context),
                  let objectForContent = NSManagedObject(entity: entityForContent, insertInto: context) as? ContentForDatabase,
                  let entityForPoster = NSEntityDescription.entity(forEntityName: "PosterOfContent", in: context),
                  let objectForPoster = NSManagedObject(entity: entityForPoster, insertInto: context) as? PosterOfContent else { return }
            objectForContent.name = content.name
            objectForContent.type = content.type
            objectForContent.descriptionOfContent = content.shortDescription
            
            objectForPoster.url = content.poster.url
            objectForContent.poster = objectForPoster
            do {
                try context.save()
            } catch {
                print(error)
            }
        }
    }
    
    
    private func deleteData() {
        let fetchReqForContent = ContentForDatabase.fetchRequest()
        
        do {
            let content = try context.fetch(fetchReqForContent)
            for element in content {
                context.delete(element)
            }
            try context.save()
        } catch {
            print(error)
        }
    }
}
