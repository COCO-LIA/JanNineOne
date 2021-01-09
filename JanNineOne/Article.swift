//
//  Article.swift
//  JanNineOne
//
//  Created by 황현지 on 2021/01/09.
//

import Foundation

struct Article: Codable {
    var author : String? = ""
    var title : String? = ""
    var description : String? = ""
    var urlToImage : String? = ""
    var url : String? = ""


enum CodingKeys: String, CodingKey {
    case author
    case title
    case description
    case urlToImage
    case url
    }

init(from decoder:Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    author = try values.decodeIfPresent(String.self, forKey: .author)
    title = try values.decodeIfPresent(String.self, forKey: .title)
    description = try values.decodeIfPresent(String.self, forKey: .description)
    urlToImage = try values.decodeIfPresent(String.self, forKey: .urlToImage)
    url = try values.decodeIfPresent(String.self, forKey: .url)
    }
}

struct ArticleDataStore: Codable {
    var articles: [Article]
}
