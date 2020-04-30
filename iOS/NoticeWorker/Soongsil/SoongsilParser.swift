//
//  SoongsilParser.swift
//  NoticeWorker
//
//  Created by 김태인 on 2020/04/25.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import Kanna

typealias Action = (Result<[Notice], HTMLParseError>) -> Void

public class SoongsilParser: OrganizationParserProtocol {
    public var deptItem: DeptItem
    
    required public init(deptItem: DeptItem) {
        self.deptItem = deptItem
    }
    
    func getNoticeList(page: Int, html: String) -> Result<[Notice], HTMLParseError> {
        return SoongsilITParser.parseCSEList(page: page, html: html)
    }
    
    func getAttachmentList(completion: @escaping (Result<[Attachment], HTMLParseError>) -> Void) {
        completion(.failure(.emptyContent))
    }
    
    func getNoticeContent(completion: @escaping (Result<NoticeContent, HTMLParseError>) -> Void) {
        completion(.failure(.emptyContent))
    }
    
}

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
                            pageStringList.append("http://cse.ssu.ac.kr/03_sub/01_sub.htm\(pageString)")
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
                                pageStringList.append("http://cse.ssu.ac.kr/03_sub/01_sub.htm\(pageString)")
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
                var item = Notice(title: titleList[index], url: pageStringList[index])
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
    
    static func parseMedia(page: Int, html: String, completion: @escaping (Result<NoticeContent, HTMLParseError>) -> Void) {
        completion(.failure(.emptyContent))
    }
    
    static func parseSmart(page: Int, html: String, completion: @escaping (Result<NoticeContent, HTMLParseError>) -> Void) {
        completion(.failure(.emptyContent))
    }
    
    static func parseSW(page: Int, html: String, completion: @escaping (Result<NoticeContent, HTMLParseError>) -> Void) {
        completion(.failure(.emptyContent))
    }
    
    static func parseElec(page: Int, html: String, completion: @escaping (Result<NoticeContent, HTMLParseError>) -> Void) {
        completion(.failure(.emptyContent))
    }
}
