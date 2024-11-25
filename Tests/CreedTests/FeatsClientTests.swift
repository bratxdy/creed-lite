//
//  File.swift
//  
//
//  Created by Andrew Hulsizer on 1/22/24.
//

import Foundation
import Creed_Lite
import XCTest

class FeatsClientTests: XCTestCase {
        
    func test_MonthlyFeats_JSONParsing() async throws {
        let client = FeatsClient.testValue
        let monthlyFeats = try await client.listMonthlyFeats()
        
        XCTAssertEqual(monthlyFeats.title, "Feats of Strength")
        XCTAssertEqual(monthlyFeats.feats.count, 4)
    }
    
    func test_LeaderBoard_JSONParsing() async throws {
        let client = FeatsClient.testValue
        let leaderboard = try await client.getFeatLeaderboard(Feat.Id(rawValue: "1"))
        
        XCTAssertEqual(leaderboard.placements.count, 25)
    }
}
