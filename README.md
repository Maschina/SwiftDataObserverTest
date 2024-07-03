# SwiftDataObserverTest

This is a Minimum Viable Product to demonstrate an issue with observing SwiftData model and UndoManager. This project includes a simple NavigationSplitView, an Item SwiftData model that is being persisted and an enabled UndoManager.

**Problem**: The SwiftData model `Item` can be observed as expected. Changing the date in the `DetailView` works as expected and all related views (`ListElementView` + `DetailView`) are updated as expected. When pressing ⌘+Z to undo with the enabled UndoManager, deletions or inserts in the sidebar are visible immediately (and properly observed by `ContentView`). However, when changing the timestamp and pressing ⌘+Z to undo that change, it is not properly observed and immediately updated in the related views (`ListElementView` + `DetailView`).

**Further comments**:
- Undo operation to the model value changes (here: `timestamp`) are visible in the `DetailView` when changing sidebar selections
- Undo operation to the model value changes (here: `timestamp`) are visible in the `ListElementView` when restarting the app
- Undo operation to the model value changes (here: `timestamp`) are are properly observed and immediately visible in the sidebar, when ommiting the `ListElementView` (no view encapsulation)
