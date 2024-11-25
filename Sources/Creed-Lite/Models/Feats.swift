//
//  Feats.swift
//  Creed-Lite
//
//  Created by Andrew Hulsizer on 11/24/24.
//
import Tagged
import Foundation

public struct MonthlyFeats: APIModel {
    
    public typealias Id = Tagged<Self, String>
    
    public let id: Id
    public let title: String
    public let subtitle: String
    public let feats: [Feat]
}

public struct FeatLeaderBoardPlacement: APIModel {
    
    public enum Movement: String, Decodable, Sendable {
        case up
        case down
        case neutral
    }
    
    public typealias Id = Tagged<Self, String>
    public let id: Id
    public let imageURL: URL
    public let name: String
    public let totalRepCount: Int
    public let movement: Movement
    public let placement: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case imageURL = "image_url"
        case name
        case totalRepCount = "total_rep_count"
        case movement
        case placement
    }
}

public struct Feat: APIModel {
    
    public typealias Id = Tagged<Self, String>
    
    public let id: Id
    public let name: String
    public let description: String
    public let imageURL: URL
    public let videoURL: URL
    public let completionCount: Int
    public let top3Users: [FeatUser]
    public let movement: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case imageURL = "image_url"
        case videoURL = "video_url"
        case completionCount = "completion_count"
        case top3Users = "top_3_users"
        case movement
    }
}

public struct FeatUser: APIModel {
    
    public typealias Id = Tagged<Self, String>
    
    public let id: Id
    public let imageURL: URL
    
    enum CodingKeys: String, CodingKey {
        case id
        case imageURL = "image_url"
    }
}

public struct FeatLeaderboard: APIModel {
    
    public typealias Id = Tagged<Self, String>
    
    public let id: Id
    public let name: String
    public let placements: [FeatLeaderBoardPlacement]
}
