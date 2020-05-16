//
//  SKKUContentParserEDU.swift
//  NoticeWorker
//
//  Created by 김태인 on 2020/05/15.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation

public class SKKUContentParserEDU: OrganizationContentParser {
    static func parseContentComputer(html: HTMLDocument) -> Result<NoticeContent, HTMLParseError> {
        var attachmentList = [Attachment]()
        
        for product in html.css("ul[class=board-view-file-wrap] li") {
            if let fileLink = product.css("a").first {
                // https://comedu.skku.edu/comedu/notice.do?mode=view&articleNo=96526&article.offset=0&articleLimit=10
                let url = "https://comedu.skku.edu/comedu/notice.do\(fileLink["href"] ?? "")"
                let fileName = (fileLink.content ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
                
                attachmentList.append(Attachment(fileName: fileName, fileURL: url))
            }
        }
        
        if let contentHTML = html.css("div[class=board-view-content-wrap board-view-txt]").first {
            let content = (contentHTML.innerHTML ?? "")
            let contentString = generateFilteredDetailHTML(fromHTML: content)
            return .success(NoticeContent(content: contentString, attachments: attachmentList))
        } else {
            return .failure(.emptyContent)
        }
    }
}
