//
//  SeoulNational+Mapper.swift
//  NoticeWorker
//
//  Created by Denny on 2020/04/30.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation

extension NW_SeoulNational {
    func mappingSeoulCollegeDept() {
        mappingTable = [CollegeDeptMapper]()
        mappingTable?.append(CollegeDeptMapper(college: SeoulCollegeCode.it.rawValue,
                                               deptList: [SeoulDept.IT_Computer(page: nil, keyword: nil),
                                                          SeoulDept.IT_Media(page: nil, keyword: nil),
                                                          SeoulDept.IT_Electric(page: nil, keyword: nil),
                                                          SeoulDept.IT_Software(page: nil, keyword: nil),
                                                          SeoulDept.IT_SmartSystem(page: nil, keyword: nil)]))
        
        mappingTable?.append(CollegeDeptMapper(college: SeoulCollegeCode.law.rawValue,
                                               deptList: [SeoulDept.LAW_Law(page: nil, keyword: nil),
                                                          SeoulDept.LAW_IntlLaw(page: nil, keyword: nil)]))
        
        mappingTable?.append(CollegeDeptMapper(college: SeoulCollegeCode.school.rawValue,
                                               deptList: [SeoulDept.Seoul(page: nil, keyword: nil)]))
    }
}
