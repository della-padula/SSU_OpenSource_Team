//
//  SKKUParser.swift
//  NoticeWorker
//
//  Created by 김태인 on 2020/05/15.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import Kanna

public class SKKUParser: OrganizationParserProtocol {
    public var deptItem: DeptItem
    
    required public init(deptItem: DeptItem) {
        self.deptItem = deptItem
    }
    
    func getNoticeList(page: Int, html: String) -> Result<[Notice], HTMLParseError> {
        return parseNoticeList(dept: deptItem, page: page, html: html)
    }
    
    func getAttachmentList(html: String) -> Result<[Attachment], HTMLParseError> {
        let content = parseNoticeContent(dept: deptItem, html: html)
        
        switch content {
        case .success(let item):
            return .success(item.attachments)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func getNoticeContent(html: String) -> Result<NoticeContent, HTMLParseError> {
        return parseNoticeContent(dept: deptItem, html: html)
    }
    
}

extension SKKUParser {
    private func parseNoticeList(dept: DeptItem, page: Int, html: String) -> Result<[Notice], HTMLParseError> {
        switch dept {
        case SKKUDept.INFO_Information:
            return SeoulNationalENGParser.parseCSEList(page: page, html: html)
        case SKKUDept.BIO_BioMeca:
            return SeoulNationalEDUParser.parseMathList(page: page, html: html)
        case SKKUDept.EDU_Computer:
            return SeoulNationalNCParser.parseBiologyList(page: page, html: html)
        case SKKUDept.SKKU:
            return SeoulNationalCommonParser.parseSeoulNationalList(page: page, html: html)
        default:
            break
        }
        return .failure(.emptyContent)
    }
    
    private func parseNoticeContent(dept: DeptItem, html: String) -> Result<NoticeContent, HTMLParseError> {
        do {
            let doc = try HTML(html: html, encoding: .utf8)
            switch dept {
            case SKKUDept.INFO_Information:
                return SeoulNationalContentParserNC.parseContentBiology(html: doc)
            case SKKUDept.BIO_BioMeca:
                return SeoulNationalContentParserSC.parseContentAnthropology(html: doc)
            case SKKUDept.EDU_Computer:
                return SeoulNationalContentParserSC.parseContentEconomics(html: doc)
            case SKKUDept.SKKU:
                return SeoulNationalContentParser.parseContentSchool(html: doc)
            default:
                return .failure(.notSupported)
            }
        } catch {
            return .failure(.encoding)
        }
    }
}
