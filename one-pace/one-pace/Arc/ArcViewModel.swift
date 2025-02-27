//
//  ArcViewModel.swift
//  one-pace
//
//  Created by Rafael Badaró on 12/12/24.
//

import Foundation
import SwiftUICore
import SwiftData

@MainActor
class ArcViewModel : ObservableObject {
    private let api = PixelDrainAPI()
    @Published var arc: Arc
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    init(arc: Arc) {
        self.arc = arc
    }
    
    func fetchEpisodesFromAPI() async -> [Episode]? {
        do {
            let response = try await api.fetchVideosFromList(from: self.arc.id)
            let episodes = response.files.map { pixelDrainVideo in
                let episode = Episode(
                    id: pixelDrainVideo.id,
                    pixelDrainName: pixelDrainVideo.name,
                    url: "https://pixeldrain.com/api/file/\(pixelDrainVideo.id)",
                    arcID: self.arc.id
                )
                return episode
            }
            
            return episodes
        } catch {
            self.errorMessage = error.localizedDescription
            return nil
        }
    }
}
