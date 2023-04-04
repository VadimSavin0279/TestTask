//
//  MenuModels.swift
//  TaskTestFood
//
//  Created by 123 on 03.04.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum Menu {
    enum Model {
        struct Request {
            enum RequestType {
                case some
                case newCategoryRequest(IndexPath)
                case contentRequest
            }
        }
        struct Response {
            enum ResponseType {
                case some
                case categoryResponse(IndexPath)
                case processContent(Content)
            }
        }
        struct ViewModel {
            enum ViewModelData {
                case some
                case displayCategory(IndexPath)
                case displayContent([String], [Content.Docs], [Int])
            }
        }
    }
}

struct MenuViewModel {
    var selectedCell = IndexPath(row: 0, section: 0)
    var arrayOfCategories: [String]
    var arrayOfMovies: [Content.Docs]
    var arrayForCountFilmsInCategories: [Int]
}
