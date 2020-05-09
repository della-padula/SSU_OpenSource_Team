//
//  SoongsilContentParserIT.swift
//  NoticeWorker
//
//  Created by 김태인 on 2020/05/06.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import Kanna

public class SoongsilContentParserIT: OrganizationContentParser {
    static func parseContentCSE(html: HTMLDocument) -> Result<NoticeContent, HTMLParseError> {
        let contentHTML = html.css("td[class=content]").first?.innerHTML ?? ""
        
        let detailHTML = generateFilteredDetailHTML(fromHTML: contentHTML)
        var attachmentList = [Attachment]()
        
        let attachmentHTML = html.xpath("//span[@class='file']/a")
        var attachmentNames = Array<XMLElement>()
        attachmentNames.append(contentsOf: attachmentHTML.reversed())
        
        for name in attachmentNames {
            let fileUrl = "http://cse.ssu.ac.kr\(name["href"] ?? "")"
            let fileName = name.content
            
            if !(name["href"] ?? "").isEmpty {
                attachmentList.append(Attachment(fileName: fileName!, fileURL: fileUrl))
            }
        }
        return .success(NoticeContent(content: detailHTML, attachments: attachmentList))
    }
    
    static func parseContentMedia(html: HTMLDocument) -> Result<NoticeContent, HTMLParseError> {
        let contentHTML = html.css("td[class^='s_default_view_body_2']").first?.innerHTML ?? ""
        var detailHTML = generateFilteredDetailHTML(fromHTML: contentHTML)
        let host = "http://media.ssu.ac.kr"
        detailHTML = detailHTML.replacingOccurrences(of: "src=\"/", with: "src=\"\(host )/")
        
        let mediaUrl = "http://media.ssu.ac.kr/"
        var attachmentList = [Attachment]()
        
        for link in html.css("td[width^=480] a") {
            let url = "\(mediaUrl)\(link["href"] ?? "")"
            print("media : \(url)")
            attachmentList.append(Attachment(fileName: link.text ?? "", fileURL: url))
        }
        
        return .success(NoticeContent(content: detailHTML, attachments: attachmentList))
    }
    
    static func parseContentElectric(html: HTMLDocument) -> Result<NoticeContent, HTMLParseError> {
        let contentHTML = html.css("div[class^='content']").first?.innerHTML ?? ""
        
        let detailHTML = generateFilteredDetailHTML(fromHTML: contentHTML)
        
        let attachments = html.css("div[class^='attach'] a")
        var attachmentList = [Attachment]()
        for attachment in attachments {
            let fileUrl = "http://infocom.ssu.ac.kr\(attachment["href"]!)"
            attachmentList.append(Attachment(fileName: attachment.text!, fileURL: fileUrl))
        }
        return .success(NoticeContent(content: detailHTML, attachments: attachmentList))
    }
    
    static func parseContentSoftware(html: HTMLDocument) -> Result<NoticeContent, HTMLParseError> {
        let contentHTML = html.css("div[class^='bo_view_2']").first?.innerHTML ?? ""
        //        let downloadUrl = "https://sw.ssu.ac.kr/bbs/download.php?bo_table=sub6_1&wr_id=1023&no=1"
        let detailHTML = generateFilteredDetailHTML(fromHTML: contentHTML)
        var attachmentList = [Attachment]()
        
        var index = 0
        for link in html.css("div[class^='bo_view_1'] a") {
            let url = link["href"]?.getArrayAfterRegex(regex: "[=](.*?)[&]")[1] ?? ""
            let fileName = link["href"]?.getArrayAfterRegex(regex: "['](.*?)[']")[1].decodeUrl() ?? ""
            let wr_id = url.replacingOccurrences(of: "&", with: "").replacingOccurrences(of: "=", with: "")
            
            let realUrl = "https://sw.ssu.ac.kr/bbs/download.php?bo_table=sub6_1&wr_id=\(wr_id)&no=\(index)"
            attachmentList.append(Attachment(fileName: fileName.replacingOccurrences(of: "'", with: ""), fileURL: realUrl))
            index += 1
        }
        
        return .success(NoticeContent(content: detailHTML, attachments: attachmentList))
    }
    
    static func parseContentSmartSW(html: HTMLDocument) -> Result<NoticeContent, HTMLParseError> {
        return .failure(.notSupported)
    }
}
