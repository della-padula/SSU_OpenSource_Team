//
//  SeoulNationalContentParserENG.swift
//  NoticeWorker
//
//  Created by Denny on 2020/05/10.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation

public class SeoulNationalContentParserENG: OrganizationContentParser {
    static func parseContentCSE(html: HTMLDocument) -> Result<NoticeContent, HTMLParseError> {
        var attachmentList = [Attachment]()
        if let attachmentSection = html.css("div[class=field field-name-field-attachment field-type-file field-label-hidden]").first {
            for attachmentRow in attachmentSection.css("table[class=sticky-enabled tableheader-processed sticky-table] tbody tr") {
                if let fileLink = attachmentRow.css("span[class=file] a").first {
                    let url = fileLink["href"]
                    let fileName = fileLink.content
                    
                    attachmentList.append(Attachment(fileName: fileName, fileURL: url))
                }
            }
        }
        
        if let contentSection = html.css("div[class=field field-name-body field-type-text-with-summary field-label-hidden]").first {
            let contentHTML = contentSection.css("div[class=field-items]").first?.innerHTML ?? ""
            let detailHTML = generateFilteredDetailHTML(fromHTML: contentHTML)
            
            return .success(NoticeContent(content: detailHTML, attachments: attachmentList))
        } else {
            return .failure(.emptyContent)
        }
    }
}
