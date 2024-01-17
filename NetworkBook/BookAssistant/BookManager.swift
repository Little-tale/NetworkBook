//
//  BookManager.swift
//  NetworkBook
//
//  Created by Jae hyung Kim on 1/17/24.
//

import UIKit
import Alamofire


enum Url {
    static let Book = "https://dapi.kakao.com/v3/search/book?query="
}

struct BookModeler {
    func requste(complite: @escaping ([Document]) -> (), text : String){
        // query필요함
        
        let bookQuery = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        // print(bookQuery)
        
        let header: HTTPHeaders = [
            "Authorization": APIKEY.Authorization
        ]
        let url = Url.Book + bookQuery! + "&20"
        //print(url)
        
        AF.request(url, method: .get, headers: header).responseDecodable(of: Book.self) {
            response in
            switch response.result {
            case .success(let success):
                // print(success)
                complite(success.documents)
                
            case .failure(let failure):
                dump(failure)
            }
        }
    }
}



struct Book: Codable {
    let documents: [Document]
    let meta: Meta
}

// MARK: - Document
struct Document: Codable {
    let authors: [String]
    let contents, datetime, isbn: String
    let price: Int
    let publisher: String
    let salePrice: Int
    let status: String
    let thumbnail: String?
    let title: String
    // let translators: [String?]
    // let url: String

    enum CodingKeys: String, CodingKey {
        case authors, contents, datetime, isbn, price, publisher
        case salePrice = "sale_price"
        case status, thumbnail, title// url //translators
    }
}



//enum Status: String, Codable {
//    case empty = ""
//    case 예약판매 = "예약판매"
//    case 정상판매 = "정상판매"
//}

// MARK: - Meta
struct Meta: Codable {
    let isEnd: Bool
    let pageableCount, totalCount: Int

    enum CodingKeys: String, CodingKey {
        case isEnd = "is_end"
        case pageableCount = "pageable_count"
        case totalCount = "total_count"
    }
}


//
//// MARK: - Book
//struct Book: Codable {
//    let documents: [Document]
//    let meta: Meta
//}
//
//// MARK: - Document
//struct Document: Codable {
//    let authors: [String]
//    let contents, datetime, isbn: String
//    let price: Int
//    let publisher: String
//    let salePrice: Int
//    let status: Status
//    let thumbnail: String
//    let title: String
//    let translators: [String]
//    let url: String
//
//    enum CodingKeys: String, CodingKey {
//        case authors, contents, datetime, isbn, price, publisher
//        case salePrice = "sale_price"
//        case status, thumbnail, title, translators, url
//    }
//}
//
//enum Status: String, Codable {
//    case empty = ""
//    case 정상판매 = "정상판매"
//}
//
//// MARK: - Meta
//struct Meta: Codable {
//    let isEnd: Bool
//    let pageableCount, totalCount: Int
//
//    enum CodingKeys: String, CodingKey {
//        case isEnd = "is_end"
//        case pageableCount = "pageable_count"
//        case totalCount = "total_count"
//    }
//}
