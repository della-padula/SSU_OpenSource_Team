//
//  SeoulNationalContentParserSC.swift
//  NoticeWorker
//
//  Created by 김태인 on 2020/05/14.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import Kanna

public class SeoulNationalContentParserSC: OrganizationContentParser {
    static func parseContentEconomics(html: HTMLDocument) -> Result<NoticeContent, HTMLParseError> {
        var detailHTML: String = ""
        var attachmentList = [Attachment]()
        
        if let contentHTML = html.css("div[class=bbs_contents]").first?.innerHTML {
            detailHTML = generateFilteredDetailHTML(fromHTML: contentHTML)
        } else {
            return .failure(.emptyContent)
        }
        
        if let attachmentSection = html.css("div[class=att-file]").first {
            for attachmentItem in attachmentSection.css("li") {
                let link = "http://econ.snu.ac.kr\(attachmentItem.css("a").first?["href"] ?? "")"
                let name = attachmentItem.css("a").first?.content
                
                attachmentList.append(Attachment(fileName: name, fileURL: link))
            }
        }
        
        return .success(NoticeContent(content: detailHTML, attachments: attachmentList))
    }
    
    static func parseContentAnthropology(html: HTMLDocument) -> Result<NoticeContent, HTMLParseError> {
        var detailHTML: String = ""
        var attachmentList = [Attachment]()
        
        if let contentTable = html.css("table[class=board_view]").first, let content = contentTable.css("div[id=content]").first?.innerHTML {
            detailHTML = generateFilteredDetailHTML(fromHTML: content)
        } else {
            return .failure(.emptyContent)
        }
        
        if let attachmentSection = html.css("div[class=attachment]").first {
            for attachmentItem in attachmentSection.css("li") {
                let link = "http://anthropology.or.kr/04_notice/notice01.htm\(attachmentItem.css("a").first?["href"] ?? "")"
                let name = attachmentItem.css("a").first?.content
                
                attachmentList.append(Attachment(fileName: name, fileURL: link))
            }
        }
        
        return .success(NoticeContent(content: detailHTML, attachments: attachmentList))
    }
}
