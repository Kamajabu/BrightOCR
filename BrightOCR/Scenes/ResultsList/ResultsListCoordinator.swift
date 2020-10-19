//
//  ResultsListCoordinator.swift
//  BrightOCR
//
//  Created by Kamajabu on 19/10/2020.
//

import UIKit

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
        
        parentViewController?.pushViewController(resultsListViewController, animated: true)
        self.resultsListViewController = resultsListViewController
    }
}
