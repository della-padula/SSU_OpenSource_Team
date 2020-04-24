//
//  Seoul_Soongsil.swift
//  NoticeWorker
//
//  Created by 김태인 on 2020/04/24.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation

public struct Soongsil: Organization {
    public var deptList: [Dept]
    
    public func getSchoolName() -> String {
        return "숭실대학교"
    }
    
    public func getNoticeURL(dept code: SoongsilDeptCode, page: Int, quantity: Int, completion: @escaping (Result<URL, URLGenerateError>) -> Void) {
        completion(.failure(.emptyKeyword))
    }
    
    public func getDeptCount() -> Int {
        return deptList.count
    }
}

public enum SoongsilDeptCode: DeptCode {
    case itComputer
    case itMedia
    case itElectric
    case itSoftware
    case itSmart
}

public enum DeptCode: Int { }
