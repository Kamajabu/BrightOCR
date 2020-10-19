//
//  ResultsListViewController.swift
//  BrightOCR
//
//  Created by Kamajabu on 19/10/2020.
//

import UIKit

class ResultsListViewController: UIViewController {
    
    private let viewModel: ResultsListViewModel

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    init(viewModel: ResultsListViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
