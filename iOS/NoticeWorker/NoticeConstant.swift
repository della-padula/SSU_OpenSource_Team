//
//  NoticeConstant.swift
//  NoticeWorker
//
//  Created by TaeinKim on 2020/04/14.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation

public enum CollegeCode {
    case IT
    case Inmun
    case Engineering
    case Law
    case NaturalScience
    case Entrepreneurship
    case Economy
    case SocialScience
    case Convergence
    
    public enum ITCode {
        case Computer
        case Media
        case Software
        case SmartSystem
        case Eletronic
    }
    
    public enum LawCode {
        case Law
        case GlobalLaw
    }
}


public class NoticeConstant {
    public func getCode(code: CollegeCode.ITCode, college: CollegeCode) {
        
    }
    
    public func getComputerCode() {
        getCode(code: .Computer, college: .IT)
    }
}
