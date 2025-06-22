import 'package:flutter/material.dart';
import 'package:new_project/demo_button.dart';

class UIUpdatesDemo extends StatelessWidget {
  const UIUpdatesDemo({super.key});

  /// In the demo, createElement is called first
  /// Element object being created and then being updated behind the scenes
  /// once the build method finishes
  /// 
  /// build method tells Flutter which other widgets and widget elements must be created
  /// 
  /// Flutter does not just create elements for own widgets but for all widgets that make up the UI
  /// 
  /// All the elements in the build method form the element tree which is used to find out if 
  /// UI updates are needed
  /// 
  /// When app is being rendered for the first time, entire element tree is new and the entire
  /// UI is rendered for the first time, so the render tree for the UI is created
  /// 
  /// Thereafter, the element tree is only updated if it needs to be updated
  /// 
  /// build method is always called when the state of the widget is updated
  /// If Flutter determines no new elements needed to be created, if no widgets added
  /// E.g. Set state but nothing changes
  /// Build method is called and widget tree being re-evaluated and partially recreated but the 
  /// element and render trees would be left untouched
  /// 
  /// If the UI will be changed, element tree is now different from previous element tree
  /// Render tree will be updated
  /// 
  /// For more complex apps with more complex widget trees, want to avoid checking widgets for updates 
  /// that can't be affected by state updates
  /// 
  /// Every widget has its element, but when widgets change their position, the element tree does not chane
  /// I.e. no need to add new elements, it updates which element refers to which widget
  /// 
  /// However, state objects that belong to widgets are managed as independent objects that are connected
  /// to the elements.
  /// I.e. Each state object is connected to the element objects that are connected to the widgets
  /// If the widgets change their position, Flutter reuses elements and updates the references between the 
  /// element and the widget (pointers to widgets), but the state objects don't move around
  /// State does not move together with the widgets
  /// 
  /// If we add keys to the widgets, those keys are also added to the elements
  /// If widgets move around, the keys also move with them
  /// If keys don't match between the widget and the element, the elements and the state would be moved
  /// with the widget position

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Every Flutter developer should have a basic understanding of Flutter\'s internals!',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Do you understand how Flutter updates UIs?',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            DemoButtons(),
          ],
        ),
      ),
    );
  }
}