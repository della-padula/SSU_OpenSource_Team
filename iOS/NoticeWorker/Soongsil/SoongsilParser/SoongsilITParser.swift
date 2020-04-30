//
//  SoongsilParserIT.swift
//  NoticeWorker
//
//  Created by Denny on 2020/04/30.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import Kanna

public class SoongsilITParser {
    private static var noticeList = [Notice]()
    private static var authorList = [String]()
    private static var titleList  = [String]()
    private static var pageStringList = [String]()
    private static var dateStringList = [String]()
    private static var isNoticeList = [Bool]()
    private static var urlList    = [String]()
    private static var attachmentCheckList = [Bool]()
    
    static func cleanList() {
        noticeList.removeAll()
        authorList.removeAll()
        titleList.removeAll()
        pageStringList.removeAll()
        dateStringList.removeAll()
        isNoticeList.removeAll()
        urlList.removeAll()
        attachmentCheckList.removeAll()
    }
    
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
//                item.custom = ["hasAttachment" : attachmentCheckList[index]]
                
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
        return .failure(.emptyContent)
    }
    
    static func parseSWList(page: Int, html: String) -> Result<[Notice], HTMLParseError> {
        var index = 0
        return .failure(.emptyContent)
    }
    
    static func parseElecList(page: Int, html: String) -> Result<[Notice], HTMLParseError> {
        var index = 0
        return .failure(.emptyContent)
    }
}