//
//  SeoulNationalContenrParserEDU.swift
//  NoticeWorker
//
//  Created by 김태인 on 2020/05/14.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import Kanna

public class SeoulNationalContentParserEDU: OrganizationContentParser {
    static func parseContentMath(html: HTMLDocument) -> Result<NoticeContent, HTMLParseError> {
        return .failure(.notSupported)
    }
}