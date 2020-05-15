//
//  ChungandConstant.swift
//  NoticeWorker
//
//  Created by 김태인 on 2020/05/06.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation

public enum ChungangCollegeCode: CollegeName, CaseIterable {
    case sw = "소프트웨어대학"
    case bio = "생명과학대학"
    case edu = "사범대학"
    case skku = "학교"
}

public enum ChungangDept: DeptItem {
    case SW_Software(page: Int?, keyword: String?)
    case BIO_BioMeca(page: Int?, keyword: String?)
    case EDU_Math(page: Int?, keyword: String?)
    case SKKU(page: Int?, keyword: String?)
    
    public func getURLString(page: Int, keyword: String?) -> String {
        switch self {
        case .SW_Software(let page, let keyword):
            return "https://cse.snu.ac.kr/department-notices?&keys=\(keyword ?? "")&page=\((page ?? 1) - 1)"
        case .BIO_BioMeca(let page, let keyword):
            return "http://econ.snu.ac.kr/announcement/notice?bt=t&bq=\(keyword ?? "")&page=\(page)"
        case .EDU_Math(let page, let keyword):
            return "http://anthropology.or.kr/04_notice/notice01.htm?&s_t=1&s_key=\(keyword ?? "")&Page=\(page)"
        case .SKKU(let page, let keyword):
            return "https://www.snu.ac.kr/snunow/notice/genernal?sc=y&df=&dt=&qt=b&q=\(keyword ?? "")&page=\(page)"
        }
    }
    
    public var deptName: String {
        switch self {
        case .SW_Software:
            return "소프트웨어학과"
        case .BIO_BioMeca:
            return "바이오메카트로닉스학과"
        case .EDU_Math:
            return "수학교육과"
        case .SKKU:
            return "성균관대 공지"
        }
    }
}
