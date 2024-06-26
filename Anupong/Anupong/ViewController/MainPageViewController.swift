//
//  MainPageViewController.swift
//  Anupong
//
//  Created by gone on 25/6/2567 BE.
//

import UIKit

class MainPageTableViewController: UITableViewController {
    private var viewModel = MainPageViewModel()
    private let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        viewModel = MainPageViewModel(newsService: NewsServices())
        loadData()
    }
    
    func loadData() {
        viewModel.loadData { [weak self] success, result  in
            if success {
                self?.tableView.reloadData()
            } else {
                // Should show popup
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.isSearching ? viewModel.searchDataArray.count : viewModel.articleListData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastElement = viewModel.isSearching ? viewModel.searchDataArray.count - 1 : viewModel.articleListData.count - 1
        if indexPath.row == lastElement && !viewModel.isSearching{
            loadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let selectedArticle = viewModel.isSearching ? viewModel.searchDataArray[indexPath.row] : viewModel.articleListData[indexPath.row]
        

    }
}

extension MainPageTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.searchForArticle(searchController.searchBar.text ?? "")
        tableView.reloadData()
    }
}