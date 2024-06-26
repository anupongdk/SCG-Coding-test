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
        request["country"] = "us"
        
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
    
    
    func searchForArticle(_ searchText: String, completion: @escaping (Bool, String?) -> Void) {
            guard !isLoading else {
                completion(false, "Loading in progress")
                return
            }
            
            isLoading = true
            if searchText.isEmpty {
                isSearching = false
                searchDataArray.removeAll()
                isLoading = false
                completion(true, nil)
                return
            }
            
            let pageSize = 20
            var request: [String: Any] = [
                "pageSize": pageSize,
                "page": searchDataArray.count / pageSize,
                "q": searchText
            ]
            
            newsService.getNewsListData(request: request) { [weak self] result in
                self?.isLoading = false
                switch result {
                case .success(let response):
                    self?.isSearching = true
                    self?.searchDataArray = response.articles
                    completion(true, nil)
                case .failure(let error):
                    print("Error: \(error)")
                    completion(false, error.localizedDescription)
                }
            }
        }
}
