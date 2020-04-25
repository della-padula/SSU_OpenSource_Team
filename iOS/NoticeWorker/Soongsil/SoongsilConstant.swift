//
//  SoongsilConstant.swift
//  NoticeWorker
//
//  Created by 김태인 on 2020/04/25.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation

public enum SoongsilCollegeCode: CollegeName, CaseIterable {
    case it = "IT대학"
    case law = "법과대학"
    case school = "학교"
}

public enum SoongsilDept: DeptItem {
    case IT_Computer(page: Int?, keyword: String?)
    case IT_Media(page: Int?, keyword: String?)
    case IT_Electric(page: Int?, keyword: String?)
    case IT_Software(page: Int?, keyword: String?)
    case IT_SmartSystem(page: Int?, keyword: String?)
    
    case LAW_Law(page: Int?, keyword: String?)
    case LAW_IntlLaw(page: Int?, keyword: String?)
    
    case Soongsil(page: Int?, keyword: String?)
    
    public var urlString: String {
        switch self {
        case .IT_Computer(let page, let keyword):
            return "http://cse.ssu.ac.kr/03_sub/01_sub.htm?page=\(page ?? 1)&key=\(keyword ?? "")&keyfield=subject&category=&bbs_code=Ti_BBS_1"
        case .IT_Media(let page, let keyword):
            return "http://media.ssu.ac.kr/sub.php?code=XxH00AXY&mode=&category=1&searchType=title&search=\(keyword ?? "")&orderType=&orderBy=&page=\(page ?? 0)"
            
        case .IT_Electric(let page, let keyword):
            return "http://infocom.ssu.ac.kr/rb/?c=2/38&where=subject%7Ctag&keyword=\(keyword ?? "")&p=\(page ?? 0)"
            
        case .IT_Software(let page, let keyword):
            return "https://sw.ssu.ac.kr/bbs/board.php?bo_table=sub6_1&sca=&stx=\(keyword ?? "")&sop=and&page=\(page ?? 0)"
            
        case .IT_SmartSystem(let page, let keyword):
            return "http://smartsw.ssu.ac.kr/board/notice/\(page ?? 0)?search=\(keyword ?? "")"
            
        case .LAW_Law(let page, let keyword):
            return "http://law.ssu.ac.kr/web/law/board1?p_p_id=EXT_BBS&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_count=1&_EXT_BBS_struts_action=%2Fext%2Fbbs%2Fview&_EXT_BBS_sCategory=&_EXT_BBS_sTitle=\(keyword ?? "")&_EXT_BBS_sWriter=&_EXT_BBS_sTag=&_EXT_BBS_sContent=&_EXT_BBS_sCategory2=&_EXT_BBS_sKeyType=title&_EXT_BBS_sKeyword=\(keyword ?? "")&_EXT_BBS_curPage=\(page ?? 0)"
            
        case .LAW_IntlLaw(let page, let keyword):
            return "http://lawyer.ssu.ac.kr/web/lawyer/27?p_p_id=EXT_BBS&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_count=1&_EXT_BBS_struts_action=%2Fext%2Fbbs%2Fview&_EXT_BBS_sCategory=&_EXT_BBS_sTitle=\(keyword ?? "")&_EXT_BBS_sWriter=&_EXT_BBS_sTag=&_EXT_BBS_sContent=&_EXT_BBS_sCategory2=&_EXT_BBS_sKeyType=title&_EXT_BBS_sKeyword=\(keyword ?? "")&_EXT_BBS_curPage=\(page ?? 0)"
        case .Soongsil(let page, let keyword):
            return "https://scatch.ssu.ac.kr/%EA%B3%B5%EC%A7%80%EC%82%AC%ED%95%AD/page/\(page ?? 0)/?f=all&keyword=\(keyword ?? "")"
        }
    }
    
    public var deptName: String {
        switch self {
        case .IT_Computer:
            return "컴퓨터학부"
        case .IT_Media:
            return "글로벌미디어학부"
        case .IT_Electric:
            return "전자정보공학부"
        case .IT_Software:
            return "소프트웨어학부"
        case .IT_SmartSystem:
            return "스마트시스템소프트웨어학과"
        case .LAW_Law:
            return "법학과"
        case .LAW_IntlLaw:
            return "국제법무학과"
        case .Soongsil:
            return "숭실대학교 공지"
        }
    }
}
