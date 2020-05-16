//
//  SKKUListParserSW.swift
//  NoticeWorker
//
//  Created by 김태인 on 2020/05/15.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation

public class SKKUListINFOParser: DeptListParser {
    static func parseInformationList(page: Int, html: String) -> Result<[Notice], HTMLParseError> {
        cleanList()
        do {
            let doc = try HTML(html: html, encoding: .utf8)
            for (index, product) in doc.css("div[class^='list-table-div'] tr").enumerated() {
                if index > 0 {
                    for (index, tdItem) in product.css("td").enumerated() {
                        switch index % 6 {
                        case 0:
                            break
                        case 1:
                            break
                        case 2:
                            if let titleLink = tdItem.css("a").first {
                                let url = "http://icc.skku.ac.kr/icc_new/\(titleLink["href"] ?? "")"
                                let title = (titleLink.content ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
                                
                                titleList.append(title)
                                urlList.append(url)
                            } else {
                                return .failure(.emptyContent)
                            }
                        case 3:
                            let author = tdItem.content ?? "NO AUTHOR"
                            authorList.append(author.trimmingCharacters(in: .whitespacesAndNewlines))
                        case 4:
                            let date = tdItem.content ?? "NO DATE"
                            dateStringList.append(date.trimmingCharacters(in: .whitespacesAndNewlines))
                        case 5:
                            break
                        default:
                            break
                        }
                    }
                }
            }
            
            for (index, title) in titleList.enumerated() {
                var item = Notice(title: title, url: urlList[index])
                item.author = authorList[index]
                item.date = dateStringList[index]
                item.isActive = false
                noticeList.append(item)
            }
            return .success(noticeList)
        } catch let error {
            return .failure(.encoding)
        }
    }
}
