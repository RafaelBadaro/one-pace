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
        NavigationStack {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Carregando vídeos...")
                        .padding()
                } else if let errorMessage = viewModel.errorMessage {
                    Text("Erro: \(errorMessage)")
                        .foregroundColor(.red)
                        .padding()
                } else {
                    ScrollView {
                        ForEach(viewModel.arc.episodes, id: \.id) { currentEpisode in
                            NavigationLink(destination:
                                            EpisodeView(viewModel: EpisodeViewModel(episode: currentEpisode))) {
                                
                                VStack(alignment: .leading) {
                                    Text(currentEpisode.onePaceEpisodeName)
                                        .font(.title)
                                    Text("One piece eps: \(currentEpisode.onePieceEpisodes)")
                                        .font(.subheadline)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                                .background(.thinMaterial)
                                
                            }
                        }
                    }
                    .navigationTitle(viewModel.arc.name)
                    .onAppear {
                        if viewModel.arc.episodes.isEmpty {
                            Task {
                                await viewModel.fetchEpisodes()
                            }
                        } else {
                            print("Já fiz o fetch")
                        }
                    }
                }
            }
        }
    }
}

//#Preview {
//    ArcView()
//}
