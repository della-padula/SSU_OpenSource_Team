//
//  SKKUContentParserBIO.swift
//  NoticeWorker
//
//  Created by 김태인 on 2020/05/15.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import Kanna

public class SKKUContentParserBIO: OrganizationContentParser {
    static func parseContentBioMeca(html: HTMLDocument) -> Result<NoticeContent, HTMLParseError> {
        return .failure(.notSupported)
    }
}
