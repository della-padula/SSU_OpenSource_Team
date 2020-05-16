//
//  SeoulNationalNCParser.swift
//  NoticeWorker
//
//  Created by Denny on 2020/05/10.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation

public class SeoulNationalNCParser: DeptListParser {
    static func parseBiologyList(page: Int, html: String) -> Result<[Notice], HTMLParseError> {
        cleanList()
        do {
            let doc = try HTML(html: html, encoding: .utf8)
            for product in doc.css("div[id^='zcmsprogram'] tbody tr") {
                isNoticeList.append(product.className == "noti")
                
                for (index, td) in product.css("td").enumerated() {
                    if index == 0 {
                        isNoticeList.append(td.className == "noti-ico")
                    }
                    
                    if index == 2 {
                        // Title
                        if let linkTag = td.css("a").first, let url = linkTag["href"] {
//                            http://biosci.snu.ac.kr/board/notice?bm=v&bbsidx=20550&page=1
                            urlList.append("http://biosci.snu.ac.kr\(url)")
                            titleList.append(linkTag.content ?? "No Content")
                        }
                    }
                    
                    if index == 3 {
                        authorList.append(td.content ?? "No Author")
                    }
                    
                    if index == 4 {
                        // Date
                        print(td.content)
                        dateStringList.append((td.content ?? "No Date").trimmingCharacters(in: .whitespacesAndNewlines))
                    }
                }
            }
            
            for (index, title) in titleList.enumerated() {
                var item = Notice(title: title, url: urlList[index])
                item.author = authorList[index]
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
