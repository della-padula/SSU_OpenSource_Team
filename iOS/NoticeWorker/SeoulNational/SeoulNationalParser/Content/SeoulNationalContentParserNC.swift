//
//  SeoulNationalContentParserNC.swift
//  NoticeWorker
//
//  Created by 김태인 on 2020/05/14.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import Kanna

public class SeoulNationalContentParserNC: OrganizationContentParser {
    static func parseContentBiology(html: HTMLDocument) -> Result<NoticeContent, HTMLParseError> {
        // CONTENT
        // div[class=fixwidth bbs_contents]
        
        // ATTACHMENT
        // div[class=att-file] li
        
        var detailHTML: String = ""
        var attachmentList = [Attachment]()
        
        if let contentHTML = html.css("div[class=fixwidth bbs_contents]").first?.innerHTML {
            detailHTML = generateFilteredDetailHTML(fromHTML: contentHTML)
        } else {
            return .failure(.emptyContent)
        }
        
        if let attachmentSection = html.css("div[class=att-file]").first {
            for attachmentItem in attachmentSection.css("li") {
                // http://biosci.snu.ac.kr/board/notice?bm=down&bbsidx=20554&fileidx=23678
                let link = "http://biosci.snu.ac.kr\(attachmentItem.css("a").first?["href"] ?? "")"
                let name = attachmentItem.css("a").first?.content
                
                attachmentList.append(Attachment(fileName: name, fileURL: link))
            }
        }
        
        return .success(NoticeContent(content: detailHTML, attachments: attachmentList))
    }
}
