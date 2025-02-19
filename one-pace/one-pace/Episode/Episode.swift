//
//  Episode.swift
//  one-pace
//
//  Created by Rafael Badaró on 25/11/24.
//

import Foundation
import SwiftData

@Model
final class Episode {

    @Attribute(.unique) var id: String
    var pixelDrainName: String
    var url: String
    var arcID: String
    
    var onePaceEpisodeName: String
    var onePieceEpisodes: String
    
    var createdAt: Date
    
    init(id: String, pixelDrainName: String, url: String, arcID: String) {
        self.id = id
        self.pixelDrainName = pixelDrainName
        self.url = url
        self.arcID = arcID
        self.onePaceEpisodeName = Self.getOnePaceEpisodeName(pixelDrainName)
        self.onePieceEpisodes = Self.getOnePieceEpisodes(pixelDrainName)
        self.createdAt = Date()
    }
        
    private static func getOnePaceEpisodeName(_ pixelDrainName: String) -> String {
        let regex = try! NSRegularExpression(pattern: "\\[([0-9]+-[0-9]+|[0-9]+)] ([A-Za-z ]+ [0-9]+)", options: [])
        
        // Busca pela expressão regular
        if let match = regex.firstMatch(in: pixelDrainName, options: [], range: NSRange(location: 0, length: pixelDrainName.utf16.count)) {
            let onePaceEpisodeRange = match.range(at: 2)    // Captura o segundo grupo (nome do episódio)
            
            if let onePaceEpisode = Range(onePaceEpisodeRange, in: pixelDrainName) {
                let episodeName = pixelDrainName[onePaceEpisode]  // Ex: "Wano 01"
                return String(episodeName) // Retorna o nome do episódio
            }
        }
        
        return "" // Caso não encontre, retorna uma string vazia
    }

    private static func getOnePieceEpisodes(_ pixelDrainName: String) -> String {
        let regex = try! NSRegularExpression(pattern: "\\[([0-9]+-[0-9]+|[0-9]+)]", options: [])
        
        // Busca pela expressão regular
        if let match = regex.firstMatch(in: pixelDrainName, options: [], range: NSRange(location: 0, length: pixelDrainName.utf16.count)) {
            let onePieceEpisodesRange = match.range(at: 1)  // Captura o primeiro grupo (episódios)
            
            if let onePieceEpisodes = Range(onePieceEpisodesRange, in: pixelDrainName) {
                let episodes = pixelDrainName[onePieceEpisodes]  // Ex: "909-910"
                return String(episodes)
            }
        }
        
        return "" // Caso não encontre, retorna uma string vazia
    }
    
}
