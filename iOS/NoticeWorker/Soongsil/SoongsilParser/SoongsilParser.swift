//
//  SoongsilParser.swift
//  NoticeWorker
//
//  Created by 김태인 on 2020/04/25.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import Kanna

typealias Action = (Result<[Notice], HTMLParseError>) -> Void

public class SoongsilParser: OrganizationParserProtocol {
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

extension SoongsilParser {
    private func parseNoticeList(dept: DeptItem, page: Int, html: String) -> Result<[Notice], HTMLParseError> {
        switch dept {
        case SoongsilDept.IT_Computer:
            return SoongsilITParser.parseCSEList(page: page, html: html)
        case SoongsilDept.IT_Media:
            return SoongsilITParser.parseMediaList(page: page, html: html)
        case SoongsilDept.IT_Electric:
            return SoongsilITParser.parseElecList(page: page, html: html)
        case SoongsilDept.IT_Software:
            return SoongsilITParser.parseSWList(page: page, html: html)
        case SoongsilDept.IT_SmartSystem:
            return SoongsilITParser.parseSmartSWList(page: page, html: html)
        case SoongsilDept.LAW_Law:
            return SoongsilLawParser.parseLAWList(page: page, html: html)
        case SoongsilDept.LAW_IntlLaw:
            return SoongsilLawParser.parseINTLAWList(page: page, html: html)
        case SoongsilDept.Soongsil:
            return SoongsilCommonParser.parseSoongsilList(page: page, html: html)
        default:
            break
        }
        return .failure(.emptyContent)
    }
    
    // MARK: TEMP NEED TO BE REPAIRED
    private func parseNoticeContent(dept: DeptItem, html: String) -> Result<NoticeContent, HTMLParseError> {
        switch dept {
        case SoongsilDept.IT_Computer:
            return .failure(.emptyContent)
        case SoongsilDept.IT_Media:
            return .failure(.emptyContent)
        case SoongsilDept.IT_Electric:
            return .failure(.emptyContent)
        case SoongsilDept.IT_Software:
            return .failure(.emptyContent)
        case SoongsilDept.IT_SmartSystem:
            return .failure(.emptyContent)
        case SoongsilDept.LAW_Law:
            break
        case SoongsilDept.LAW_IntlLaw:
            break
        default:
            break
        }
        return .failure(.emptyContent)
    }
}
