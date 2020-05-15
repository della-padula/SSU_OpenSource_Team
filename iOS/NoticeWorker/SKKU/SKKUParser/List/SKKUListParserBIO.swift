//
//  SKKUListParserBIO.swift
//  NoticeWorker
//
//  Created by 김태인 on 2020/05/15.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import Kanna

public class SKKUListBIOParser: DeptListParser {
    static func parseBioMecaList(page: Int, html: String) -> Result<[Notice], HTMLParseError> {
        cleanList()
        do {
            let doc = try HTML(html: html, encoding: .utf8)
            for product in doc.css("div[class^='board-name-list board-wrap'] li") {
                if let titleLink = product.css("dt[class^='board-list-content-title'] a").first {
                    let url = titleLink["href"]
                    let title = titleLink.content
                    
                    titleList.append(title ?? "")
                    urlList.append(url ?? "")
                }
                
                for (index, contentItem) in product.css("dd[class^='board-list-content-info'] li").enumerated() {
                    switch index {
                    case 0:
                        break
                    case 1:
                        // author
                        authorList.append(contentItem.content ?? "NO AUTHOR")
                    case 2:
                        // date
                        dateStringList.append(contentItem.content ?? "NO DATE")
                    case 3:
                        break
                    default:
                        break
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
        } catch {
            return .failure(.encoding)
        }
    }
}
