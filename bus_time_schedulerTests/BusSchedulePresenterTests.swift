//
//  BusSchedulePresenterTests.swift
//  bus_time_scheduler
//
//  Created by 林 明虎 on 2025/01/16.
//

import XCTest
@testable import bus_time_scheduler

class BusSchedulePresenterTests: XCTestCase {
    
    var presenter: BusSchedulePresenter!
    
    override func setUp() {
        super.setUp()
        presenter = BusSchedulePresenter(busSchedules: Constant.busSchedules)
    }

    override func tearDown() {
        presenter = nil
        super.tearDown()
    }
    
    // MARK: - toggleSelection(at:) メソッドのテスト
    func testToggleSelection_atValidIndex() {
        // 初期状態では何も選択されていない
        XCTAssertNil(presenter.currentSelectedIndex)
        
        // インデックス0のバススケジュールを選択
        presenter.toggleSelection(at: 0)
        XCTAssertEqual(presenter.currentSelectedIndex, 0)
        XCTAssertTrue(presenter.busSchedules[0].isSelected)
        
        // インデックス1のバススケジュールを選択
        presenter.toggleSelection(at: 1)
        XCTAssertEqual(presenter.currentSelectedIndex, 1)
        XCTAssertFalse(presenter.busSchedules[0].isSelected)
        XCTAssertTrue(presenter.busSchedules[1].isSelected)
        
        // インデックス1の選択を解除
        presenter.toggleSelection(at: 1)
        XCTAssertNil(presenter.currentSelectedIndex)
        XCTAssertFalse(presenter.busSchedules[1].isSelected)
    }
    
    func testToggleSelection_atInvalidIndex() {
        // 不正なインデックスを指定した場合
        presenter.toggleSelection(at: -1)
        presenter.toggleSelection(at: Constant.busSchedules.count)
        XCTAssertNil(presenter.currentSelectedIndex)
    }
    
    // MARK: - nearestScheduleIndex(currentTime:) メソッドのテスト
    func testNearestScheduleIndex_currentTimeBeforeFirstBus() {
        let index = presenter.nearestScheduleIndex(currentTime: "05:00")
        XCTAssertEqual(index, 0) // 最初のバススケジュールが返される
    }

    func testNearestScheduleIndex_currentTimeBetweenTwoBuses() {
        let index = presenter.nearestScheduleIndex(currentTime: "09:00")
        XCTAssertEqual(index, 4) // 09:00以降で最初に来るバスは09:10のため、4
    }

    func testNearestScheduleIndex_currentTimeAfterLastBus() {
        let index = presenter.nearestScheduleIndex(currentTime: "22:00")
        XCTAssertEqual(index, 0) // 22:00以降は残りのバススケジュールがないため次の日の最初のバスを示す0が返される
    }
    
    func testNearestScheduleIndex_currentTimeExactMatch() {
        let index = presenter.nearestScheduleIndex(currentTime: "10:06")
        XCTAssertEqual(index, 8) // 10:06のバスがちょうど一致する
    }
}
