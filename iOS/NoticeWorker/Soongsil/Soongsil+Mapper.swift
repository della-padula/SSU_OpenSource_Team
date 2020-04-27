//
//  Soongsil+Mapper.swift
//  NoticeWorker
//
//  Created by 김태인 on 2020/04/25.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation

extension NW_Soongsil {
    func mappingSoongsilCollegeDept() {
        mappingTable = [CollegeDeptMapper]()
        mappingTable?.append(CollegeDeptMapper(college: SoongsilCollegeCode.it.rawValue,
                                               deptList: [SoongsilDept.IT_Computer(page: nil, keyword: nil),
                                                          SoongsilDept.IT_Media(page: nil, keyword: nil),
                                                          SoongsilDept.IT_Electric(page: nil, keyword: nil),
                                                          SoongsilDept.IT_Software(page: nil, keyword: nil),
                                                          SoongsilDept.IT_SmartSystem(page: nil, keyword: nil)]))
        
        mappingTable?.append(CollegeDeptMapper(college: SoongsilCollegeCode.law.rawValue,
                                               deptList: [SoongsilDept.LAW_Law(page: nil, keyword: nil),
                                                          SoongsilDept.LAW_IntlLaw(page: nil, keyword: nil)]))
        
        mappingTable?.append(CollegeDeptMapper(college: SoongsilCollegeCode.school.rawValue,
                                               deptList: [SoongsilDept.Soongsil(page: nil, keyword: nil)]))
    }
}
