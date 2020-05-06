//
//  SoongsilContentParserIT.swift
//  NoticeWorker
//
//  Created by 김태인 on 2020/05/06.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation

public class SoongsilContentParserIT: OrganizationContentParser {
    static func parseContentCSE(html: String) -> Result<NoticeContent, HTMLParseError> {
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
    
    static func parseContentMedia(html: String) -> Result<NoticeContent, HTMLParseError> {
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
    
    static func parseContentElectric(html: String) -> Result<NoticeContent, HTMLParseError> {
        return .failure(.emptyContent)
    }
    
    static func parseContentSoftware(html: String) -> Result<NoticeContent, HTMLParseError> {
        return .failure(.emptyContent)
    }
    
    static func parseContentSmartSW(html: String) -> Result<NoticeContent, HTMLParseError> {
        return .failure(.emptyContent)
    }
}
