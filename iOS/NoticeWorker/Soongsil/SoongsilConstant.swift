//
//  SoongsilConstant.swift
//  NoticeWorker
//
//  Created by 김태인 on 2020/04/25.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation

public struct CollegeDeptMapper {
    var college: CollegeName
    var deptList: [DeptName]
}

public enum SoongsilCollegeCode: CollegeName, CaseIterable {
    case it = "IT대학"
    case law = "법과대학"
    case school = "학교"
}

public enum SoongsilDeptCode: DeptName, CaseIterable {
    // IT
    case IT_Computer = "컴퓨터학부"
    case IT_Media = "글로벌미디어학부"
    case IT_Electric = "전자정보공학부"
    case IT_Software = "소프트웨어학부"
    case IT_SmartSystem = "스마트시스템소프트웨어학과"
    // LAW
    case LAW_Law = "법학과"
    case LAW_IntlLaw = "국제법무학과"
    
    case Soongsil = "숭실대학교 공지"
}


