//
//  ContentView.swift
//  SwiftDataObserverTest
//
//  Created by Robert Hahn on 03.07.24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
	@Environment(\.undoManager) var undoManager
    @Query private var items: [Item]
	@State private var selectedItems: Set<Item> = []

    var body: some View {
        NavigationSplitView {
			List(selection: $selectedItems) {
                ForEach(items) { item in
					ListElementView(item: item)
						.tag(item)
                }
                .onDelete(perform: deleteItems)
            }
            .navigationSplitViewColumnWidth(min: 180, ideal: 200)
            .toolbar {
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        } detail: {
			if let item = selectedItems.first {
				DetailView(item: item)
			} else {
				Text("Select an item")
			}
        }
		.onDeleteCommand {
			deleteSelectedItems()
		}
		.onChange(of: undoManager, initial: true) {
			modelContext.undoManager = undoManager
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
	
	private func deleteSelectedItems() {
		for selectedItem in selectedItems {
			modelContext.delete(selectedItem)
			selectedItems.remove(selectedItem)
		}
	}
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
