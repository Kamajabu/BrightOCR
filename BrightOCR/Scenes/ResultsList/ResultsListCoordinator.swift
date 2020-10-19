//
//  ResultsListCoordinator.swift
//  BrightOCR
//
//  Created by Kamajabu on 19/10/2020.
//

import UIKit

protocol ResultsListRouter: class {
    func showResult(for result: OCRResultModel)
}

final class ResultsListCoordinator: Coordinator {
    
    private unowned let mainStore: MainStore

    private var resultsListViewController: ResultsListViewController?
    private weak var parentViewController: UINavigationController?

    init(parentViewController: UINavigationController, mainStore: MainStore) {
        self.parentViewController = parentViewController
        self.mainStore = mainStore
    }

    func start() {
        let resultsListViewModel = ResultsListViewModel(store: mainStore)
        let resultsListViewController = ResultsListViewController(viewModel: resultsListViewModel)
        resultsListViewController.title = "OCR Records"
        
        resultsListViewController.router = self
        
        parentViewController?.pushViewController(resultsListViewController, animated: true)
        self.resultsListViewController = resultsListViewController
    }
}

extension ResultsListCoordinator: ResultsListRouter {
    func showResult(for result: OCRResultModel) {
        let viewModel = ResultDetailsViewModel(result: result, mainStore: mainStore)
        let viewController = ResultDetailsViewController(viewModel: viewModel)
        
        parentViewController?.pushViewController(viewController, animated: true)
    }
}
