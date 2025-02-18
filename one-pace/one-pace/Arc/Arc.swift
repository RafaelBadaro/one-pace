//
//  Arc.swift
//  one-pace
//
//  Created by Rafael Badaró on 12/12/24.
//

import Foundation

class Arc : Identifiable {
    let id: String
    let name: String
    var pixelDrainTitle: String = ""
    var episodes: [Episode] = []
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}
