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
            return .failure(.notSupported)
        case SeoulDept.NC_Biology:
            return .failure(.notSupported)
        case SeoulDept.SC_Anthropology:
            return .failure(.notSupported)
        case SeoulDept.SC_Economics:
            return SeoulNationalSCParser.parseEconomicsList(page: page, html: html)
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
                return .failure(.notSupported)
            case SeoulDept.EDU_Math:
                return .failure(.notSupported)
            case SeoulDept.NC_Biology:
                return .failure(.notSupported)
            case SeoulDept.SC_Anthropology:
                return .failure(.notSupported)
            case SeoulDept.SC_Economics:
                return .failure(.notSupported)
            default:
                return .failure(.notSupported)
            }
        } catch {
            return .failure(.encoding)
        }
    }
}
