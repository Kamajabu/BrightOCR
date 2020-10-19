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
        static let addButtonBorderColor = UIColor.adaptedColor(light: UIColor.prussianBlue, dark: .white)
        static let defaultMargin: CGFloat = 20
        
        static let basicCellIdentifier = "resultsCell"
    }
}

final class ResultsListViewController: UIViewController {
    
    weak var router: ResultsListRouter?
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.selectRow(at: nil, animated: false, scrollPosition: .none)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        precondition(router != nil, "Router must be assigned.")
        
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
                                   Bottom(Const.defaultMargin).to(view.safeAreaLayoutGuide, .bottom),
                                   Height(Const.addButtonSize.height),
                                   Width(Const.addButtonSize.width))
        
        tableView.easy.layout(Edges(),
                              Top(Const.defaultMargin).to(view.safeAreaLayoutGuide, .top),
                              Bottom(Const.defaultMargin).to(addPhotoButton, .top))
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
            self?.router?.showResult(for: model)
        }
        
    }
}

extension ResultsListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.resultsHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle,
                                   reuseIdentifier: Const.basicCellIdentifier)
        
        guard let historyRecord = viewModel.historyRecord(for: indexPath.row) else {
            return cell
        }
        
        cell.textLabel?.text = DateFormatter.localizedString(from: historyRecord.createdOn, dateStyle: .medium, timeStyle: .medium)
        
        cell.detailTextLabel?.text = historyRecord.ocrText
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedIndex = indexPath.row
        
        guard let historyRecord = viewModel.historyRecord(for: selectedIndex) else {
            return
        }
        
        router?.showResult(for: historyRecord)
    }
    
}
