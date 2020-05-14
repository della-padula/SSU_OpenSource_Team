//
//  SeoulNationalParser.swift
//  NoticeWorker
//
//  Created by Denny on 2020/05/10.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import Kanna

public class SeoulNationalParser: OrganizationParserProtocol {
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

extension SeoulNationalParser {
    private func parseNoticeList(dept: DeptItem, page: Int, html: String) -> Result<[Notice], HTMLParseError> {
        switch dept {
        case SeoulDept.ENG_Computer:
            return SeoulNationalENGParser.parseCSEList(page: page, html: html)
        case SeoulDept.EDU_Math:
            return SeoulNationalEDUParser.parseMathList(page: page, html: html)
        case SeoulDept.NC_Biology:
            return SeoulNationalNCParser.parseBiologyList(page: page, html: html)
        case SeoulDept.SC_Anthropology:
            return SeoulNationalSCParser.parseAnthropologyList(page: page, html: html)
        case SeoulDept.SC_Economics:
            return SeoulNationalSCParser.parseEconomicsList(page: page, html: html)
        case SeoulDept.Seoul:
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
            case SeoulDept.ENG_Computer:
                return SeoulNationalContentParserENG.parseContentCSE(html: doc)
            case SeoulDept.EDU_Math:
                return SeoulNationalContentParserEDU.parseContentMath(html: doc)
            case SeoulDept.NC_Biology:
                return SeoulNationalContentParserNC.parseContentBiology(html: doc)
            case SeoulDept.SC_Anthropology:
                return SeoulNationalContentParserSC.parseContentAnthropology(html: doc)
            case SeoulDept.SC_Economics:
                return SeoulNationalContentParserSC.parseContentEconomics(html: doc)
            case SeoulDept.Seoul:
                return SeoulNationalContentParser.parseContentSchool(html: doc)
            default:
                return .failure(.notSupported)
            }
        } catch {
            return .failure(.encoding)
        }
    }
}
