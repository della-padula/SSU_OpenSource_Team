//
//  SeoulNationalCommonParser.swift
//  NoticeWorker
//
//  Created by Denny on 2020/05/10.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation

public class SeoulNationalCommonParser: DeptListParser {
    static func parseSeoulNationalList(page: Int, html: String) -> Result<[Notice], HTMLParseError> {
        cleanList()
        
        do {
            let doc = try HTML(html: html, encoding: .utf8)
            for item in doc.css("div[class^='board-list'] tbody tr") {
                for (index, td) in item.css("td").enumerated() {
                    if td.className == "col-title" {
                        if let linkTag = td.css("a").first, let url = linkTag["href"] {
                            //                            https://www.snu.ac.kr/snunow/notice/genernal?md=v&bbsidx=127532
                            urlList.append("https://www.snu.ac.kr\(url)")
                            titleList.append(linkTag.css("span[class^='txt']").first?.content ?? "No Content")
                        }
                        attachmentCheckList.append(false)
                    }
                    
                    if td.className == "col-title file" {
                        if let linkTag = td.css("a").first, let url = linkTag["href"] {
                            //                            https://www.snu.ac.kr/snunow/notice/genernal?md=v&bbsidx=127532
                            urlList.append("https://www.snu.ac.kr\(url)")
                            titleList.append(linkTag.css("span[class^='txt']").first?.content ?? "No Content")
                        }
                        attachmentCheckList.append(true)
                    }
                    
                    if index == 1 {
                        dateStringList.append((td.content ?? "No Date"))
                    }
                }
            }
            
            for (index, _) in titleList.enumerated() {
                var item = Notice(title: titleList[index], url: urlList[index])
                item.author = ""
                item.date = dateStringList[index]
                item.isActive = false
                item.custom = ["hasAttachment" : attachmentCheckList[index]]
                
                noticeList.append(item)
            }
            return .success(noticeList)
        } catch let error {
            print("Error : \(error)")
        }
        return .failure(.emptyContent)
    }
}
