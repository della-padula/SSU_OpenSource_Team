//
//  SKKUContentParserSW.swift
//  NoticeWorker
//
//  Created by 김태인 on 2020/05/15.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import Kanna

public class SKKUContentParserINFO: OrganizationContentParser {
    static func parseContentInformation(html: HTMLDocument) -> Result<NoticeContent, HTMLParseError> {
        return .failure(.notSupported)
    }
}
