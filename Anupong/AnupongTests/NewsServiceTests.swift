//
//  NewsServiceTests.swift
//  AnupongTests
//
//  Created by gone on 26/6/2567 BE.
//

import XCTest
@testable import Anupong

class MainPageViewModelTests: XCTestCase {
    var viewModel: MainPageViewModel!
    var mockService: MockNewsService!
    
    override func setUp() {
        super.setUp()
        mockService = MockNewsService()
        viewModel = MainPageViewModel(newsService: mockService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockService = nil
        super.tearDown()
    }
    
    func testLoadDataSuccess() {
        let expectation = self.expectation(description: "Data loaded successfully")
        
        viewModel.loadData { success, errorMessage in
            XCTAssertTrue(success)
            XCTAssertNil(errorMessage)
            XCTAssertEqual(self.viewModel.articleListData.count, 1)
            XCTAssertEqual(self.viewModel.articleListData.first?.title, "test title")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testLoadDataFailure() {
        let expectation = self.expectation(description: "Data loading failed")
        
        mockService.shouldReturnError = true
        
        viewModel.loadData { success, errorMessage in
            XCTAssertFalse(success)
            XCTAssertNotNil(errorMessage)
            XCTAssertEqual(self.viewModel.articleListData.count, 0)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testSearchForArticle() {
        
    }
}


class MockNewsService: NewsServiceProtocol {
    var shouldReturnError = false
    var articles = [Article(source: Source(id: "test source id",
                                           name: "test source name"),
                            author: "test author",
                            title: "test title",
                            description: "test desc",
                            url: "test url",
                            urlToImage: "www.google.com",
                            publishedAt: Date(),
                            content: "test content")]
    
    func getNewsListData(request: [String: Any], onComplete: @escaping NewsListCallback) {
            if shouldReturnError {
                let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Mock error"])
                onComplete(.failure(error))
            } else {
                let mockResponse = NewsListResponse(status: "ok", totalResults: 1, articles: articles)
                onComplete(.success(mockResponse))
            }
        }
}

