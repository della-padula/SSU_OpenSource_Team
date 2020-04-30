//
//  SoongsilListParser.swift
//  NoticeWorker
//
//  Created by Denny on 2020/04/30.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation

public class SoongsilListParser {
    static func parseNoticeList(dept: DeptItem, page: Int, html: String) -> Result<[Notice], HTMLParseError> {
        switch dept {
        case SoongsilDept.IT_Computer:
            return SoongsilITParser.parseCSEList(page: page, html: html)
        case SoongsilDept.IT_Media:
            return SoongsilITParser.parseMediaList(page: page, html: html)
        case SoongsilDept.IT_Electric:
            return SoongsilITParser.parseElecList(page: page, html: html)
        case SoongsilDept.IT_Software:
            return SoongsilITParser.parseSmartSWList(page: page, html: html)
        case SoongsilDept.IT_SmartSystem:
            return SoongsilITParser.parseSWList(page: page, html: html)
        case SoongsilDept.LAW_Law:
            break
        case SoongsilDept.LAW_IntlLaw:
            break
        default:
            break
        }
        return .failure(.emptyContent)
    }
    // MARK: TEMP NEED TO BE REPAIRED
    static func parseNoticeContent(dept: DeptItem, html: String) -> Result<NoticeContent, HTMLParseError> {
        switch dept {
        case SoongsilDept.IT_Computer:
            return .failure(.emptyContent)
        case SoongsilDept.IT_Media:
            return .failure(.emptyContent)
        case SoongsilDept.IT_Electric:
            return .failure(.emptyContent)
        case SoongsilDept.IT_Software:
            return .failure(.emptyContent)
        case SoongsilDept.IT_SmartSystem:
            return .failure(.emptyContent)
        case SoongsilDept.LAW_Law:
            break
        case SoongsilDept.LAW_IntlLaw:
            break
        default:
            break
        }
        return .failure(.emptyContent)
    }
}
