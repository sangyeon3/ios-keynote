//
//  SildeManagerTests.swift
//  MyKeynoteTests
//
//  Created by  sangyeon on 2023/07/19.
//

import XCTest
@testable import MyKeynote

final class SildeManagerTests: XCTestCase {
    
    private var sut: SlideManager!

    override func setUpWithError() throws {
        sut = SlideManager(factory: SlideFactory())
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_새로운슬라이드생성시_내부에추가되는지() {
        // when
        _ = sut.addSlide(type: SquareSlide.self)
        
        // then
        XCTAssertEqual(sut.numberOfSlide, 1)
    }
    
    func test_서브스크립트접근시_슬라이드를리턴하는지() {
        // given
        let newSlide = sut.addSlide(type: SquareSlide.self)
        
        // when
        guard let addedSlide = sut[0] else {
            XCTFail()
            return
        }
        
        // then
        XCTAssertTrue(newSlide.isEqual(with: addedSlide))
    }
    
    func test_전달된slideID에해당하는_슬라이드를반환하는지() {
        // given
        let newSlide = sut.addSlide(type: SquareSlide.self)
        
        // when
        guard let foundSlide = sut.slide(havingID: newSlide.id) else {
            XCTFail()
            return
        }
        
        // then
        XCTAssertTrue(foundSlide.isEqual(with: newSlide))
    }
}
