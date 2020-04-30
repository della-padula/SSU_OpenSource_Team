//
//  SeoulNational.swift
//  NoticeWorker
//
//  Created by Denny on 2020/04/30.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation

class NW_SeoulNational: Organization {
    override init() {
        super.init()
        
        self.collegeCodeList = generateCollegeList()
        self.mappingCollegeDept()
        self.setOrganizationDept()
        self.organizationCode = .Soongsil
    }
    
    override func generateCollegeList() -> [CollegeName]? {
        var collegeList = [CollegeName]()
        for codeCase in SeoulCollegeCode.allCases {
            collegeList.append(codeCase.rawValue)
        }
        return collegeList
    }
    
    func testFunc() -> [Notice] {
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
    
    override func getNoticeList(dept: DeptItem, page: Int, html: String) -> [Notice]? {
        return testFunc()
    }
    
    override func getCollegeCount() -> Int? {
        return super.collegeList?.count
    }
    
    override public func getSchoolName() -> String? {
        return "서울대학교"
    }
    
    override func getNoticeURL(dept item: DeptItem, page: Int, keyword: String?, completion: @escaping (Result<URL, URLGenerateError>) -> Void) {
        //        completion(.failure(.emptyKeyword))
        if let url = URL(string: item.getURLString(page: 1, keyword: nil)) {
            completion(.success(url))
        } else {
            completion(.failure(.invalid))
        }
    }
    
    override func getAllDeptList() -> [DeptItem]? {
        if collegeList != nil {
            var list = [DeptItem]()
            for college in collegeList! {
                if let deptList = college.deptList {
                    list.append(contentsOf: deptList)
                }
            }
            return list
        }
        return nil
    }
    
    override func getDeptList(collegeName: CollegeName) -> [DeptItem]? {
        return collegeList?.filter({ $0.collegeName == collegeName }).first?.deptList
    }
    
    override func getDeptCount(collegeName: String) -> Int? {
        return super.collegeList?.filter({ $0.collegeName == collegeName }).first?.deptList?.count
    }
    
    override func mappingCollegeDept() {
        self.mappingSeoulCollegeDept()
    }
}
