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
        return SoongsilListParser.parseNoticeList(dept: deptItem, page: page, html: html)
    }
    
    func getAttachmentList(completion: @escaping (Result<[Attachment], HTMLParseError>) -> Void) {
        completion(.failure(.emptyContent))
    }
    
    func getNoticeContent(completion: @escaping (Result<NoticeContent, HTMLParseError>) -> Void) {
        completion(.failure(.emptyContent))
    }
    
}
