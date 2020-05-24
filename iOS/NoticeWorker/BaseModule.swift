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

// Organization Content Parser
// Author : Taein Kim
// Description : To make HTML Content fit to device (various screen size)

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

// OrganizationProtocol
// Author : Taein Kim
// Description : To supply the Base Organization Method for new Custom Organization Classes.

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

// DeptItem
// Author : Taein Kim
// Description : DeptItem has Two Properties (URL Info, Name of Dept.)

public protocol DeptItem {
    func getURLString(page: Int, keyword: String?) -> String
    var deptName: String { get }
}

// College
// Author : Taein Kim
// Description : College has various Dept. Items and College has name.

public struct College {
    public var deptList: [DeptItem]?
    public var collegeName: String?
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

// MARK: Attachment
public struct Attachment {
    var fileName      : String?
    var fileURL       : String?
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

public class DeptListParser {
    static var noticeList = [Notice]()
    static var authorList = [String]()
    static var titleList  = [String]()
    static var pageStringList = [String]()
    static var dateStringList = [String]()
    static var isNoticeList = [Bool]()
    static var urlList    = [String]()
    static var attachmentCheckList = [Bool]()
    
    static func cleanList() {
        noticeList.removeAll()
        authorList.removeAll()
        titleList.removeAll()
        pageStringList.removeAll()
        dateStringList.removeAll()
        isNoticeList.removeAll()
        urlList.removeAll()
        attachmentCheckList.removeAll()
    }
}

extension String  {
    var isNumber: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
}
