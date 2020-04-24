//
//  Seoul_Soongsil.swift
//  NoticeWorker
//
//  Created by 김태인 on 2020/04/24.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation

public class NW_Soongsil: Organization {
    public override init() { }
    
    override func getSchoolName() -> String? {
        return "숭실대학교"
    }
    
    override func getNoticeURL(dept code: DeptCode, page: Int, quantity: Int, completion: @escaping (Result<URL, URLGenerateError>) -> Void) {
        // MARK: TEMP
        if code == SoongsilDeptCode.itComputer.rawValue {
            completion(.failure(.invalid))
        }
        completion(.failure(.emptyKeyword))
    }
    
    override func getDeptCount() -> Int? {
        return super.deptList?.count
    }
}

public enum SoongsilDeptCode: Int {
    case itComputer
    case itMedia
    case itElectric
    case itSoftware
    case itSmart
}
