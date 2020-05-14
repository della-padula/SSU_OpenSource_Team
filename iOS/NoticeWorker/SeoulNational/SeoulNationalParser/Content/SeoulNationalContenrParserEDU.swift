//
//  SeoulNationalContenrParserEDU.swift
//  NoticeWorker
//
//  Created by 김태인 on 2020/05/14.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import Kanna

public class SeoulNationalContentParserEDU: OrganizationContentParser {
    static func parseContentMath(html: HTMLDocument) -> Result<NoticeContent, HTMLParseError> {
        // CONTENT
        // div[class=postArea]
        
        // ATTACHMENT
        // ITERATION : li[class=custom_file]
        
        var detailHTML: String = ""
        var attachmentList = [Attachment]()
        
        if let contentHTML = html.css("div[class=postArea]").first?.innerHTML {
            detailHTML = generateFilteredDetailHTML(fromHTML: contentHTML)
        } else {
            return .failure(.emptyContent)
        }
        
        for attachmentItem in html.css("li[class=custom_file]") {
            // http://mathed.snu.ac.kr/board/notice/view/2690/download/4426
            let link = "http://mathed.snu.ac.kr\(attachmentItem.css("a").first?["href"] ?? "")"
            let name = attachmentItem.css("a").first?.content
            
            attachmentList.append(Attachment(fileName: name, fileURL: link))
        }
        
        return .success(NoticeContent(content: detailHTML, attachments: attachmentList))
    }
}
