//
//  NewsResponseDataModel.swift
//  Anupong
//
//  Created by gone on 25/6/2567 BE.
//

import Foundation
import OptionallyDecodable

// MARK: - NewsListResponse
struct NewsListResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

// MARK: - Article
struct Article: Codable {
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
}

// MARK: - Source
struct Source: Codable {
    let id: String?
    let name: String
}
