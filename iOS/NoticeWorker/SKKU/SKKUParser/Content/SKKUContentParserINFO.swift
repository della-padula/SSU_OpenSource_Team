//
//  SKKUContentParserSW.swift
//  NoticeWorker
//
//  Created by 김태인 on 2020/05/15.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation

public class SKKUContentParserINFO: OrganizationContentParser {
    static func parseContentInformation(html: HTMLDocument) -> Result<NoticeContent, HTMLParseError> {
        var attachmentList = [Attachment]()
        for (index, product) in html.css("table[class=list-table table] tr").enumerated() {
            if index > 2 {
                if let fileLink = product.css("td[class=attachment] a").first {
                    let url = "http://icc.skku.ac.kr/icc_new/\(fileLink["href"] ?? "")"
                    let fileName = (fileLink.content ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
                    
                    attachmentList.append(Attachment(fileName: fileName, fileURL: url))
                } else if let contentTd = product.css("td[id=content]").first {
                    // http://icc.skku.ac.kr/icc_new/viewPostPhoto?name=1589331227328_CF6870E395601ED1A8E385B73BF0BAC2.jpg
                    
                    let contentHTML = (contentTd.innerHTML ?? "").replacingOccurrences(of: "src=\"", with: "src=\"http://icc.skku.ac.kr")
                    let detailHTML = generateFilteredDetailHTML(fromHTML: contentHTML)
                    return .success(NoticeContent(content: detailHTML, attachments: attachmentList))
                } else {
                    return .failure(.emptyContent)
                }
            }
        }
        return .failure(.emptyContent)
    }
}
