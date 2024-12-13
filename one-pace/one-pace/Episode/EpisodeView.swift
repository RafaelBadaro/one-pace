//
//  EpisodeView.swift
//  one-pace
//
//  Created by Rafael Badaró on 25/11/24.
//

import SwiftUI
import AVKit

struct EpisodeView: View {
    @ObservedObject private var viewModel: EpisodeViewModel
    
    init(viewModel: EpisodeViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.blue.opacity(0.3)
                if let url = URL(string: viewModel.episode.url) {
                    VideoPlayerView(url: url)
                        .frame(height: 300)
                        .cornerRadius(10)
                        .padding()
                } else {
                    Text("URL inválida")
                        .foregroundColor(.red)
                }
            }
        }
        .navigationTitle(viewModel.episode.name)
    }
}

// Representa o AVPlayerViewController no SwiftUI
struct VideoPlayerView: UIViewControllerRepresentable {
    let url: URL
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let playerViewController = AVPlayerViewController()
        let player = AVPlayer(url: url)
        
        playerViewController.player = player
        playerViewController.showsPlaybackControls = true // Controles de reprodução
        player.automaticallyWaitsToMinimizeStalling = true // Reduz travamentos
        player.volume = 1.0 // Garante que o som está no máximo
        
        return playerViewController
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        // Atualize se necessário
    }
}

//#Preview {
//    EpisodeView()
//}
