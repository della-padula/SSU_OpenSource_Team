//
//  SoongsilLawParser.swift
//  NoticeWorker
//
//  Created by Denny on 2020/04/30.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import Kanna

public class SoongsilLawParser: SoongsilDeptParser {
    static func parseLAWList(page: Int, html: String) -> Result<[Notice], HTMLParseError> {
        var index = 0
        cleanList()
        
        return .failure(.emptyContent)
    }
    
    static func parseINTLAWList(page: Int, html: String) -> Result<[Notice], HTMLParseError> {
        var index = 0
        cleanList()
        
        return .failure(.emptyContent)
    }
}
