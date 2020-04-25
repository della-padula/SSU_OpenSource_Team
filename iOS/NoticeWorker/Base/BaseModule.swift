//
//  BaseModule.swift
//  NoticeWorker
//
//  Created by 김태인 on 2020/04/24.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation

public typealias DeptName = String
public typealias CollegeName = String
public typealias URLName = String

protocol OrganizationProtocol {
    var organizationCode: OrganizationCode? { get set }
    
    func getSchoolName() -> String?
    
    func getDeptList(collegeName: CollegeName) -> [DeptItem]?
    
    func getNoticeURL(dept name: DeptName, page: Int, quantity: Int, completion: @escaping (Result<URL, URLGenerateError>) -> Void)
    
    func getCollegeCount() -> Int?
    
    func getDeptCount(collegeName: String) -> Int?
    
    func setOrganizationDept()
}

protocol OrganizationParserProtocol {
    
    func getNoticeList(completion: @escaping (Result<[Notice], HTMLParseError>) -> Void)
    
    func getAttachmentList(completion: @escaping (Result<[Attachment], HTMLParseError>) -> Void)
    
    func getNoticeContent(completion: @escaping (Result<NoticeContent, HTMLParseError>) -> Void)
}

public class Organization: OrganizationProtocol {
    var collegeList: [College]?
    
    public var mappingTable: [CollegeDeptMapper]?
    
    var organizationCode: OrganizationCode?
    
    public init() { }
    
    func getDeptList(collegeName: CollegeName) -> [DeptItem]? { return nil }
    
    func getSchoolName() -> String? { return nil }
    
    func getNoticeURL(dept name: DeptName, page: Int, quantity: Int, completion: @escaping (Result<URL, URLGenerateError>) -> Void) { }
    
    func getDeptCount(collegeName: String) -> Int? { return nil }
    
    func getCollegeCount() -> Int? { return nil }
    
    func getNoticeList(html: String) -> [Notice]? { return nil }
    
    func setOrganizationDept() { }
}

public protocol DeptItem {
    var urlString: String { get }
    
    var deptName: String { get }
}

public struct College {
    public var deptList: [DeptItem]?
    public var collegeName: String?
}

// MARK: Notice
public struct TestNotice {
    var property: [TestNoticeProperty]
}

public struct Notice {
    var title: String
    var url: String
    var date: String?
    var author: String?
    var isActive: Bool?
    var custom: [String:Any?]?
    
    public init(title: String, url: String) {
        self.title = title
        self.url = url
    }
}

public struct NoticeContent {
    var content: String
    var attachments: [Attachment]
}

public enum TestNoticeProperty {
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

public struct CollegeDeptMapper {
    var college: CollegeName
    var deptList: [DeptItem]
}
