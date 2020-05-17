//
//  ResultCode.swift
//  NoticeWorker
//
//  Created by 김태인 on 2020/04/24.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation

public enum URLGenerateError: Error {
    case invalid
    case emptyKeyword
}

public enum HTMLParseError: Error {
    case encoding
    case emptyContent
    case notSupported
}
