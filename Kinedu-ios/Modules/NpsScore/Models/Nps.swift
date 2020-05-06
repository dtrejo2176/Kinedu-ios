//
//  NpsData.swift
//  KineduPOC
//
//  Created by David Trejo on 3/27/20.
//  Copyright © 2020 David Trejo. All rights reserved.
//

import Foundation

struct Nps {
    let id: Int
    let nps: Int
    let daysSinceSignup: Int
    let userPlan: String
    let activityViews: Int
    let build: Build
    
    struct Build {
        let version: String
        let releaseDate: String
    }
}

extension Nps {
    struct CodingData: Decodable {
        let id: Int
        let nps: Int
        let daysSinceSignup: Int
        let userPlan: String
        let activityViews: Int
        let build: Build.CodingData
        
        enum CodingKeys: String, CodingKey {
            case id
            case nps
            case daysSinceSignup = "days_since_signup"
            case userPlan = "user_plan"
            case activityViews = "activity_views"
            case build
        }
    }
}

extension Nps.Build {
    struct CodingData: Decodable {
        let version: String
        let releaseDate: String
        
        enum CodingKeys: String, CodingKey {
            case version
            case releaseDate = "release_date"
        }
    }
}

extension Nps.CodingData {
    var npsAux: Nps {
        let build = Nps.Build(version: self.build.version,
                              releaseDate: self.build.releaseDate)
        return Nps(id: self.id,
                   nps: self.nps,
                   daysSinceSignup: self.daysSinceSignup,
                   userPlan: self.userPlan,
                   activityViews: self.activityViews,
                   build: build)
    }
}
