//
//  BaseModule.swift
//  NoticeWorker
//
//  Created by 김태인 on 2020/04/24.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation

public protocol Organization {
    var deptList: [Dept] { get set }
    
    func getSchoolName() -> String
    
    func getNoticeURL(dept code: DeptCode, page: Int, quantity: Int, completion: @escaping (Result<URL, URLGenerateError>) -> Void)
    
    func getDeptCount() -> Int
    
    
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
