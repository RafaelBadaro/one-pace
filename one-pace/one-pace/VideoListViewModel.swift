//
//  VideoListViewModel.swift
//  one-pace
//
//  Created by Rafael Badaró on 04/12/24.
//

import Foundation
class VideoListViewModel: ObservableObject {
    @Published var videoURLs: [URL] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let api = PixelDrainAPI()

    func fetchVideos() {
        isLoading = true
        errorMessage = nil

        Task {
            do {
                let urls = try await api.fetchVideosFromList(from: "5pVTECas") // Substitua pelo seu ID
                DispatchQueue.main.async {
                    self.videoURLs = urls
                    self.isLoading = false
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                    self.isLoading = false
                }
            }
        }
    }
}
