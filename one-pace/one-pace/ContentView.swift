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
    
    //TODO: criar isso na mao ou descobrir um jeito legal
    let arcs: [Arc] = [
        Arc(id: "", name: "Dressrosa"),
        Arc(id: "5pVTECas", name: "Whole Cake Island")
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(arcs) { currentArc in
                        NavigationLink(destination: ArcView(viewModel: ArcViewModel(arc: currentArc))) {
                            Text(currentArc.name)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Arcs")
        }
    }
}


#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
