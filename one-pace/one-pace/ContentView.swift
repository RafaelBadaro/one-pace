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
    
    //TODO: criar isso na mao ou descobrir um jeito legal
    let arcs: [Arc] = [
        Arc(id: "", name: "Dressrosa"),
        Arc(id: "5pVTECas", name: "Whole Cake Island")
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(arcs) { currentArc in
                        NavigationLink(destination: ArcView(viewModel: ArcViewModel(arc: currentArc))) {
                            Text(currentArc.name)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Arcs")
        }
    }
}


struct VideoThumbnailView: View {
    let videoURL: URL
    
    var body: some View {
        ZStack {
            VideoPlayerView(videoURL: videoURL)
            Color.black.opacity(0.3)
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
