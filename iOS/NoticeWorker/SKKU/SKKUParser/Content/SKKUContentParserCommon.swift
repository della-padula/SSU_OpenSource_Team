//
//  SKKUContentParserCommon.swift
//  NoticeWorker
//
//  Created by 김태인 on 2020/05/15.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import Kanna

public class SKKUContentParserCommon: OrganizationContentParser {
    static func parseContentSKKU(html: HTMLDocument) -> Result<NoticeContent, HTMLParseError> {
        var attachmentList = [Attachment]()
        
        for product in html.css("ul[class=filedown_list] li") {
            if let fileLink = product.css("a").first {
                // https://www.skku.edu/skku/campus/skk_comm/notice01.do?mode=download&articleNo=81405&attachNo=63488
                let url = "https://www.skku.edu/skku/campus/skk_comm/notice01.do\(fileLink["href"] ?? "")"
                let fileName = (fileLink.content ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
                
                attachmentList.append(Attachment(fileName: fileName, fileURL: url))
            }
        }
        
        if let contentHTML = html.css("dl[class=board-write-box board-write-box-v03]").first {
            let content = (contentHTML.innerHTML ?? "")
            let contentString = generateFilteredDetailHTML(fromHTML: content)
            return .success(NoticeContent(content: contentString, attachments: attachmentList))
        } else {
            return .failure(.emptyContent)
        }
    }
}
