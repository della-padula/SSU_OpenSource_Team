//
//  SKKUListParserEDU.swift
//  NoticeWorker
//
//  Created by 김태인 on 2020/05/15.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import Kanna

public class SKKUListEDUParser: DeptListParser {
    static func parseComputerList(page: Int, html: String) -> Result<[Notice], HTMLParseError> {
        
        return .failure(.notSupported)
    }
}
