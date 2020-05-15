//
//  ChungandConstant.swift
//  NoticeWorker
//
//  Created by 김태인 on 2020/05/06.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation

public enum SKKUCollegeCode: CollegeName, CaseIterable {
    case info = "정보통신대학"
    case bio = "생명과학대학"
    case edu = "사범대학"
    case skku = "학교"
}

public enum SKKUDept: DeptItem {
    case INFO_Information(page: Int?, keyword: String?)
    case BIO_BioMeca(page: Int?, keyword: String?)
    case EDU_Computer(page: Int?, keyword: String?)
    case SKKU(page: Int?, keyword: String?)
    
    public func getURLString(page: Int, keyword: String?) -> String {
        switch self {
        case .INFO_Information(let page, let keyword):
            return "http://icc.skku.ac.kr/icc_new/board_list_square?listPage=\(page ?? 1)&boardName=board_notice&field=subject&keyword=\(keyword ?? "")"
        case .BIO_BioMeca(let page, let keyword):
            return "https://skb.skku.edu/biomecha/community/notice.do?mode=list&&articleLimit=10&srSearchVal=\(keyword ?? "")&article.offset=\(((page ?? 1) - 1) * 10)"
        case .EDU_Computer(let page, let keyword):
            return "https://comedu.skku.edu/comedu/notice.do?mode=list&&articleLimit=10&srSearchVal=\(keyword ?? "")&article.offset=\(((page ?? 1) - 1) * 10)"
        case .SKKU(let page, let keyword):
            return "https://www.skku.edu/skku/campus/skk_comm/notice01.do?mode=list&&articleLimit=10&srSearchVal=\(keyword ?? "")&article.offset=\(((page ?? 1) - 1) * 10)"
        }
    }
    
    public var deptName: String {
        switch self {
        case .INFO_Information:
            return "정보통신학과"
        case .BIO_BioMeca:
            return "바이오메카트로닉스학과"
        case .EDU_Computer:
            return "컴퓨터교육과"
        case .SKKU:
            return "성균관대 공지"
        }
    }
}
