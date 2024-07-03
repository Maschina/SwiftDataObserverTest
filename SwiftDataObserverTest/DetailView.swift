//
//  DetailView.swift
//  SwiftDataObserverTest
//
//  Created by Robert Hahn on 03.07.24.
//

import SwiftUI

struct DetailView: View {
	@Bindable var item: Item
	
    var body: some View {
		Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
		
		DatePicker(selection: $item.timestamp, label: { Text("Change Date:") })
    }
}

#Preview {
	let item = Item(timestamp: .now)
	return DetailView(item: item)
}
