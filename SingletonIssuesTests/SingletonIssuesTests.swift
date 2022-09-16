//
//  SingletonIssuesTests.swift
//  SingletonIssuesTests
//
//  Created by Dylan Sewell on 9/16/22.
//

import XCTest
@testable import SingletonIssues

class Tracker {
    
    let analytics: Analytics
    
    init(analytics: Analytics) {
        self.analytics = analytics
    }
    
    func track(event: String) {
        analytics.log(event: event)
    }
}

protocol Analytics {
    func log(event: String)
}

class MixpanelSDK: Analytics {
    var events = [String]()
        
    func log(event: String) {
        events.append(event)
        print("---event: \(event)---")
    }
}

class SingletonIssuesTests: XCTestCase {
    
    func test_init_doesNotLogData() {
        let analytics = AnalyticsSpy()
        let _ = Tracker(analytics: analytics)
        
        XCTAssertEqual(analytics.events.count, 0)
    }
    
    func test_log_capturesData() {
        let analytics = AnalyticsSpy()
        let sut = Tracker(analytics: analytics)

        sut.track(event: "Button tap")

        XCTAssertEqual(analytics.events.count, 1)
    }

    func test_log_capturedDataIsAccurate() {
        let analytics = AnalyticsSpy()
        let sut = Tracker(analytics: analytics)

        sut.track(event: "Signed up")

        XCTAssertEqual(analytics.events, ["Signed up"])
    }
    
    class AnalyticsSpy: Analytics {
        var events = [String]()
        
        func log(event: String) {
            events.append(event)
        }

    }

}
