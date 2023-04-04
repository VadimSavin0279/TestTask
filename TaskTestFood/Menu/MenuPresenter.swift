//
//  MenuPresenter.swift
//  TaskTestFood
//
//  Created by 123 on 03.04.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol MenuPresentationLogic {
    func presentData(response: Menu.Model.Response.ResponseType)
}

class MenuPresenter: MenuPresentationLogic {
    weak var viewController: MenuDisplayLogic?
    
    func presentData(response: Menu.Model.Response.ResponseType) {
        switch response {
        case .some:
            break
        case .categoryResponse(let indexPath):
            viewController?.displayData(viewModel: .displayCategory(indexPath))
        case .processContent(let content):
            preparationDataForViewController(content: content)
        }
    }
    
    private func preparationDataForViewController(content: Content){
        var arrayOfMovies: [Content.Docs] = []
        var arrayForCountFilmsInCategories: [Int] = []
        var arrayOfCategories: [String] = []
        var dictionaryOfCategory: [String: [Content.Docs]] = [:]
        for movie in content.docs {
            if let _ = dictionaryOfCategory[movie.type] {
                dictionaryOfCategory[movie.type]?.append(movie)
            } else {
                dictionaryOfCategory[movie.type] = [movie]
            }
        }
        
        var count = 0
        for (key, value) in dictionaryOfCategory {
            let character = key.first?.uppercased() ?? ""
            let category = character + key[key.index(after: key.startIndex)...key.index(before: key.endIndex)]
            arrayOfCategories.append(category)
            arrayOfMovies.append(contentsOf: value)
            count += value.count
            arrayForCountFilmsInCategories.append(count)
        }
        
        viewController?.displayData(viewModel: .displayContent(arrayOfCategories,
                                                               arrayOfMovies,
                                                               arrayForCountFilmsInCategories))
    }
    
}
