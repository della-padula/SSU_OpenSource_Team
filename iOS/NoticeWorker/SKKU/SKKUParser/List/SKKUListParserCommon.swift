//
//  SKKUListParserCommon.swift
//  NoticeWorker
//
//  Created by 김태인 on 2020/05/15.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import Kanna

public class SKKUListParserCommon: DeptListParser {
    static func parseSKKUList(page: Int, html: String) -> Result<[Notice], HTMLParseError> {
        cleanList()
        return .failure(.notSupported)
    }
}
