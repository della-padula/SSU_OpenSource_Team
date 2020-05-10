//
//  SeoulNationalENGParser.swift
//  NoticeWorker
//
//  Created by Denny on 2020/05/10.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import Kanna

public class SeoulNationalENGParser: DeptListParser {
    static func parseCSEList(page: Int, html: String) -> Result<[Notice], HTMLParseError> {
        cleanList()
        do {
            let doc = try HTML(html: html, encoding: .utf8)
            for product in doc.css("div[class^='view-content'] tbody tr") {
//                print("Row Start")
                for (index, td) in product.css("td").enumerated() {
                    if let linkTag = td.css("a").first, let url = linkTag["href"] {
//                        print("https://cse.snu.ac.kr\(url)")
//                        print(linkTag.content)
                        
                        urlList.append("https://cse.snu.ac.kr\(url)")
                        titleList.append(linkTag.content ?? "No Content")
                    }
                    
                    if index == 1 {
//                        print(td.content)
                        dateStringList.append((td.content ?? "No Date").trimmingCharacters(in: .whitespacesAndNewlines))
                    }
                }
            }
            
            for (index, title) in titleList.enumerated() {
                var item = Notice(title: title, url: urlList[index])
                item.author = ""
                item.date = dateStringList[index]
                item.isActive = false
                print("Row [\(index)]\n\(item.date)\n\(item.title)\n\(item.url)")
                noticeList.append(item)
            }
            
            return .success(noticeList)
        } catch let error {
            print("Error : \(error)")
        }
        return .failure(.emptyContent)
    }
}
