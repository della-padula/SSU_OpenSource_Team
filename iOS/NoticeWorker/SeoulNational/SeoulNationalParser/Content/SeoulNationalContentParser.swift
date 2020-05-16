//
//  SeoulNationalContentParser.swift
//  NoticeWorker
//
//  Created by 김태인 on 2020/05/14.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation

public class SeoulNationalContentParser: OrganizationContentParser {
    static func parseContentSchool(html: HTMLDocument) -> Result<NoticeContent, HTMLParseError> {
        // CONTENT
        // div[class=content]
        
        // ATTACHMENT
        // div[class=download] a
        
        var detailHTML: String = ""
        var attachmentList = [Attachment]()
        
        if let contentHTML = html.css("div[class=content]").first?.innerHTML {
            detailHTML = generateFilteredDetailHTML(fromHTML: contentHTML)
        } else {
            return .failure(.emptyContent)
        }
        
        for attachmentItem in html.css("div[class=download] a") {
            // https://www.snu.ac.kr/snunow/notice/genernal?md=down&bbsidx=127378&fileidx=13508
            let link = "https://www.snu.ac.kr\(attachmentItem["href"] ?? "")"
            let name = attachmentItem.content
            
            attachmentList.append(Attachment(fileName: name, fileURL: link))
        }
        
        return .success(NoticeContent(content: detailHTML, attachments: attachmentList))
    }
}
