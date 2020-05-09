//
//  SoongsilContentParser.swift
//  NoticeWorker
//
//  Created by 김태인 on 2020/05/06.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import Kanna

public class SoongsilContentParser {
    static func parseNoticeContent(dept: DeptItem, html: String) -> Result<NoticeContent, HTMLParseError> {
        do {
            let doc = try HTML(html: html, encoding: .utf8)
            switch dept {
            case SoongsilDept.IT_Computer:
                return SoongsilContentParserIT.parseContentCSE(html: doc)
            case SoongsilDept.IT_Media:
                return SoongsilContentParserIT.parseContentMedia(html: doc)
            case SoongsilDept.IT_Electric:
                return SoongsilContentParserIT.parseContentElectric(html: doc)
            case SoongsilDept.IT_Software:
                return SoongsilContentParserIT.parseContentSoftware(html: doc)
            case SoongsilDept.IT_SmartSystem:
                return SoongsilContentParserIT.parseContentSmartSW(html: doc)
            case SoongsilDept.LAW_IntlLaw:
                return SoongsilContentParserLAW.parseContentIntlLAW(html: doc)
            case SoongsilDept.LAW_Law:
                return SoongsilContentParserLAW.parseContentLAW(html: doc)
            default:
                return .failure(.notSupported)
            }
        } catch {
            return .failure(.encoding)
        }
    }
}
