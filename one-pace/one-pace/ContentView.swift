//
//  ContentView.swift
//  one-pace
//
//  Created by Rafael Badaró on 24/11/24.
//

import SwiftUI
import SwiftData
import AVFoundation
import AVKit

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
    @StateObject private var viewModel = VideoListViewModel()

    var body: some View {
        NavigationView {
            VStack {
                Text("Vídeos do Carrossel")
                    .font(.headline)
                    .padding()

                if viewModel.isLoading {
                    ProgressView("Carregando vídeos...")
                } else if let errorMessage = viewModel.errorMessage {
                    Text("Erro: \(errorMessage)")
                        .foregroundColor(.red)
                        .padding()
                } else {
                    ScrollView {
                        VStack(spacing: 20) {
                            ForEach(viewModel.videoURLs, id: \.self) { url in
                                VideoThumbnailView(videoURL: url)
                                    .frame(height: 200)
                                    .cornerRadius(10)
                                    .shadow(radius: 5)
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Carrossel de Vídeos")
        }
        .onAppear {
            viewModel.fetchVideos()
        }
    }
}


struct VideoThumbnailView: View {
    let videoURL: URL

    var body: some View {
        ZStack {
            VideoPlayerView(videoURL: videoURL)
            Color.black.opacity(0.3) // Sobreposição
                .onTapGesture {
                    playVideo(url: videoURL)
                }
        }
    }

    func playVideo(url: URL) {
        let player = AVPlayer(url: url)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player

        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first,
           let rootViewController = window.rootViewController {
            rootViewController.present(playerViewController, animated: true) {
                player.play()
            }
        }
    }
}

struct VideoPlayerView: UIViewControllerRepresentable {
    let videoURL: URL

    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let playerViewController = AVPlayerViewController()
        playerViewController.player = AVPlayer(url: videoURL)
        playerViewController.showsPlaybackControls = false
        return playerViewController
    }

    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        // Sem atualizações necessárias
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
