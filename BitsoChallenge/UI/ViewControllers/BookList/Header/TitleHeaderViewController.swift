//
//  HeaderViewController.swift
//  BitsoChallenge
//
//  Created by Junior Sancho on 3/14/21.
//  Copyright © 2021 Junior Sancho. All rights reserved.
//

import UIKit

class HeaderViewController: UIViewController {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    
    let viewModel = TitleHeaderViewModel()
    
    init() {
        super.init(nibName: HeaderViewController.className, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupVC()
    }
    
    // MARK: - Private
    private func setupVC() {
        titleLabel.text = "Available Books"
        subtitleLabel.text = viewModel.currentDate
    }
}
