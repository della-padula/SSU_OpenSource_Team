//
//  SoongsilContentParserIT.swift
//  NoticeWorker
//
//  Created by denny.k on 2020/05/09.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import Kanna

public class SoongsilContentParserLAW: OrganizationContentParser {
    static func parseContentLAW(html: HTMLDocument) -> Result<NoticeContent, HTMLParseError> {
        let contentHTML = html.css("div[class^='frame-box']").first?.innerHTML ?? ""
        let detailHTML = generateFilteredDetailHTML(fromHTML: contentHTML)
        var attachmentList = [Attachment]()
        
        for link in html.css("table[class='bbs-view'] a") {
            attachmentList.append(Attachment(fileName: link.content ?? "", fileURL: link["href"] ?? ""))
        }
        return .success(NoticeContent(content: detailHTML, attachments: attachmentList))
    }
    
    static func parseContentIntlLAW(html: HTMLDocument) -> Result<NoticeContent, HTMLParseError> {
        let contentHTML = html.css("div[class^='frame-box']").first?.innerHTML ?? ""
        let detailHTML = generateFilteredDetailHTML(fromHTML: contentHTML)
        var attachmentList = [Attachment]()
        
        for link in html.css("table[class='bbs-view'] a") {
            attachmentList.append(Attachment(fileName: link.content ?? "", fileURL: link["href"] ?? ""))
        }
        return .success(NoticeContent(content: detailHTML, attachments: attachmentList))
    }
}
