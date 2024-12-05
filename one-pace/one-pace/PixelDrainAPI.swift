//
//  PixelDrainAPI.swift
//  one-pace
//
//  Created by Rafael Badaró on 04/12/24.
//

import Foundation

struct PixelDrainVideo: Decodable {
    let id: String
    let name: String
}

struct PixelDrainListResponse: Decodable {
    let files: [PixelDrainVideo]
}

class PixelDrainAPI {
    func fetchVideosFromList(from listID: String) async throws -> [URL] {
        let urlString = "https://pixeldrain.com/api/list/\(listID)"
        guard let url = URL(string: urlString) else {
            throw PixelDrainError.invalidURL
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let listResponse = try JSONDecoder().decode(PixelDrainListResponse.self, from: data)
        return listResponse.files.compactMap { URL(string: "https://pixeldrain.com/api/file/\($0.id)") }
    }
    
    // TODO: fazer esse metodo
    func fetchVideoById(_ id: String){
        
    }
    
    enum PixelDrainError: Error {
        case invalidURL
        case noData
    }
}
