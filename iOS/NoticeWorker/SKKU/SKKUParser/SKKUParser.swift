//
//  SKKUParser.swift
//  NoticeWorker
//
//  Created by 김태인 on 2020/05/15.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation

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
            return SKKUListINFOParser.parseInformationList(page: page, html: html)
        case SKKUDept.BIO_BioMeca:
            return SKKUListBIOParser.parseBioMecaList(page: page, html: html)
        case SKKUDept.EDU_Computer:
            return SKKUListEDUParser.parseComputerList(page: page, html: html)
        case SKKUDept.SKKU:
            return SKKUListParserCommon.parseSKKUList(page: page, html: html)
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
                return SKKUContentParserINFO.parseContentInformation(html: doc)
            case SKKUDept.BIO_BioMeca:
                return SKKUContentParserBIO.parseContentBioMeca(html: doc)
            case SKKUDept.EDU_Computer:
                return SKKUContentParserEDU.parseContentComputer(html: doc)
            case SKKUDept.SKKU:
                return SKKUContentParserCommon.parseContentSKKU(html: doc)
            default:
                return .failure(.notSupported)
            }
        } catch {
            return .failure(.encoding)
        }
    }
}
