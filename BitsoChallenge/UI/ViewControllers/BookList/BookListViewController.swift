//
//  BookListViewController.swift
//  BitsoChallenge
//
//  Created by Junior Sancho on 3/13/21.
//  Copyright © 2021 Junior Sancho. All rights reserved.
//

import UIKit

final class BookListViewController: UIViewController, LoadingProtocol {    
    @IBOutlet private weak var headerView: UIView!
    @IBOutlet private weak var bookListTableView: UITableView! {
        didSet {
            bookListTableView.delegate = self
            bookListTableView.dataSource = self
            bookListTableView.register(UINib(nibName: BookTableViewCell.className, bundle: nil),
                                       forCellReuseIdentifier: BookTableViewCell.className)
        }
    }
    
    private let viewModel = BookListViewModel()
    private let refreshControl = UIRefreshControl()
    
    var loadingView = LoadingView()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    private lazy var presentationManager = SlidePresentationManager()
    
    private lazy var headerViewController: HeaderViewController = {
        return HeaderViewController()
    }()
    
    private lazy var bookInfiniteViewController: BookInfiniteViewController = {
        return BookInfiniteViewController()
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRefreshControl()
        setupTitleHeaderView()
        getAvailableBooks(true)
        Timer.scheduledTimer(withTimeInterval: 30, repeats: true) { timer in
            self.getAvailableBooks()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    // MARK: - Private Methods
    private func setupRefreshControl() {
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(self.getAvailableBooks(_:)), for: .valueChanged)
        bookListTableView.addSubview(refreshControl)
    }

    @objc private func getAvailableBooks(_ showLoading: Bool = false) {
        if showLoading { startLoading() }
        viewModel.getAvailableBooks { [weak self] books in
            guard let self = self else { return }
            self.bookListTableView.reloadData()
            self.stopLoading()
            self.refreshControl.endRefreshing()
            self.bookInfiniteViewController.viewModel.books = books
        }
    }
    
    private func setupTitleHeaderView() {
        bookInfiniteViewController.remove()
        add(headerViewController, into: headerView)
    }
    
    private func setupCollectionHeaderView() {
        headerViewController.remove()
        add(bookInfiniteViewController, into: headerView)
    }
}

// MARK: - UITableViewDelegate
extension BookListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let bookDetailViewModel = BookDetailViewModel(book: viewModel.getBookData(indexPath))
        let bookDetailViewController = BookDetailViewController(viewModel: bookDetailViewModel)
        bookDetailViewController.delegate = self
        bookDetailViewController.transitioningDelegate = presentationManager
        bookDetailViewController.modalPresentationStyle = .custom
        
        present(bookDetailViewController, animated: true) { [weak self] in
            self?.setupCollectionHeaderView()
        }
    }
}

// MARK: - UITableViewDataSource
extension BookListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.availableBooks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BookTableViewCell.className) as? BookTableViewCell else {
            return UITableViewCell()
        }

        let cellDataSource = viewModel.getBookData(indexPath)
        cell.setupCell(with: cellDataSource)
    
        return cell
    }
}

// MARK: - BookDetailProtocol
extension BookListViewController: BookDetailProtocol {
    func closeButtonTapped() {
        setupTitleHeaderView()
    }
}
