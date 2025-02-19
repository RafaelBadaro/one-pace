//
//  ArcView.swift
//  one-pace
//
//  Created by Rafael Badaró on 12/12/24.
//

import SwiftUI
import SwiftData

struct ArcView: View {
    @Environment(\.modelContext) private var modelContext
    @ObservedObject private var viewModel: ArcViewModel
    
    init(arc: Arc) {
        self.viewModel = ArcViewModel(arc: arc)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if self.viewModel.isLoading {
                    ProgressView("Carregando vídeos...")
                        .padding()
                } else if let errorMessage = self.viewModel.errorMessage {
                    Text("Erro: \(errorMessage)")
                        .foregroundColor(.red)
                        .padding()
                } else {
                    ScrollView {
                        ForEach(self.viewModel.arc.episodes, id: \.id) { currentEpisode in
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
                }
            }
            .navigationTitle(self.viewModel.arc.name)
            .onAppear {
                if self.viewModel.arc.episodes.isEmpty {
                    Task {
                        self.viewModel.arc.episodes = await fetchEpisodes()
                    }
                } else {
                    print("Já fiz o fetch")
                }
            }
        }
    }
    
    func fetchEpisodes() async -> [Episode] {
        viewModel.isLoading = true
        viewModel.errorMessage = nil
        
        if let espisodesFromDB = fetchEpisodesFromDB(), !espisodesFromDB.isEmpty {
            print("Fiz o fetch pelo DB")
            viewModel.isLoading = false

            return espisodesFromDB
        }
        
        if let episodesFromAPI = await viewModel.fetchEpisodesFromAPI() {
            
            //Salva no DB
            episodesFromAPI.forEach { episode in
                modelContext.insert(episode)
            }
            viewModel.isLoading = false
            print("Fiz o fetch pela API")
            return episodesFromAPI
        }
        
        // Tratar aqui de maneira correta
        return []
    }
    
    func fetchEpisodesFromDB() -> [Episode]? {
        //Tenta buscar no banco
        
        let arcID = self.viewModel.arc.id
        
        let descriptor = FetchDescriptor<Episode>(
            predicate: #Predicate<Episode> { episode in
                episode.arcID == arcID
            },
            sortBy: [SortDescriptor(\.onePaceEpisodeName)]
        )
        
        do {
            let episodes = try modelContext.fetch(descriptor)
            return episodes
        } catch {
            print("Erro ao buscar episódios do banco: \(error)")
            self.viewModel.errorMessage = error.localizedDescription
            return nil
        }
    }
}

//#Preview {
//    ArcView()
//}
