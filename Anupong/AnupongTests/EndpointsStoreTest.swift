//
//  EndpointsStoreTest.swift
//  AnupongTests
//
//  Created by gone on 25/6/2567 BE.
//

import XCTest
import Moya
@testable import Anupong

class ApiEndPointStoreTests: XCTestCase {

    var apiEndPointStore: ApiEndPointStore!

    override func setUp() {
        super.setUp()
        apiEndPointStore = ApiEndPointStore.shared
    }

    override func tearDown() {
        apiEndPointStore = nil
        super.tearDown()
    }

    func testFindEndpointPath() {
        let mockEndpoint = MockEndpoint()
        let path = apiEndPointStore.find(endpoint: mockEndpoint)
        XCTAssertEqual(path, "v2/top-headlines", "Path for 'newsHeadlines' endpoint should be 'v2/top-headlines'")
    }
}

// MockEndpoint conforms to EndpointProtocol
struct MockEndpoint: AppEndpoints {
    var key: String {
        return "newsHeadlines"
    }
    var method: Moya.Method {
        return .get
    }
}
