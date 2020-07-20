# How much you are complecting your code? 

Complect what? [Rich Hickey explain us what it is](https://www.youtube.com/watch?v=oytL881p-nQ&t=1320s) to complect your software. 

This is a tool that intents to help you uncomplect your objects
by giving you an indication of which entities show a large amount of dependencies & how they are intertwined. 

This is basically a re-write of [this project](https://github.com/PaulTaykalo/objc-dependency-visualizer) in Swift 
as a Mac App. 
Currently it is serving me as a way to experiment with newest tech such as SwiftUI.
The app is using [ReSwift](https://github.com/ReSwift/ReSwift) that plays nicely with SwiftUI mental model, which 
somehow encourages to have an unidirectional data flow.  

The visual representation is quite different from the Ruby project but in the future I plan to have a similar graphical 
representation of dependencies + tons of other useful features. 

### How to use the tool 

Simply clone & run the Xcode project (current version is 11.4.1)

1 - Enter your project name 
e.g. ![Backend](https://github.com/Thurman1776-/Uncomplect-us/pull/18/commits/43093f107bf6e5a5f6d55ff1f5277f2bea3571eb#diff-db168aa37356d9bc2145c4a2d4086030)
2 - ![Wait while your project is being scanned](https://github.com/Thurman1776-/Uncomplect-us/pull/18/commits/43093f107bf6e5a5f6d55ff1f5277f2bea3571eb?short_path=7f4e4c0#diff-7f4e4c00093cfee0a5b4faf2e1afacb0) - Please note there's no trackers of any sort sending data anywhere. Everything is local. 
3 - See an overview of the ![project status](https://github.com/Thurman1776-/Uncomplect-us/pull/18/commits/43093f107bf6e5a5f6d55ff1f5277f2bea3571eb?short_path=f0d859c#diff-f0d859cec81765960cb24bdae9168838), including paths from files being scanned, largest dependency, and more. 
4 - Tap on any item to see ![its dependencies](https://github.com/Thurman1776-/Uncomplect-us/pull/18/commits/43093f107bf6e5a5f6d55ff1f5277f2bea3571eb?short_path=0071dc6#diff-0071dc616ba1609f7625ae329ceac245)


This is a very much WIP, however feedback is always welcome! 
