//
//  ContentView.swift
//  daweiba
//
//  Created by 潘建勋 on 2024-07-31.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) private var modelContext
        
    @Query private var acnts: [Account]
    
    @State private var searchText: String = ""
        
    var body: some View {
        NavigationStack {
            List {
                let showAcnts = filteredAccounts()
                ForEach(showAcnts, id: \.id) { acnt in
                    NavigationLink {
                        AccountView(acnt: acnt)
                    } label: {
                        AccountListEntryLabel(acnt: acnt)
                    }
                }
                .onDelete(perform: deleteAcnt)
            }
            .searchable(text: $searchText, prompt: "Title")
            .navigationTitle("Top Secret")
            .toolbar {
                ToolbarItem {
                    NavigationLink {
                        AddAccountView(acnt: Account())
                    } label: {
                        Label("add", systemImage: "plus")
                    }
                }
            }
        }
        
    }
    
    private func addAcnt(_ acnt: Account) {
        modelContext.insert( acnt )
    }
    
    private func deleteAcnt(at offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(acnts[index])
            }
        }
    }
    
    
    private func filteredAccounts() -> [Account] {
        guard !acnts.isEmpty && !searchText.isEmpty 
        else { return acnts }
        return acnts.filter { acnt in
            acnt.title.lowercased().contains(searchText.lowercased())
        }
    }
    
}


struct AccountListEntryLabel: View {
    @State var acnt: Account
    var body: some View {
        VStack {
            HStack {
                Text(acnt.title)
                    .foregroundStyle(.primary)
                Spacer()
            }
            if !acnt.username.isEmpty {
                HStack {
                    Text(acnt.username)
                        .foregroundStyle(.secondary)
                    Spacer()
                }
            }
        }
    }
}



#Preview {
    ContentView()
        .modelContainer(for: Account.self, inMemory: true)
}
