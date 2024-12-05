//
//  EpisodeView.swift
//  one-pace
//
//  Created by Rafael Badaró on 25/11/24.
//

import SwiftUI

struct EpisodeView: View {
    
    @State private var episodeViewModel = EpisodeViewModel()
    
    let url = "https://pixeldrain.com/api/file/PZ2RNRUW"
    
    var body: some View {
        VideoPlayerView(videoURL: URL(string: url)!)
            .frame(height: 300)
            .cornerRadius(10)
            .padding()
    }
}

#Preview {
    EpisodeView()
}
