//
//  SKKUListParserCommon.swift
//  NoticeWorker
//
//  Created by 김태인 on 2020/05/15.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import Kanna

public class SKKUListParserCommon: DeptListParser {
    static func parseSKKUList(page: Int, html: String) -> Result<[Notice], HTMLParseError> {
        cleanList()
        // table class = board_list
        
        do {
            let doc = try HTML(html: html, encoding: .utf8)
            for product in doc.css("table[class^='board_list'] tr") {
                for (index, td) in product.css("td").enumerated() {
                    switch index {
                    case 0:
                        break
                    case 1:
                        // Title
                        if let titleLink = td.css("a").first {
                            let url = titleLink["href"]
                            let title = (titleLink.content ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
                            
                            titleList.append(title)
                            urlList.append(url ?? "")
                        } else {
                            return .failure(.emptyContent)
                        }
                    case 2:
                        // Date
                        dateStringList.append((td.content ?? "").trimmingCharacters(in: .whitespacesAndNewlines))
                    case 3:
                        break
                    case 4:
                        if let _ = td.css("div[class^='file_downWrap']").first {
                            attachmentCheckList.append(true)
                        } else {
                            attachmentCheckList.append(false)
                        }
                    default:
                        break
                    }
                }
            }
            
            for (index, title) in titleList.enumerated() {
                var item = Notice(title: title, url: urlList[index])
                item.author = "(No AUTHOR)"
                item.date = dateStringList[index]
                item.isActive = false
                item.custom = ["hasAttachment": attachmentCheckList[index]]
                noticeList.append(item)
            }
            return .success(noticeList)
        } catch {
            return .failure(.encoding)
        }
    }
}
