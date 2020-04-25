//
//  NoticeWorker.swift
//  NoticeWorker
//
//  Created by 김태인 on 2020/03/28.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation

public class NoticeWorker {
    public var organization: Organization?
    
    public init() {
        print("Notice Worker Initialize")
    }
    
    public func getSchoolName() -> String? {
        return organization?.getSchoolName()
    }
    
    public func getDeptList(collegeName: CollegeName) -> [Dept]? {
        return organization?.getDeptList(collegeName: collegeName)
    }
    
    public func getNoticeURL(dept name: DeptName, page: Int, quantity: Int, completion: @escaping (Result<URL, URLGenerateError>) -> Void) {
        self.organization?.getNoticeURL(dept: name, page: page, quantity: quantity, completion: completion)
    }
    
    public func getNoticeList() -> [Notice]? {
        return self.organization?.getNoticeList(html: "TEST")
    }
    
    public func getCollegeCount() -> Int? {
        return organization?.getCollegeCount()
    }
    
    public func getDeptCount(collegeName: String) -> Int? {
        return organization?.getDeptCount(collegeName: collegeName)
    }
}
