//
//  MainPageViewModel.swift
//  Anupong
//
//  Created by gone on 25/6/2567 BE.
//

import Foundation

class MainPageViewModel {
    
    private var newsService: NewsServiceProtocol
    private var isLoading = false
    
    var isSearching = false
    var articleListData = [Article]()
    var searchDataArray = [Article]()
    
    init(newsService: NewsServiceProtocol = NewsServices()) {
        self.newsService = newsService
    }
    
    func loadData(completion: @escaping (Bool, String?) -> Void) {
        
        guard !isLoading else {
            completion(false, "Loading in progress")
            return
        }
        
        isLoading = true
        let pageSize = 20
        
        var request: [String: Any] = [:]
        request["pageSize"] = pageSize
        request["page"] = articleListData.count / pageSize
        
        newsService.getNewsListData(request: request) { [weak self] result in
            self?.isLoading = false
            switch result {
            case .success(let response):
                self?.articleListData.append(contentsOf: response.articles)
                completion(true, nil)
            case .failure(let error):
                print("Error: \(error)")
                completion(false, error.localizedDescription)
            }
        }
    }
    
    func searchForArticle(_ searchText: String) {
        isSearching = !searchText.isEmpty
        if isSearching {
            // reload search data
        } else {
            searchDataArray.removeAll()
        }
    }
}
