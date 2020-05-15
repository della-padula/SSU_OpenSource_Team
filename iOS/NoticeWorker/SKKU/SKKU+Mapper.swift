//
//  Chungang+Mapper.swift
//  NoticeWorker
//
//  Created by 김태인 on 2020/05/06.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation

extension NW_SKKU {
    func mappingSKKUCollegeDept() {
        mappingTable = [CollegeDeptMapper]()
        mappingTable?.append(CollegeDeptMapper(college: SKKUCollegeCode.info.rawValue,
                                               deptList: [SKKUDept.INFO_Information(page: nil, keyword: nil)]))
        
        mappingTable?.append(CollegeDeptMapper(college: SKKUCollegeCode.bio.rawValue,
                                               deptList: [SKKUDept.BIO_BioMeca(page: nil, keyword: nil)]))
        
        mappingTable?.append(CollegeDeptMapper(college: SKKUCollegeCode.edu.rawValue,
                                               deptList: [SKKUDept.EDU_Computer(page: nil, keyword: nil)]))
        
        mappingTable?.append(CollegeDeptMapper(college: SKKUCollegeCode.skku.rawValue,
                                               deptList: [SKKUDept.SKKU(page: nil, keyword: nil)]))
    }
}
