//
//  Soongsil+Mapper.swift
//  NoticeWorker
//
//  Created by 김태인 on 2020/04/25.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation

extension NW_Soongsil {
    func mappingCollegeDept() {
        mappingTable?.append(CollegeDeptMapper(college: SoongsilCollegeCode.it.rawValue,
                                               deptList: [SoongsilDeptCode.IT_Computer.rawValue,
                                                          SoongsilDeptCode.IT_Media.rawValue,
                                                          SoongsilDeptCode.IT_Electric.rawValue,
                                                          SoongsilDeptCode.IT_Software.rawValue,
                                                          SoongsilDeptCode.IT_SmartSystem.rawValue]))
        
        mappingTable?.append(CollegeDeptMapper(college: SoongsilCollegeCode.law.rawValue,
                                               deptList: [SoongsilDeptCode.LAW_Law.rawValue,
                                                          SoongsilDeptCode.LAW_IntlLaw.rawValue]))
        
        mappingTable?.append(CollegeDeptMapper(college: SoongsilCollegeCode.school.rawValue,
                                               deptList: [SoongsilDeptCode.Soongsil.rawValue]))
    }
}
