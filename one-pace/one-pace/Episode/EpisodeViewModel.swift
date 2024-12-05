//
//  EpisodeViewModel.swift
//  one-pace
//
//  Created by Rafael Badaró on 25/11/24.
//

import Foundation

class EpisodeViewModel {
    @Published var episode: Episode?
    
    init(episode: Episode? = nil) {
        self.episode = episode
    }
    
}
