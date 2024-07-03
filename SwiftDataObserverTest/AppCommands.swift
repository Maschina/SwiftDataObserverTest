//
//  CommandGroup.swift
//  AutoMotionStudio
//
//  Created by Robert Hahn on 02.07.24.
//

import SwiftUI
import SwiftData

struct AppCommands: Commands {
	@Environment(\.modelContext) private var modelContext
	
	/// Indicating if there are any undo operations in the stack
	@State private var canUndo: Bool = false
	/// Notification being fired when UndoManager closes a undo group
	private let undoObserver = NotificationCenter.default.publisher(for: .NSUndoManagerDidCloseUndoGroup)
	private let undoChange = NotificationCenter.default.publisher(for: .NSUndoManagerDidUndoChange)
	
	var body: some Commands {
		// undo/redo manager
		CommandGroup(replacing: .undoRedo) {
			Button("Undo") {
				modelContext.undoManager?.undo()
				canUndo = modelContext.undoManager?.canUndo == true
			}
			.keyboardShortcut("z", modifiers: .command)
			.disabled(!canUndo)
			.onReceive(undoObserver) { _ in
				// updating `canUndo` if undo group has been closed
				canUndo = modelContext.undoManager?.canUndo == true
			}
			.onReceive(undoChange) { _ in
				// print UndoManager stack
				if let undoManager = modelContext.undoManager {
					if #available(macOS 14.4, *) {
						print("Undo count: \(undoManager.undoCount)")
					}
					let undostack = object_getIvar(undoManager, class_getInstanceVariable(UndoManager.self, "_undoStack")!);
					print(undostack.debugDescription)
				}
			}
		}
	}
}
