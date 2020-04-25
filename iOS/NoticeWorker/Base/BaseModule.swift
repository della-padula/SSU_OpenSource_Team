//
//  BaseModule.swift
//  NoticeWorker
//
//  Created by 김태인 on 2020/04/24.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation

public typealias DeptCode = Int
public typealias CollegeCode = Int

protocol OrganizationProtocol {
    func getSchoolName() -> String?
    
    func getNoticeURL(dept code: DeptCode, page: Int, quantity: Int, completion: @escaping (Result<URL, URLGenerateError>) -> Void)
    
    func getDeptCount() -> Int?
}

protocol OrganizationParserProtocol {
    func getNoticeList() -> [Notice]?
    
//    func getAttachmentList() ->
}

public class Organization: OrganizationProtocol {
    var deptList: [Dept]?
    
    public init() { }
    
    func getSchoolName() -> String? { return nil }
    
    func getNoticeURL(dept code: DeptCode, page: Int, quantity: Int, completion: @escaping (Result<URL, URLGenerateError>) -> Void) { }
    
    func getDeptCount() -> Int? { return nil }
}

public protocol Dept {
    var deptName: String { get set }
    var noticeURLString: String { get set }
}

// MARK: Notice
public struct Notice {
    var property: [NoticeItem]
}

public enum NoticeItem {
    case title(value: String)
    case url(value: String)
    case date(value: String?)
    case author(value: String?)
    case isActive(value: Bool?)
    case custom(key: String, value: Any?)
    
    var key: String {
        switch self {
        case .title:
            return "title"
        case .url:
            return "url"
        case .date:
            return "date"
        case .author:
            return "author"
        case .isActive:
            return "isActive"
        case .custom(let key, _):
            return key
        }
    }
    
    public var value: Any? {
        switch self {
        case .title(let value):
            return value
        case .url(let value):
            return value
        case .date(let value):
            return value
        case .author(let value):
            return value
        case .isActive(let value):
            return value
        case .custom(_, let value):
            return value
        }
    }
    
}


// MARK: Attachment
public struct Attachment {
    var fileName      : String?
    var fileURL       : String?
}

public enum OrganizationCode: Int {
    case Soongsil
    case Chungang
}
