//
//  ArcViewModel.swift
//  one-pace
//
//  Created by Rafael Badaró on 12/12/24.
//

import Foundation
import SwiftUICore

@MainActor
class ArcViewModel : ObservableObject {
    private let api = PixelDrainAPI()
    @Published var arc: Arc
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    init(arc: Arc) {
        self.arc = arc
    }
    
    func fetchEpisodes() async {
        isLoading = true
        errorMessage = nil

        do {
            let response = try await api.fetchVideosFromList(from: self.arc.id)
            let episodes = response.files.map { pixelDrainVideo in
                return EpisodeTest(
                    id: pixelDrainVideo.id,
                    name: pixelDrainVideo.name,
                    url: "https://pixeldrain.com/api/file/\(pixelDrainVideo.id)"
                )
            }
            self.arc.pixelDrainTitle = response.title
            self.arc.episodes = episodes
            self.isLoading = false
        } catch {
            self.errorMessage = error.localizedDescription
            self.isLoading = false
        }
    }
}
