//
//  ListView.swift
//  SwiftDataObserverTest
//
//  Created by Robert Hahn on 03.07.24.
//

import SwiftUI

struct ListElementView: View {
	let item: Item
	
    var body: some View {
		Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
    }
}

#Preview {
	let item = Item(timestamp: .now)
    return ListElementView(item: item)
}
