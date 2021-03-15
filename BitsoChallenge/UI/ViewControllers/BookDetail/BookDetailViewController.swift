//
//  BookDetailViewController.swift
//  BitsoChallenge
//
//  Created by Junior Sancho on 3/13/21.
//  Copyright © 2021 Junior Sancho. All rights reserved.
//

import UIKit
import AAInfographics

protocol BookDetailProtocol: AnyObject {
    func closeButtonTapped()
}

final class BookDetailViewController: UIViewController, LoadingProtocol {
    @IBOutlet private weak var bookTitleLabel: UILabel!
    @IBOutlet private weak var bidLabel: UILabel!
    @IBOutlet private weak var askLabel: UILabel!
    @IBOutlet private weak var lowLabel: UILabel!
    @IBOutlet private weak var highLabel: UILabel!
    @IBOutlet private weak var volumeLabel: UILabel!
    @IBOutlet private weak var spreadLabel: UILabel!
    @IBOutlet private weak var timeSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var chartContainerView: UIView!
    
    private lazy var chartView: AAChartView = {
        let aaChartView = AAChartView()
        aaChartView.frame = chartContainerView.bounds
        chartContainerView.addSubview(aaChartView)
        
        return aaChartView
    }()
    
    weak var delegate: BookDetailProtocol?
    var loadingView: LoadingView = LoadingView()
    
    let viewModel: BookDetailViewModel
    
    init(viewModel: BookDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: BookDetailViewController.className, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBookDetails()
        setupChartView(.oneMonth)
    }
    
    // MARK: - Private
    private func setupBookDetails() {
        guard let bookDetails = viewModel.book.bookDetails else { return }
        bookTitleLabel.text = viewModel.book.book
        bidLabel.text = bookDetails.bid
        askLabel.text = bookDetails.ask
        lowLabel.text = bookDetails.low
        highLabel.text = bookDetails.high
        volumeLabel.text = bookDetails.volume
        spreadLabel.text = bookDetails.spread
    }
    
    private func setupChartView(_ time: ChartDataTime) {
        viewModel.getChartData(time) { [weak self] chartModel in
            guard let chartModel = chartModel else { return }
            self?.chartView.aa_drawChartWithChartModel(chartModel)
        }
    }
    
    // MARK: - Actions
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        delegate?.closeButtonTapped()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func segmentedControlTapped(_ sender: UISegmentedControl) {
        guard let chartTime = ChartDataTime(rawValue: sender.selectedSegmentIndex) else { return }
        setupChartView(chartTime)
    }
}
