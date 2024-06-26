//
//  NewServices.swift
//  Anupong
//
//  Created by gone on 25/6/2567 BE.
//

import Foundation
import Moya


protocol NewsServiceProtocol {
    typealias NewsListCallback = (Result<NewsListResponse, Error>) -> Void
    func getNewsListData(request: [String: Any], onComplete: @escaping NewsListCallback)
}

class NewsServices: NewsServiceProtocol {
    
    static var provider: MoyaProvider<Endpoints.News> {
        MoyaProvider<Endpoints.News>()
    }
    
    func getNewsListData(request:[String :Any] ,onComplete: @escaping NewsListCallback) {
       
        NewsServices.provider.request(.NewsList(request), completion: { result in
            switch result {
            case let .success(response):
                do {
                    let result = try JSONDecoder().decode(NewsListResponse.self, from: response.data)
                    onComplete(.success(result))
                    
                } catch {
                  onComplete(.failure(error))
                }
            case let .failure(error):
                onComplete(.failure(error))
            }
        })
    }
    
}


protocol ServiceError: Error {
    var description: String { get }
    var field: ServiceErrorField { get }
}
indirect enum ServiceErrorField: Hashable {
    case unknow
}
