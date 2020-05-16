//
//  SoongsilParserIT.swift
//  NoticeWorker
//
//  Created by Denny on 2020/04/30.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation

public class SoongsilITParser: DeptListParser {
    static func parseCSEList(page: Int, html: String) -> Result<[Notice], HTMLParseError> {
        var index = 0
        cleanList()
        do {
            let doc = try HTML(html: html, encoding: .utf8)
            for product in doc.xpath("//table/tbody/tr/*") {
                if product.nextSibling?.className ?? "" == "center" {
                    let noticeAuthor = product.nextSibling?.text ?? ""
                    let noticeDate = product.nextSibling?.nextSibling?.text ?? ""
                    let pageString = product.at_xpath("a")?["href"] ?? ""
                    
                    if !pageString.isEmpty {
                        switch index % 2 {
                        case 0:
                            // Attachment
                            var hasAttachment = false
                            if let inner = product.innerHTML {
                                if inner.contains("ico_file_chk.gif") {
                                    // Attachment
                                    hasAttachment = true
                                }
                            }
                            attachmentCheckList.append(hasAttachment)
                            
                            // Title & Author
                            let noticeTitle = product.content ?? ""
                            authorList.append(noticeAuthor)
                            titleList.append(noticeTitle)
                            urlList.append("http://cse.ssu.ac.kr/03_sub/01_sub.htm\(pageString)")
                            dateStringList.append(noticeDate)
                            isNoticeList.append(false)
                            break;
                        case 1:  break;
                        default: break
                        }
                    }
                    index += 1
                    
                } else if product.nextSibling?.className ?? "" == "etc" {
                    // 첫 페이지만 보여주기
                    
                    if page < 2 {
                        let noticeAuthor = product.nextSibling?.text ?? ""
                        let noticeDate = product.nextSibling?.nextSibling?.text ?? ""
                        let pageString = product.css("a").first?["href"] ?? ""
                        
                        if !pageString.isEmpty {
                            //http://cse.ssu.ac.kr/03_sub/01_sub.htm
                            
                            switch index % 2 {
                            case 0:
                                // Attachment
                                var hasAttachment = false
                                if let inner = product.innerHTML {
                                    if inner.contains("ico_file_chk.gif") {
                                        // Attachment
                                        hasAttachment = true
                                    }
                                }
                                attachmentCheckList.append(hasAttachment)
                                
                                let noticeTitle = product.content ?? ""
                                authorList.append(noticeAuthor)
                                titleList.append(noticeTitle)
                                urlList.append("http://cse.ssu.ac.kr/03_sub/01_sub.htm\(pageString)")
                                dateStringList.append(noticeDate)
                                isNoticeList.append(true)
                                break;
                            case 1: break;
                            default: break
                            }
                        }
                        index += 1
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
    
    static func parseMediaList(page: Int, html: String) -> Result<[Notice], HTMLParseError> {
        var index = 0
        cleanList()
        do {
            let doc = try HTML(html: html, encoding: .utf8)
            for product in doc.css("table tbody tr a") {
                let noticeId = product["onclick"]?.getArrayAfterRegex(regex: "['](.*?)[']")[0] ?? ""
                let url = "http://media.ssu.ac.kr/sub.php?code=XxH00AXY&mode=view&board_num=\(noticeId)&category=1"
                urlList.append(url)
                titleList.append(product.content ?? "")
            }
            
            index = 0
            for product in doc.css("td[align='center']") {
                if index % 4 == 0 {
                    let isNotice = product.text ?? ""
                    if !isNotice.isNumeric() {
                        isNoticeList.append(true)
                    } else {
                        isNoticeList.append(false)
                    }
                }
                
                if index % 4 == 1 {
                    authorList.append(product.content ?? "")
                } else if index % 4 == 2 {
                    dateStringList.append(product.content ?? "")
                }
                index += 1
            }
            
            index = 0
            
            for _ in authorList {
                var item = Notice(title: titleList[index], url: urlList[index])
                item.author = authorList[index]
                item.date = dateStringList[index]
                item.isActive = isNoticeList[index]
                
                noticeList.append(item)
                index += 1
            }
            return .success(noticeList)
        } catch let error {
            print("Error : \(error)")
        }
        return .failure(.emptyContent)
    }
    
    static func parseSmartSWList(page: Int, html: String) -> Result<[Notice], HTMLParseError> {
        var index = 0
        cleanList()
        do {
            let doc = try HTML(html: html, encoding: .utf8)
            
            for product in doc.css("table[class='ui celled padded table'] tbody td") {
                let content = (product.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
                switch(index % 4) {
                case 0:
                    //title
                    titleList.append(content)
                    break
                case 1:
                    //author
                    authorList.append(content)
                    break
                case 2:
                    //date
                    dateStringList.append(content)
                    break
                default: break
                }
                
                if let url = product.css("a").first {
                    let realUrl = "http://smartsw.ssu.ac.kr\(url["href"] ?? "")"
                    urlList.append(realUrl)
                }
                
                index += 1
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
    
    static func parseSWList(page: Int, html: String) -> Result<[Notice], HTMLParseError> {
        var index = 0
        cleanList()
        
        do {
            let doc = try HTML(html: html, encoding: .utf8)
            for product in doc.css("td[class^=num]") {
                let num = product.css("b").first?.text ?? ""
                
                if num.isEmpty {
                    // isNotice
                    isNoticeList.append(false)
                } else {
                    isNoticeList.append(true)
                }
            }
            
            for product in doc.css("td[class^=subject]") {
                var hasAttachment = false
                for image in product.css("img") {
                    hasAttachment = (image["src"] ?? "").contains("icon_file.gif")
                }
                attachmentCheckList.append(hasAttachment)
            }
            
            for product in doc.css("td[class^=subject] a") {
                var url = product["href"] ?? ""
                url = url.replacingOccurrences(of: "..", with: "https://sw.ssu.ac.kr")
                titleList.append(product.text ?? "")
                urlList.append(url)
            }
            
            for product in doc.css("td[class^=datetime]") {
                dateStringList.append(product.text ?? "")
            }
            
            for product in doc.css("td[class^=name]") {
                authorList.append(product.text ?? "")
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
    
    static func parseElecList(page: Int, html: String) -> Result<[Notice], HTMLParseError> {
        var index = 0
        cleanList()
        
        do {
            let doc = try HTML(html: html, encoding: .utf8)
            for product in doc.css("div[class^='list']") {
                let url = "http://infocom.ssu.ac.kr\((product.toHTML?.getArrayAfterRegex(regex: "(?=')\\S+(?=')")[0].split(separator: "'")[0] ?? "")!.replacingOccurrences(of: "&amp;", with: "&"))"
                
                // Attachment
                var hasAttachment = false
                if let imgSrc = product.css("div[class^='info'] img").first?["src"] {
                    if imgSrc.contains("ico_file.gif") {
                        hasAttachment = true
                    }
                }
                attachmentCheckList.append(hasAttachment)
                
                let strs = (product.css("div[class^='info']").first?.text ?? "")!.split(separator: "|")
                
                urlList.append(url)
                authorList.append(strs[0].trimmingCharacters(in: .whitespacesAndNewlines))
                dateStringList.append(strs[1].trimmingCharacters(in: .whitespacesAndNewlines))
                
                if product.css("span[class^='subject']").first!.text == "" {
                    titleList.append("(제목없음)")
                } else {
                    titleList.append(product.css("span[class^='subject']").first!.text!)
                }
                
                if product.innerHTML?.contains("img") ?? false {
                    // isNotice
                    isNoticeList.append(true)
                } else {
                    isNoticeList.append(false)
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
