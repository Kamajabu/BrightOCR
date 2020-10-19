//
//  ResultDetailsViewController.swift
//  BrightOCR
//
//  Created by Kamajabu on 19/10/2020.
//

import EasyPeasy

private extension ResultDetailsViewController {
    struct Const {
        static let defaultMargin: CGFloat = 20
    }
}

final class ResultDetailsViewController: UIViewController {
    
    private let viewModel: ResultDetailsViewModel
    
    private let inputImage: UIImageView = {
        let image = UIImageView(image: UIImage())
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let titleDateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.sizeToFit()
        return label
    }()
    
    private let resultTextView: UITextView = {
        let textView = UITextView()
        textView.textAlignment = .justified
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addSubviews()
        setupLayout()
    }
    
    init(viewModel: ResultDetailsViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)

        titleDateLabel.text = DateFormatter.localizedString(from: viewModel.result.createdOn, dateStyle: .full, timeStyle: .medium)
        inputImage.image = viewModel.image

        resultTextView.text = viewModel.result.ocrText

    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        view.addSubview(titleDateLabel)
        view.addSubview(resultTextView)
        view.addSubview(inputImage)
    }
    
    private func setupLayout() {
        titleDateLabel.easy.layout(Left(Const.defaultMargin),
                                   Right(Const.defaultMargin),
                                   Top(Const.defaultMargin).to(view.safeAreaLayoutGuide, .top))
        
        resultTextView.easy.layout(Bottom(Const.defaultMargin).to(view.safeAreaLayoutGuide, .bottom),
                                   Left(Const.defaultMargin), Right(Const.defaultMargin),
                                   Height(0.4*view.frame.height))

        inputImage.easy.layout(Left(Const.defaultMargin),
                               Right(Const.defaultMargin),
                               Top(Const.defaultMargin).to(titleDateLabel, .bottom),
                               Bottom(Const.defaultMargin).to(resultTextView, .top))
    }

}
