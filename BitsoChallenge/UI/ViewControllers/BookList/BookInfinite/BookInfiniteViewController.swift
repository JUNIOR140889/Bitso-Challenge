//
//  BookInfiniteViewController.swift
//  BitsoChallenge
//
//  Created by Junior Sancho on 3/14/21.
//  Copyright © 2021 Junior Sancho. All rights reserved.
//

import UIKit

final class BookInfiniteViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
            collectionView.register(UINib(nibName: BookCollectionViewCell.className, bundle: nil),
                                    forCellWithReuseIdentifier: BookCollectionViewCell.className)
        }
    }
    
    private var timer: Timer?
    private var counter = 0
    
    let viewModel = BookInfiniteViewModel()
    
    init() {
        super.init(nibName: BookInfiniteViewController.className, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(slideToNext), userInfo: nil, repeats: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBuilding()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
    }

    // MARK: - Private Methods
    @objc private func slideToNext() {
        let index = IndexPath(row: counter, section: 0)
        collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: !(counter == viewModel.books.count
        ))
        counter = counter < viewModel.books.count ? counter + 1 : 0
    }

    private func setupBuilding() {
        viewModel.updateForm = { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}

// MARK: - UICollectionViewDataSource
extension BookInfiniteViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.className, for: indexPath) as? BookCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let bookData = viewModel.getBookData(indexPath)
        cell.setupCell(with: bookData)
        
        return cell
    }
}
