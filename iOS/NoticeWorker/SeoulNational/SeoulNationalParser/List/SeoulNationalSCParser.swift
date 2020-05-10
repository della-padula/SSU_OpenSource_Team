//
//  SeoulNationalSCParser.swift
//  NoticeWorker
//
//  Created by Denny on 2020/05/10.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import Kanna

public class SeoulNationalSCParser: DeptListParser {
    static func parseEconomicsList(page: Int, html: String) -> Result<[Notice], HTMLParseError> {
        cleanList()
        do {
            let doc = try HTML(html: html, encoding: .utf8)
            for product in doc.css("div[id^='zcmsprogram'] tbody tr") {
                isNoticeList.append(product.className == "noti")
                
                for (index, td) in product.css("td").enumerated() {
                    if index == 2 {
                        // Title
                        if let linkTag = td.css("a").first, let url = linkTag["href"] {
//                            http://econ.snu.ac.kr/announcement/notice?bm=v&bbsidx=6439&page=1
                            urlList.append("http://econ.snu.ac.kr\(url)")
                            titleList.append(linkTag.content ?? "No Content")
                        }
                    }
                    
                    if index == 3 {
                        // Date
                        print(td.content)
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
    
    static func parseAnthropologyList(page: Int, html: String) -> Result<[Notice], HTMLParseError> {
            cleanList()
            do {
                let doc = try HTML(html: html, encoding: .utf8)
                for (index, product) in doc.css("ul[class^='board_list'] li").enumerated() {
                    if index > 0 {
                        for div in product.css("div") {
                            switch div.className {
                            case "no":
                                isNoticeList.append((div.innerHTML ?? "").contains("img"))
                                case "title":
                                    if let linkTag = div.css("a").first {
                                        titleList.append(linkTag.content ?? "No Title")
                                        
                                        if let urlTag = linkTag["href"] {
                                            let url = "http://anthropology.or.kr/04_notice/notice01.htm\(urlTag)"
                                            urlList.append(url)
                                        } else {
                                            urlList.append("No URL")
                                        }
                                    }
                                case "name":
                                    authorList.append(div.content ?? "No Author")
                                case "date":
                                    dateStringList.append((div.content ?? "No Date").trimmingCharacters(in: .whitespacesAndNewlines))
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

