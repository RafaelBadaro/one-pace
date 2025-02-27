//
//  EpisodeView.swift
//  one-pace
//
//  Created by Rafael Badaró on 25/11/24.
//

import SwiftUI
import AVKit
import AVFoundation

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
        .navigationTitle(viewModel.episode.onePaceEpisodeName)
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
        
        // Configura o AVAudioSession para permitir reprodução no modo silencioso
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Erro ao configurar AVAudioSession: \(error.localizedDescription)")
        }
        
        return playerViewController
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        // Atualize se necessário
    }
}

//#Preview {
//    EpisodeView()
//}
