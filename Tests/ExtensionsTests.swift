//
//  ExtensionsTests.swift
//  FramezillaTests
//
//  Created by Стас Клюхин on 09/07/2019.
//

import XCTest

class ExtensionsTests: BaseTest {

    private struct TestOptionSet: OptionSet, CustomStringConvertible {
        let rawValue: Int
        
        static let option1: TestOptionSet = .init(rawValue: 1 << 0)
        static let option2: TestOptionSet = .init(rawValue: 1 << 1)
        static let option3: TestOptionSet = .init(rawValue: 1 << 2)
        
        static let combinedOption: TestOptionSet = [.option1, .option3]
        
        static let all: TestOptionSet = [.combinedOption, .option2]
        
        init(rawValue: Int) {
            self.rawValue = rawValue
        }
        
        public var description: String {
            switch self {
            case .option1:
                return "option1"
            case .option2:
                return "option2"
            case .option3:
                return "option3"
            case .combinedOption:
                return "combinedOption"
            case .all:
                return "all"
            default:
                return "default"
            }
        }
    }
    
    func testOptionSetForEach() {
        let optionSets: [TestOptionSet] = [.all, .option1, .combinedOption]
        let allOptionsCount = 3
        let combinedOptionsCount = 2
        optionSets.forEach { options in
            var iterationsCount = 0
            options.forEach({ option in
                iterationsCount += 1
                XCTAssert(options.contains(option))
            })
            switch options {
            case .all:
                XCTAssertEqual(iterationsCount, allOptionsCount)
            case .option1:
                XCTAssertEqual(iterationsCount, 1)
            case .combinedOption:
                XCTAssertEqual(iterationsCount, combinedOptionsCount)
            default:
                XCTAssertNil(nil)
            }
        }
    }
}
