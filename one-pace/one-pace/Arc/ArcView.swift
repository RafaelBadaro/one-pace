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
                                // TODO: fazer com que isso seja uma view separada tipo "EpisodeCardView"
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(currentEpisode.onePaceEpisodeName)
                                            .font(.title)
                                        Text("One piece eps: \(currentEpisode.onePieceEpisodes)")
                                            .font(.subheadline)
                                        
                                    }
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        markEpisodeAsWatched(episode: currentEpisode)
                                    }) {
                                        Image(systemName: currentEpisode.hasBeenWatched ? "checkmark.circle" : "circle")
                                            .font(.title2)
                                    }

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
        
        if let episodesFromDB = fetchEpisodesFromDB(),
            !episodesFromDB.isEmpty {
            viewModel.isLoading = false
            print("Fiz o fetch pelo DB")
            return episodesFromDB
        }
        
        if let episodesFromAPI = await viewModel.fetchEpisodesFromAPI() {
            saveEpisodesToDB(episodesFromAPI)
            viewModel.isLoading = false
            print("Fiz o fetch pela API")
            return episodesFromAPI
        }
        
        viewModel.errorMessage = "Failed to fetch episodes from both DB and API."
        viewModel.isLoading = false
        return []
    }
    
    private func fetchEpisodesFromDB() -> [Episode]? {
        //Tenta buscar no banco
        let arcID = self.viewModel.arc.id
        let descriptor = FetchDescriptor<Episode>(
            predicate: #Predicate<Episode> { episode in
                episode.arcID == arcID
            },
            sortBy: [SortDescriptor(\.onePaceEpisodeName)]
        )
        
        do {
            return try modelContext.fetch(descriptor)
        } catch {
            print("Erro ao buscar episódios do banco: \(error)")
            self.viewModel.errorMessage = error.localizedDescription
            return nil
        }
    }
    
    private func saveEpisodesToDB(_ episodes: [Episode]) {
        episodes.forEach { episode in
            modelContext.insert(episode)
        }
    }
    
    private func markEpisodeAsWatched(episode: Episode) {
        episode.hasBeenWatched.toggle()
        do {
            // Salvar as mudanças no banco de dados
            try modelContext.save()
        } catch {
            // Tratar o erro, se necessário
            print("Erro ao salvar alterações: \(error)")
            self.viewModel.errorMessage = error.localizedDescription
        }
    }
}

//#Preview {
//    ArcView()
//}
