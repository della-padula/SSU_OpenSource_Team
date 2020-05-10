//
//  SeoulNationalCommonParser.swift
//  NoticeWorker
//
//  Created by Denny on 2020/05/10.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import Kanna

public class SeoulNationalCommonParser: DeptListParser {
    static func parseSeoulNationalList(page: Int, html: String) -> Result<[Notice], HTMLParseError> {
        var index = 0
        cleanList()
        
        do {
            let doc = try HTML(html: html, encoding: .utf8)
            var currentDate = ""
            for item in doc.css("ul[class^='notice-lists'] li") {
                if item.className == "start" {
                    currentDate = ""
                    for date in item.css("div[class^='h2 text-info font-weight-bold']") {
                        if currentDate.isEmpty {
                            currentDate.append((date.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines))
                        } else {
                            currentDate.append(".\(date.text ?? "")".trimmingCharacters(in: .whitespacesAndNewlines))
                        }
                    }
                }
                
                if item.className != "notice_head" {
                    titleList.append(item.css("span[class^='d-inline-blcok m-pt-5']").first?.text ?? "")
                    dateStringList.append(currentDate)
                    print(item.css("div[class^='notice_col3-lg-8'] a").first?["href"] ?? "")
                    urlList.append(item.css("div[class^='notice_col3'] a").first?["href"] ?? "")
                    authorList.append(item.css("div[class^='col-lg-2 m-text-right']").first?.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "")
                }
            }
            
            index = 0
            
            for _ in authorList {
                var item = Notice(title: titleList[index], url: urlList[index])
                item.author = authorList[index]
                item.date = dateStringList[index]
                item.isActive = false
                
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
