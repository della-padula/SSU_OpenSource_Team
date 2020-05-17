//
//  NoticeWorkerManager.swift
//  NoticeWorker
//
//  Created by Denny on 2020/04/30.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation

extension NoticeWorker {
    func setOrganizationList() {
        organizationList.append(NW_Soongsil())
        organizationList.append(NW_SeoulNational())
        organizationList.append(NW_SKKU())
    }
}

// Property (need to be added)
public enum OrganizationCode: Int {
    case Soongsil
    case SKKU
    case SeoulNational
}
