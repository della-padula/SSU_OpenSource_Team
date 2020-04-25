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
    
    private func testFunc() {
        var items = [Notice]()
        let noticeProperty: [NoticeItem] = [.date(value: "2020-04-26"),
                                            .title(value: "Test Title"),
                                            .isActive(value: false),
                                            .url(value: "https://www.google.com"),
                                            .author(value: "TestAuthor"),
                                            .custom(key: "viewCount", value: 100)]
        
        let item = Notice(property: noticeProperty)
        items.append(item)
    }
    
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
