//
//  ArcView.swift
//  one-pace
//
//  Created by Rafael Badaró on 12/12/24.
//

import SwiftUI

struct ArcView: View {
    @ObservedObject private var viewModel: ArcViewModel
    
    init(viewModel: ArcViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Carregando vídeos...")
                } else if let errorMessage = viewModel.errorMessage {
                    Text("Erro: \(errorMessage)")
                        .foregroundColor(.red)
                        .padding()
                } else {
                    ScrollView {
                        VStack(spacing: 20) {
                            ForEach(viewModel.arc.episodes) { episode in
                                Text("\(episode.name)")
                            }
                        }
                        .padding()
                    }
                }
            }
        }
        .navigationTitle(viewModel.arc.name)
        .onAppear {
            Task {
                await viewModel.fetchEpisodes()
            }
        }
    }
}

//#Preview {
//    ArcView()
//}
