//
//  SeoulNationalEDUParser.swift
//  NoticeWorker
//
//  Created by Denny on 2020/05/10.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation

public class SeoulNationalEDUParser: DeptListParser {
    static func parseMathList(page: Int, html: String) -> Result<[Notice], HTMLParseError> {
        cleanList()
        do {
            let doc = try HTML(html: html, encoding: .utf8)
            for product in doc.css("table[class^='lc01'] tbody tr") {
                for (index, td) in product.css("td").enumerated() {
                    if index == 0 {
                        if let content = td.content?.trimmingCharacters(in: .whitespacesAndNewlines) {
                            isNoticeList.append(!content.isNumber)
                        } else {
                            isNoticeList.append(false)
                        }
                    }
                    
                    if index == 1 {
                        if let linkTag = td.css("a").first, let url = linkTag["href"] {
//                            http://mathed.snu.ac.kr/board/notice/view/2693
                            urlList.append("http://mathed.snu.ac.kr\(url)")
                            titleList.append((linkTag.content ?? "No Content").trimmingCharacters(in: .whitespacesAndNewlines))
                        }
                    }
                    
                    if index == 3 {
                        if let date = td.content {
                            dateStringList.append(date.trimmingCharacters(in: .whitespacesAndNewlines))
                        } else {
                            dateStringList.append("No Date")
                        }
                    }
                }
            }
            
            for (index, title) in titleList.enumerated() {
                var item = Notice(title: title, url: urlList[index])
                item.author = ""
                item.date = dateStringList[index]
                item.isActive = isNoticeList[index]
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

