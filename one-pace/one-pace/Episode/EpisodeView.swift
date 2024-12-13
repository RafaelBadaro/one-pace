//
//  EpisodeView.swift
//  one-pace
//
//  Created by Rafael Badaró on 25/11/24.
//

import SwiftUI

struct EpisodeView: View {
    @ObservedObject private var viewModel: EpisodeViewModel
    
    init(viewModel: EpisodeViewModel) {
        self.viewModel = viewModel
    }
    
//    @State private var episodeViewModel = EpisodeViewModel()
//    
//    let url = "https://pixeldrain.com/api/file/PZ2RNRUW"
    
    var body: some View {
        NavigationStack {
            Text(viewModel.episode.name)
            Text(viewModel.episode.url)
        }
        .navigationTitle(viewModel.episode.name)

    }
}

//#Preview {
//    EpisodeView()
//}
