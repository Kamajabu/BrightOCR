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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        setupLayout()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func addSubviews() {
        self.view.addSubview(tableView)
    }
    
    private func setupLayout() {
        tableView.easy.layout(Edges())
    }

}

extension ResultsListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.resultsMockData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle,
                                   reuseIdentifier: Const.basicCellIdentifier)
        
        let historyRecord = viewModel.resultsMockData[indexPath.row]
        
        cell.textLabel?.text = DateFormatter.localizedString(from: historyRecord.createdOn, dateStyle: .medium, timeStyle: .medium)
        
        cell.detailTextLabel?.text = historyRecord.ocrResult
        
        return cell
    }
    
}
