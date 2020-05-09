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
    
    func getAllDeptList() -> [DeptItem]?
    
    func getNoticeURL(dept item: DeptItem, page: Int, keyword: String?, completion: @escaping (Result<URL, URLGenerateError>) -> Void)
    
    func getCollegeCount() -> Int?
    
    func getDeptCount(collegeName: String) -> Int?
    
    func setOrganizationDept()
    
    func generateCollegeList() -> [CollegeName]?
    
    func mappingCollegeDept()
}

protocol OrganizationParserProtocol {
    
    init(deptItem: DeptItem)
    
    func getNoticeList(page: Int, html: String) -> Result<[Notice], HTMLParseError>
    
    func getAttachmentList(html: String) -> Result<[Attachment], HTMLParseError>
    
    func getNoticeContent(html: String) -> Result<NoticeContent, HTMLParseError>
}

public class OrganizationContentParser {
    private static let htmlStart = "<hml><head><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, shrink-to-fit=no\"><style>html,body{padding:0 5px 5px;margin:0;font-size:18px !important;}iframe,img{max-width:100%;height:auto;}</style></head><bpdy>"
    private static let htmlEnd = "</bpdy></hml>"
    
    static func generateFilteredDetailHTML(fromHTML: String) -> String {
        return "\(htmlStart)\(fromHTML)\(htmlEnd)"
    }
    
    static func generateDetailHTML(fromHTML: String) -> String {
        return fromHTML
    }
}

public class Organization: OrganizationProtocol {
    var collegeCodeList: [CollegeName]?
    
    var collegeList: [College]?
    
    public var mappingTable: [CollegeDeptMapper]?
    
    var organizationCode: OrganizationCode?
    
    public init() { }
    
    func getDeptList(collegeName: CollegeName) -> [DeptItem]? { return nil }
    
    public func getAllDeptList() -> [DeptItem]? { return nil }
    
    public func getSchoolName() -> String? { return nil }
    
    func generateCollegeList() -> [CollegeName]? { return nil }
    
    func getNoticeURL(dept item: DeptItem, page: Int, keyword: String?, completion: @escaping (Result<URL, URLGenerateError>) -> Void) { }
    
    func getDeptCount(collegeName: String) -> Int? { return nil }
    
    func getCollegeCount() -> Int? { return nil }
    
    func getNoticeList(dept: DeptItem, page: Int, html: String) -> [Notice]? { return nil }
    
    func getNoticeContent(dept: DeptItem, html: String) -> NoticeContent? { return nil }
    
    func getAttachmentList(dept: DeptItem, html: String) -> [Attachment]? { return nil }
    
    func mappingCollegeDept() { }
    
    func setOrganizationDept() {
        collegeList = [College]()
        guard let list = self.collegeCodeList else { return }
        
        for collegeCode in list {
            var college = College()
            college.collegeName = collegeCode
            if let deptList = mappingTable?.filter({ $0.college == collegeCode }).first?.deptList {
                var tempList = [DeptItem]()
                for deptItem in deptList {
                    tempList.append(deptItem)
                }
                college.deptList = tempList
            }
            collegeList?.append(college)
        }
    }
}

public protocol DeptItem {
    func getURLString(page: Int, keyword: String?) -> String
    var deptName: String { get }
}

public struct College {
    public var deptList: [DeptItem]?
    public var collegeName: String?
}

// MARK: Notice
public struct TestNotice {
    public var property: [TestNoticeProperty]
}

public struct Notice {
    public var title: String
    public var url: String
    public var date: String?
    public var author: String?
    public var isActive: Bool?
    public var custom: [String:Any?]?
    
    public init(title: String, url: String) {
        self.title = title
        self.url = url
    }
}

public struct NoticeContent {
    public var content: String
    public var attachments: [Attachment]
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

public extension String {
    func encodeUrl() -> String? {
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
    
    func decodeUrl() -> String? {
        return self.removingPercentEncoding
    }
}
