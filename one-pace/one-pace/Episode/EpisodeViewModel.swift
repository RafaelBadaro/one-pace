//
//  EpisodeViewModel.swift
//  one-pace
//
//  Created by Rafael Badaró on 25/11/24.
//

import Foundation

class EpisodeViewModel : ObservableObject {
    private let api = PixelDrainAPI()
    @Published var episode: Episode
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
 
    init(episode: Episode) {
        self.episode = episode
    }
    
}
