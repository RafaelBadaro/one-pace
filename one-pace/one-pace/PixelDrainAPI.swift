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
    let title: String
    let files: [PixelDrainVideo]
}

class PixelDrainAPI {
    func fetchVideosFromList(from listID: String) async throws -> PixelDrainListResponse {
        let urlString = "https://pixeldrain.com/api/list/\(listID)"
        guard let url = URL(string: urlString) else {
            throw PixelDrainError.invalidURL
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        
        // MARK: se quiser ver o json descomentar abaixo
//        if let jsonString = String(data: data, encoding: .utf8) {
//            print("\(jsonString)")
//        }
        
        let listResponse = try JSONDecoder().decode(PixelDrainListResponse.self, from: data)
        return listResponse
    }
    
    func fetchVideoById(_ id: String) async throws -> PixelDrainVideo {
        let urlString = "https://pixeldrain.com/api/file/\(id)"
        guard let url = URL(string: urlString) else {
            throw PixelDrainError.invalidURL
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let videoResponse = try JSONDecoder().decode(PixelDrainVideo.self, from: data)
        return videoResponse
    }
    
    enum PixelDrainError: Error {
        case invalidURL
        case noData
    }
}
