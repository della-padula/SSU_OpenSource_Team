//
//  NoticeWorkerManager.swift
//  NoticeWorker
//
//  Created by Denny on 2020/04/30.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation

// Notice Worker Extension
// Author : Taein Kim
// Description : 새로운 학교가 추가될 경우 여기에도 추가를 해주어야 한다.
// 여기에 추가되지 않으면 학교 목록에서 학교 정보를 가져올 수 없으며 추가되지 않은 학교 데이터는 사용할 수 없다.

extension NoticeWorker {
    func setOrganizationList() {
        organizationList.append(NW_Soongsil())
        organizationList.append(NW_SeoulNational())
        organizationList.append(NW_SKKU())
    }
}

// Property (need to be added)
// Author : Taein Kim
// Description : 이 부분도 마찬가지로 새로운 학교가 추가되면 위와 마찬가지로 추가되어야 한다.

public enum OrganizationCode: Int {
    case Soongsil
    case SKKU
    case SeoulNational
}
