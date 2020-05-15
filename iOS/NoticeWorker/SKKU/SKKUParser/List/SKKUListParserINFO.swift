//
//  SKKUListParserSW.swift
//  NoticeWorker
//
//  Created by 김태인 on 2020/05/15.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import Kanna

public class SKKUINFOParser: DeptListParser {
    static func parseInformationList(page: Int, html: String) -> Result<[Notice], HTMLParseError> {
        cleanList()
        do {
            let doc = try HTML(html: html, encoding: .utf8)
            for (index, product) in doc.css("div[class^='list-table-div'] tbody td").enumerated() {
                switch index % 6 {
                case 0:
                    break
                case 1:
                    break
                case 2:
                    if let titleLink = product.css("a").first {
                        let url = titleLink["href"]
                        let title = titleLink.content
                        
                        titleList.append(title ?? "")
                        urlList.append(url ?? "")
                    }
                case 3:
                    let author = product.content ?? ""
                    authorList.append(author)
                case 4:
                    let date = product.content ?? ""
                    dateStringList.append(date)
                case 5:
                    break
                default:
                    break
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
        return .failure(.emptyContent)
    }
}
