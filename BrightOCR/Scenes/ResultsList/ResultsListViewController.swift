//
//  ResultsListViewController.swift
//  BrightOCR
//
//  Created by Kamajabu on 19/10/2020.
//

import EasyPeasy

private extension ResultsListViewController {
    struct Const {
        static let addButtonSize = CGSize(width: 120, height: 44)

        static let basicCellIdentifier = "resultsCell"
    }
}

final class ResultsListViewController: UIViewController {
    
    private let viewModel: ResultsListViewModel
    private let tableView = UITableView()
    
    lazy var cameraController = {
        CameraController(controller: self, delegate: self)
    }()
    
    private lazy var addPhotoButton: UIButton = {
        let button = UIButton(frame: CGRect(origin: .zero, size: Const.addButtonSize))
        button.setTitle("ADD", for: .normal)
        
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.setTitleColor(.white, for: .normal)
        
        button.backgroundColor = .red
        button.layer.cornerRadius = 16
        
        button.contentVerticalAlignment = .center
        button.titleLabel?.baselineAdjustment = .alignCenters
        
        button.addTarget(self, action: #selector(addPhoto), for: .touchUpInside)
        
        return button
    }()
    
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
        self.view.addSubview(addPhotoButton)
        self.view.addSubview(tableView)
    }
    
    private func setupLayout() {
        addPhotoButton.easy.layout(CenterX(),
                                   Bottom(20).to(view.safeAreaLayoutGuide, .bottom),
                                   Height(Const.addButtonSize.height),
                                   Width(Const.addButtonSize.width))
        
        tableView.easy.layout(Edges(),
                              Top(20).to(view.safeAreaLayoutGuide, .top),
                              Bottom(20).to(addPhotoButton, .top))
    }
    
    @objc func addPhoto() {
        cameraController.selectSourceAlert()
    }

}

extension ResultsListViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true)
        
        guard let image = info[.originalImage] as? UIImage else {
            // Add logger
            return
        }
        
        viewModel.analyze(image: image) { [weak self] result in
            guard case let .success(model) = result else {
                return
            }
            
            self?.tableView.reloadData()
            
            let viewModel = ResultDetailsViewModel(result: model, image: image)
            let viewController = ResultDetailsViewController(viewModel: viewModel)
            self?.present(viewController, animated: true)
        }
        
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
