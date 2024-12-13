//
//  Episode.swift
//  one-pace
//
//  Created by Rafael Badaró on 25/11/24.
//

import Foundation
import SwiftData

@Model
final class Episode  {
    /**
        Exemplo de URL com o Whole cake island
     
     EP 1
     https://pixeldrain.com/l/5pVTECas#item=0
     
     url = https://pixeldrain.com
     local = /l -> isso é um L
     id = /5pVTECas
     selector = #item=0
     
     EP 2
     
     https://pixeldrain.com/l/5pVTECas#item=1
     
     url = https://pixeldrain.com
     local = /l -> isso é um L
     id = /5pVTECas
     selector = #item=1
     
     O id é o mesmo, o que muda é o o item selecionado. Ou seja o id é um ID do ARCO
     porém eu sei que é possivel acessar de alguma maneira o video por si só, TODO: ver como
     
     O id do episodo seguindo essa logica é "5pVTECas#item=1" que representa basicamente arco/episodio
     
     LEMBRETE: SEMPRE É UM A MAIS (+1), POIS COMECA NO EP 1, MAS PROGRAMACAO E ETC FAZ COM QUE COMECE NO 0
     
     */
    
    var episodePixelDrainID: String // O valor na query
    var title: String
    var descriptionOfEpisode: String?
    var image: String?
    
    init(episodePixelDrainID: String, title: String, description: String? = nil, image: String? = nil) {
        self.episodePixelDrainID = episodePixelDrainID
        self.title = title
        self.descriptionOfEpisode = description
        self.image = image
    }
    
    
    func fetchEpisodeData(){
        
    }
    
}
