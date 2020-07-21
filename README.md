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

- Enter your project name 
e.g. Backend 
![Backend_image](https://github.com/Thurman1776-/Uncomplect-us/blob/master/Screenshots/Screenshot-1.png)
- Wait while your project is being scanned 
![scanned_project](https://github.com/Thurman1776-/Uncomplect-us/blob/master/Screenshots/Screenshot-2.png) - Please note there's no trackers of any sort sending data anywhere. Everything is local. 
- See an overview of the project status 
![project_status](https://github.com/Thurman1776-/Uncomplect-us/blob/master/Screenshots/Screenshot-3.png), including paths from files being scanned, largest dependency, and more. 
- Tap on any item to see its dependencies 
![dependencies](https://github.com/Thurman1776-/Uncomplect-us/blob/master/Screenshots/Screenshot-4.png)


This is a very much WIP, however feedback is always welcome! 
