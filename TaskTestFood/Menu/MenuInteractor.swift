//
//  MenuInteractor.swift
//  TaskTestFood
//
//  Created by 123 on 03.04.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol MenuBusinessLogic {
    func makeRequest(request: Menu.Model.Request.RequestType)
}

class MenuInteractor: MenuBusinessLogic {
    
    var presenter: MenuPresentationLogic?
    var service: MenuService?
    
    func makeRequest(request: Menu.Model.Request.RequestType) {
        if service == nil {
            service = MenuService()
        }
        switch request {
        case .some:
            break
        case .newCategoryRequest(let indexPath):
            presenter?.presentData(response: .categoryResponse(indexPath))
        case .contentRequest:
            getData()
        }
    }
    
    private func getData() {
        if NetworkMonitor.shared.isConnected {
            service?.fetchContents(completion: { [self] content in
                presenter?.presentData(response: .processContent(content))
                service?.saveContent(content: content)
            }, completionForError: ({}) )
        } else {
            presenter?.presentData(response: .processContent(service!.fetchContentsFromDataBase()))
        }
    }
}
