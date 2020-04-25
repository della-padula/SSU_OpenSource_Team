//
//  Seoul_Soongsil.swift
//  NoticeWorker
//
//  Created by 김태인 on 2020/04/24.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation

public class NW_Soongsil: Organization {
    public override init() {
        super.init()
        self.mappingCollegeDept()
        self.setOrganizationDept()
        self.organizationCode = .Soongsil
    }
    
    public func testFunc() -> [Notice] {
        var items = [TestNotice]()
        let noticeProperty: [TestNoticeProperty] = [.date(value: "2020-04-26"),
                                                    .title(value: "Test Title"),
                                                    .isActive(value: false),
                                                    .url(value: "https://www.google.com"),
                                                    .author(value: "TestAuthor"),
                                                    .custom(key: "viewCount", value: 100),
                                                    .custom(key: "isNew", value: false)]
        
        let item = TestNotice(property: noticeProperty)
        items.append(item)
        
        let _ = noticeProperty.contains(where: ({ $0.key == TestNoticeProperty.title(value: "").key }))
        
        var testItems = [Notice]()
        var testItem = Notice(title: "Test Title", url: "https://www.google.com")
        testItem.author = "Test"
        testItem.date = "2020-04-25"
        testItem.isActive = true
        testItem.custom = ["viewCount": 100]
        testItems.append(testItem)
        
        let _ = testItem.custom?["viewCount"]
        return testItems
    }
    
    override func getNoticeList(html: String) -> [Notice]? {
        return testFunc()
    }
    
    override func getCollegeCount() -> Int? {
        return super.collegeList?.count
    }
    
    override func getSchoolName() -> String? {
        return "숭실대학교"
    }
    
    override func getNoticeURL(dept name: DeptName, page: Int, quantity: Int, completion: @escaping (Result<URL, URLGenerateError>) -> Void) {
        // MARK: TEMP
        if name == SoongsilDeptCode.IT_Computer.rawValue {
            completion(.failure(.invalid))
        }
        completion(.failure(.emptyKeyword))
    }
    
    override func getDeptCount(collegeName: String) -> Int? {
        return super.collegeList?.filter({ $0.collegeName == collegeName }).count
    }
    
    override func setOrganizationDept() {
        for collegeCode in SoongsilCollegeCode.allCases {
            var college = College()
            college.collegeName = collegeCode.rawValue
            
            let count = getDeptCount(collegeName: college.collegeName ?? "") ?? 0
            for deptIndex in 0..<count {
                let dept: Dept = Dept(deptName: "테스트학과\(deptIndex)", urlString: "https://www.google.com")
                college.deptList?.append(dept)
            }
            collegeList?.append(college)
        }
    }
}
