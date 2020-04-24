//
//  BaseModule.swift
//  NoticeWorker
//
//  Created by 김태인 on 2020/04/24.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation

public typealias DeptCode = Int

protocol OrganizationProtocol {
    func getSchoolName() -> String?
    
    func getNoticeURL(dept code: DeptCode, page: Int, quantity: Int, completion: @escaping (Result<URL, URLGenerateError>) -> Void)
    
    func getDeptCount() -> Int?
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

public struct Notice {
    var index     : Int
    var title     : String
    var author    : String
    var date      : Date
    var viewCount : Int
}

public enum OrganizationCode: Int {
    case Soongsil
    case Chungang
}
