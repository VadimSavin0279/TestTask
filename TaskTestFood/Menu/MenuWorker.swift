//
//  MenuWorker.swift
//  TaskTestFood
//
//  Created by 123 on 03.04.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum Result<T: Codable> {
    case success(T)
    case failure(Error)
}

class MenuService {
    private let coreDataManager = CoreDataManager()
    private let manager = APIManager()
    func fetchContents(completion: @escaping (Content) -> (),
                       completionForError: @escaping () -> Void) {
        manager.sendRequest(with: MenuProvider.getFilm, decodeType: Content.self) { response in
            switch response {
            case .success(let result):
                completion(result)
            case .failure(let error):
                print(error)
                completionForError()
            }
        }
    }
    
    func fetchContentsFromDataBase() -> Content {
        coreDataManager.getContent()
    }
    
    func saveContent(content: Content) {
        coreDataManager.saveViewModelsOfMovies(model: content)
    }
}
