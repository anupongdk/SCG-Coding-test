//
//  Endpoints.swift
//  Anupong
//
//  Created by gone on 25/6/2567 BE.
//

import Foundation
import Moya

struct EndpointStore: Codable {
    var name: String
    var path: String
}

protocol EndpointProtocol: TargetType {
    associatedtype R
    var key: R { get }
    var method: Moya.Method { get }
}

protocol AppEndpoints: EndpointProtocol {}

struct ApiEndPointStore {
    private var _allEndpoints: [EndpointStore]?

    static let shared = ApiEndPointStore()

    init() {
        let decoder = PropertyListDecoder()
        guard let plistUrl = R.file.endpointsPlist() else {
            return
        }
        let data = try? Data(contentsOf: plistUrl)
        _allEndpoints = try? decoder.decode([EndpointStore].self, from: data!)
    }

    func find(endpoint: some EndpointProtocol) -> String {
        _allEndpoints?.filter { $0.name == endpoint.key as! String }.first?.path ?? ""
    }
}

extension AppEndpoints {
    var key: String {
        ""
    }
    var method: Moya.Method {
        .get
    }

    var baseURL: URL {
        try! AppInfo.main.appApi.asURL()
    }

    var path: String {
        ApiEndPointStore.shared.find(endpoint: self)
    }

    var task: Task {
        .requestPlain
    }

    var headers: [String: String]? {
        ["content-type": "application/json",
        "X-Api-Key": "2635e42d51de48c88924b1f741d45011"]
    }
}


enum Endpoints {
    
    enum News: AppEndpoints {
        typealias R = String
        case NewsList([String: Any])
 
      
        var path: String {
            let path = ApiEndPointStore.shared.find(endpoint: self)
            switch self {
            default:
                return path
            }
        }

        var key: String {
            switch self {
            case .NewsList: return "newsHeadlines"
            }
        }

        var method: Moya.Method {
            .get
        }

        var task: Task {
            switch self {
            case .NewsList(let req):
                return .requestParameters(parameters: req, encoding: URLEncoding.queryString)
            default:
                return .requestPlain
            }
        }
    }
}
