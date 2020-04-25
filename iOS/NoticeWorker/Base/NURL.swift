//
//  NURL.swift
//  NoticeWorker
//
//  Created by 김태인 on 2020/04/24.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation

public class EuckrUtil {
    static func euckrEncoding(_ query: String?) -> String? {
        let rawEncoding = CFStringConvertEncodingToNSStringEncoding(CFStringEncoding(CFStringEncodings.EUC_KR.rawValue))
        let encoding = String.Encoding(rawValue: rawEncoding)
        
        let eucKRStringData = query?.data(using: encoding) ?? Data()
        let outputQuery = eucKRStringData.map { byte -> String in
            if byte >= UInt8(ascii: "A") && byte <= UInt8(ascii: "Z") || byte >= UInt8(ascii: "a") && byte <= UInt8(ascii: "z") || byte >= UInt8(ascii: "0") && byte <= UInt8(ascii: "9") || byte == UInt8(ascii: "_") || byte == UInt8(ascii: ".") || byte == UInt8(ascii: "-") {
                return String(Character(UnicodeScalar(UInt32(byte))!))
            } else if byte == UInt8(ascii: " ") {
                return "%20"
            } else {
                return String(format: "%%%02X", byte)
            }
        }.joined()
        
        return outputQuery
    }
}
