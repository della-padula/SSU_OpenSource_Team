//
//  SeoulNationalConstant.swift
//  NoticeWorker
//
//  Created by Denny on 2020/04/30.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation

public enum SeoulCollegeCode: CollegeName, CaseIterable {
    case it = "IT대학"
    case law = "법과대학"
    case school = "학교"
}

public enum SeoulDept: DeptItem {
    case ENG_Computer(page: Int?, keyword: String?)
    case SC_Economics(page: Int?, keyword: String?)
    case SC_Anthropology(page: Int?, keyword: String?)
    case NC_Biology(page: Int?, keyword: String?)
    case EDU_Math(page: Int?, keyword: String?)
    
    case Seoul(page: Int?, keyword: String?)
    
    public func getURLString(page: Int, keyword: String?) -> String {
        switch self {
        case .ENG_Computer(let page, let keyword):
            return "https://cse.snu.ac.kr/department-notices?&keys=\(keyword ?? "")&page=\(page - 1)"
        case .SC_Economics(let page, let keyword):
            return "http://econ.snu.ac.kr/announcement/notice?bt=t&bq=\(keyword ?? "")&page=\(page)"
        case .SC_Anthropology(let page, let keyword):
            return "http://anthropology.or.kr/04_notice/notice01.htm?&s_t=1&s_key=\(keyword ?? "")&Page=\(page)"
        case .NC_Biology(let page, let keyword):
            return "http://biosci.snu.ac.kr/board/notice?bt=&bq=\(keyword ?? "")&page=\(page)"
        case .EDU_Math(let page, let keyword):
            return "http://mathed.snu.ac.kr/board/notice/page/\(page)?pmove=1&search_limit=10&search_sel=title&search_text=\(keyword ?? "")"
        case .Seoul(let page, let keyword):
            return "https://www.snu.ac.kr/snunow/notice/genernal?sc=y&df=&dt=&qt=b&q=\(keyword ?? "")&page=\(page)"
        }
    }
    
    public var deptName: String {
        switch self {
        case .ENG_Computer:
            return "컴퓨터공학부"
        case .SC_Economics:
            return "경제학과"
        case .SC_Anthropology:
            return "인류학과"
        case .NC_Biology:
            return "생명과학부"
        case .EDU_Math:
            return "수학교육과"
        case .Seoul:
            return "서울대학교 공지"
        }
    }
}
