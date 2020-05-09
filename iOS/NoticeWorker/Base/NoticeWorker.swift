//
//  NoticeWorker.swift
//  NoticeWorker
//
//  Created by 김태인 on 2020/03/28.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation

public class NoticeWorker {
    private var organization: Organization?
    var organizationList = [Organization]()
    
    public init() {
        print("Notice Worker Initialize")
        setOrganizationList()
    }
    
    public func getOrganizationList() -> [Organization] {
        return organizationList
    }
    
    public func getCurrentOrganization() -> Organization? {
        return organization
    }
    
    public func getOrganization(byName: String) -> Organization? {
        for organization in self.organizationList {
            if organization.getSchoolName() == byName {
                return organization
            }
        }
        return nil
    }
    
    public func getOrganization(byIndex: Int) -> Organization? {
        if byIndex > organizationList.count - 1 {
            return nil
        }
        return organizationList[byIndex]
    }
    
    public func setOrganization(organization: Organization) {
        self.organization = organization
    }
    
    public func getSchoolName() -> String? {
        return organization?.getSchoolName()
    }
    
    public func getDeptList(collegeName: CollegeName) -> [DeptItem]? {
        return organization?.getDeptList(collegeName: collegeName)
    }
    
    public func getAllDeptList() -> [DeptItem]? {
        return organization?.getAllDeptList()
    }
    
    public func getNoticeURL(dept item: DeptItem, page: Int, keyword: String?, completion: @escaping (Result<URL, URLGenerateError>) -> Void) {
        self.organization?.getNoticeURL(dept: item, page: page, keyword: keyword, completion: completion)
    }
    
    public func getNoticeContent(dept item: DeptItem, html: String) -> NoticeContent? {
        return self.organization?.getNoticeContent(dept: item, html: html)
    }
    
    public func getAttachmentList(dept item: DeptItem, html: String) -> [Attachment]? {
        return self.organization?.getAttachmentList(dept: item, html: html)
    }
    
    public func getNoticeList(dept: DeptItem, page: Int, html: String) -> [Notice]? {
        return self.organization?.getNoticeList(dept: dept, page: page, html: html)
    }
    
    public func getCollegeCount() -> Int? {
        return organization?.getCollegeCount()
    }
    
    public func getDeptCount(collegeName: CollegeName) -> Int? {
        return organization?.getDeptCount(collegeName: collegeName)
    }
}
