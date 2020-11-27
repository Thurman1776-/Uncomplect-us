[![Build Status](https://app.bitrise.io/app/84713dd82975d73b/status.svg?token=l5L6XnOKx-88HpwVnBQhkQ&branch=master)](https://app.bitrise.io/app/84713dd82975d73b)

# How much you are complecting your code? 

Complect what? [Rich Hickey explain us what it means](https://www.youtube.com/watch?v=oytL881p-nQ&t=1320s) to complect your software. 

This is a tool that intents to help you uncomplect your objects
by giving you an indication of which entities show a large amount of dependencies & how they are intertwined. 

It is also a great way to learn about a project you might have recently joined. 

This is basically a re-write of [this project](https://github.com/PaulTaykalo/objc-dependency-visualizer) in Swift 
as a Mac App. 
Currently it is serving me as a way to experiment with newest tech such as SwiftUI/Combine.
The app is using [ReSwift](https://github.com/ReSwift/ReSwift) that plays nicely with SwiftUI mental model, that 
somehow encourages to have an unidirectional data flow.  

The visual representation is quite different from the Ruby project but in the future I plan to have a similar graphical 
representation of dependencies + tons of other useful features. 

### Requirements

- Xcode 12.0

### How to use the tool 

- Jump into the repo folder & open `Uncomplect-us.xcworkspace` with Xcode
- Let SPM fetch & resolve deps (takes a minute or two)
- Select the `Mac-App` target & run
- Enjoy!


#### Enter your project/target name (as long as your project has been compiled before & you use the default derive data settings)
e.g. Backend 
![Backend_image](https://github.com/Thurman1776-/Uncomplect-us/blob/master/Screenshots/Screenshot-1.png)

#### Wait while your project is being scanned 
> Please note there's no trackers of any sort sending data anywhere. Everything is local.

![scanned_project](https://github.com/Thurman1776-/Uncomplect-us/blob/master/Screenshots/Screenshot-2.png) 

#### See an overview of the project status 

> including paths from files being scanned, largest dependency, and more. 

![project_status](https://github.com/Thurman1776-/Uncomplect-us/blob/master/Screenshots/Screenshot-3.png)

#### Tap on any item to see its dependencies 
![dependencies](https://github.com/Thurman1776-/Uncomplect-us/blob/master/Screenshots/Screenshot-4.png)



This is a very much WIP, however feedback is always welcome! 
