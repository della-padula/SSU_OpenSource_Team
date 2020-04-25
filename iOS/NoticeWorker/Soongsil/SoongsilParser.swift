//
//  SoongsilParser.swift
//  NoticeWorker
//
//  Created by 김태인 on 2020/04/25.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation

public class SoongsilParser: OrganizationParserProtocol {
    
    func getNoticeList(completion: @escaping (Result<[Notice], HTMLParseError>) -> Void) {
        completion(.failure(.emptyContent))
    }
    
    func getAttachmentList(completion: @escaping (Result<[Attachment], HTMLParseError>) -> Void) {
        completion(.failure(.emptyContent))
    }
    
    func getNoticeContent(completion: @escaping (Result<NoticeContent, HTMLParseError>) -> Void) {
        completion(.failure(.emptyContent))
    }
    
}

public class SoongsilITParser {
    static func parseCSE(html: String, completion: @escaping (Result<NoticeContent, HTMLParseError>) -> Void) {
        completion(.failure(.emptyContent))
    }
    
    static func parseMedia(html: String, completion: @escaping (Result<NoticeContent, HTMLParseError>) -> Void) {
        completion(.failure(.emptyContent))
    }
    
    static func parseSmart(html: String, completion: @escaping (Result<NoticeContent, HTMLParseError>) -> Void) {
        completion(.failure(.emptyContent))
    }
    
    static func parseSW(html: String, completion: @escaping (Result<NoticeContent, HTMLParseError>) -> Void) {
        completion(.failure(.emptyContent))
    }
    
    static func parseElec(html: String, completion: @escaping (Result<NoticeContent, HTMLParseError>) -> Void) {
        completion(.failure(.emptyContent))
    }
}
