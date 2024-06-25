//
//  EndpointsTest.swift
//  AnupongTests
//
//  Created by gone on 25/6/2567 BE.
//

import XCTest
import Moya
@testable import Anupong

class EndpointsTests: XCTestCase {

    func testNewsListEndpoint() {
        let parameters: [String: Any] = ["country": "th"]
        let newsListEndpoint = Endpoints.News.NewsList(parameters)
        
        XCTAssertEqual(newsListEndpoint.key, "newsHeadlines", "Key for NewsList should be 'newsHeadlines'")
        XCTAssertEqual(newsListEndpoint.method, .get, "Method for newsHeadlines should be GET")
        
        if case let .requestParameters(parameters: params, encoding: encoding) = newsListEndpoint.task {
            XCTAssertEqual(params["country"] as? String, "th", "Parameter 'country' should be 'th'")
            XCTAssertTrue(encoding is URLEncoding, "Encoding should be URLEncoding")
        } else {
            XCTFail("Task should be requestParameters with correct parameters and encoding")
        }
    }
}
