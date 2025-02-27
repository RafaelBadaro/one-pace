//
//  ContentView.swift
//  one-pace
//
//  Created by Rafael Badaró on 24/11/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
    @State private var arcs: [Arc] = []
        
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(arcs, id: \.id) { currentArc in
                        NavigationLink(destination: ArcView(arc: currentArc)) {
                            ArcCardView(arcName: currentArc.name)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Arcs")
            .onAppear() {
                // Buscar só na primeira vez
                if arcs.isEmpty {
                    getAllArcsFromCsv()
                }
            }
            
        }
        
        
    }
    
    func getAllArcsFromCsv() {
        if let csvUrl = Bundle.main.url(forResource: "idAndArcNames", withExtension: ".csv") {
            if let idAndArcNames = try? String(contentsOf: csvUrl, encoding: .utf8) {
                let listOfIdAndArcNames = idAndArcNames.components(separatedBy: "\n")
                
                for i in 1..<listOfIdAndArcNames.count {
                    let idAndName = listOfIdAndArcNames[i].components(separatedBy: ",")
                    let id = idAndName[0]
                    let name = idAndName[1].replacingOccurrences(of: "\r", with: "")
                    arcs.append(Arc(id: id, name: name))
                }
                
                return
            }
        }
        
        fatalError("Could not load data from bundle.")
    }
    
}


#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
