//
//  MainPageViewController.swift
//  Anupong
//
//  Created by gone on 25/6/2567 BE.
//

import UIKit
import SDWebImage

class MainPageTableViewController: UITableViewController {
    private var viewModel = MainPageViewModel()
    private let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = AppTheme.mainAppColor
        tableView.register(MainPageCell.self, forCellReuseIdentifier: "mainpageCell")
        
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

        
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainpageCell", for: indexPath) as! MainPageCell
        let articleData = viewModel.isSearching ? viewModel.searchDataArray[indexPath.row] : viewModel.articleListData[indexPath.row]
        cell.customImageView.sd_setImage(with: URL(string: articleData.urlToImage ?? ""))
        cell.titleLabel.text = articleData.title
        cell.descriptionLabel.text = articleData.content
        cell.dateLabel.text  = "Updated : \(articleData.publishedAt.convertToAppDateFormat())"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastElement = viewModel.isSearching ? viewModel.searchDataArray.count - 1 : viewModel.articleListData.count - 1
        if indexPath.row == lastElement && !viewModel.isSearching{
            loadData()
        }
    }
    

}

extension MainPageTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.searchForArticle(searchController.searchBar.text ?? "") { [weak self]  success, result in
            self?.tableView.reloadData()
        }
    }
}


extension MainPageTableViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                let detailVC =  DetailPageViewController()
                let selectedArticle = viewModel.isSearching ? viewModel.searchDataArray[indexPath.row] : viewModel.articleListData[indexPath.row]
                detailVC.article = selectedArticle
                self.navigationController?.pushViewController(detailVC , animated: true)
            
    }
    
}
