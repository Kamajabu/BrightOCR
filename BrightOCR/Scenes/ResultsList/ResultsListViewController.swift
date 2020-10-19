//
//  ResultsListViewController.swift
//  BrightOCR
//
//  Created by Kamajabu on 19/10/2020.
//

import EasyPeasy

private extension ResultsListViewController {
    struct Const {
        static let basicCellIdentifier = "resultsCell"
    }
}

final class ResultsListViewController: UIViewController {
    
    private let viewModel: ResultsListViewModel
    
    private let tableView = UITableView()
    
    init(viewModel: ResultsListViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
