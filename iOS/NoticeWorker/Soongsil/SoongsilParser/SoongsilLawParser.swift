//
//  SoongsilLawParser.swift
//  NoticeWorker
//
//  Created by Denny on 2020/04/30.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import Kanna

public class SoongsilLawParser: SoongsilDeptParser {
    static func parseLAWList(page: Int, html: String) -> Result<[Notice], HTMLParseError> {
        var index = 0
        cleanList()
        
        do {
            let doc = try HTML(html: html, encoding: .utf8)
            for product in doc.css("table[class='bbs-list']") {
                var isAppendNotice = false
                var title = ""
                var date = ""
                var url = ""
                var isNotice = false
                var hasAttachment = false
                
                for (index, td) in product.css("td").enumerated() {
                    let content = td.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                    
                    switch (index % 5) {
                    case 0:
                        isAppendNotice = false
                        if td.innerHTML?.contains("img") ?? false {
                            isNotice = true
                            if page < 2 {
                                isAppendNotice = true
                            }
                        } else {
                            isNotice = false
                            isAppendNotice = true
                        }
                        
                        if isAppendNotice {
                            isNoticeList.append(isNotice)
                        }
                    case 1:
                        title = content
                        url = td.css("a").first?["href"] ?? ""
                        
                        if isAppendNotice {
                            titleList.append(title)
                            urlList.append(url)
                        }
                    case 2:
                        hasAttachment = false
                        let imgHTML = td.toHTML ?? ""
                        if imgHTML.contains("ico_file.gif") {
                            hasAttachment = true
                        }
                        
                        if isAppendNotice {
                            attachmentCheckList.append(hasAttachment)
                        }
                    case 3:
                        date = content
                        if isAppendNotice {
                            authorList.append("")
                            dateStringList.append(date)
                        }
                    case 4: break
                    default: break
                    }
                }
            }
            
            index = 0
            
            for _ in authorList {
                var item = Notice(title: titleList[index], url: urlList[index])
                item.author = ""
                item.date = dateStringList[index]
                item.isActive = isNoticeList[index]
                item.custom = ["hasAttachment" : attachmentCheckList[index]]
                
                noticeList.append(item)
                index += 1
            }
            return .success(noticeList)
        } catch let error {
            print("Error : \(error)")
        }
        return .failure(.emptyContent)
    }
    
    static func parseINTLAWList(page: Int, html: String) -> Result<[Notice], HTMLParseError> {
        var index = 0
        cleanList()
        
        do {
            let doc = try HTML(html: html, encoding: .utf8)
            for product in doc.css("table[class='bbs-list']") {
                var isAppendNotice = false
                var title = ""
                var author = ""
                var date = ""
                var url = ""
                var isNotice = false
                var hasAttachment = false
                
                for (index, td) in product.css("td").enumerated() {
                    let content = td.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                    
                    switch (index % 6) {
                    case 0:
                        isAppendNotice = false
                        if td.innerHTML?.contains("img") ?? false {
                            isNotice = true
                            if page < 2 {
                                isAppendNotice = true
                            }
                        } else {
                            isNotice = false
                            isAppendNotice = true
                        }
                        
                        if isAppendNotice {
                            isNoticeList.append(isNotice)
                        }
                    case 1:
                        title = content
                        url = td.css("a").first?["href"] ?? ""
                        
                        if isAppendNotice {
                            titleList.append(title)
                            urlList.append(url)
                        }
                    case 2:
                        hasAttachment = false
                        let imgHTML = td.toHTML ?? ""
                        if imgHTML.contains("ico_file.gif") {
                            hasAttachment = true
                        }
                        
                        if isAppendNotice {
                            attachmentCheckList.append(hasAttachment)
                        }
                    case 3:
                        author = content
                        if isAppendNotice {
                            authorList.append(author)
                        }
                    case 4:
                        date = content
                        if isAppendNotice {
                            dateStringList.append(date)
                        }
                    default: break
                    }
                }
            }
            
            index = 0
            
            for _ in authorList {
                var item = Notice(title: titleList[index], url: urlList[index])
                item.author = authorList[index]
                item.date = dateStringList[index]
                item.isActive = isNoticeList[index]
                item.custom = ["hasAttachment" : attachmentCheckList[index]]
                
                noticeList.append(item)
                index += 1
            }
            return .success(noticeList)
        } catch let error {
            print("Error : \(error)")
        }
        return .failure(.emptyContent)
    }
}
