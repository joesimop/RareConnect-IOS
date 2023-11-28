//
//  ContentView.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 11/4/23.
//

import SwiftUI
import SwiftData

struct UberData: Decodable{
    let id: Int
    let name: String
}

struct Thingy: UIViewControllerRepresentable{
    func makeUIViewController(context: Context) -> UberTableView {
        return UberTableView()
    }
    
    func updateUIViewController(_ uiViewController: UberTableView, context: Context) {
    }
}

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
    
    
    //let apiCaller = APICaller<GetRequest<UberData>>()

    var body: some View {
        
        NavigationView{
            NavigationLink{
                Thingy()
            } label: {
                VStack {
                        Image(systemName: "globe")
                            .imageScale(.large)
                     
                            .foregroundColor(.accentColor)
                Text("Hello, world!")
                }
                .padding()
            }
        }
        
        
        NavigationSplitView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                    } label: {
                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
