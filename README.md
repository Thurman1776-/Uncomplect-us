# How much you are complecting your code? 

Complect what? [Rich Hickey explain us what it means](https://www.youtube.com/watch?v=oytL881p-nQ&t=1320s) to complect your software. 

This is a tool that intents to help you uncomplect your objects
by giving you an indication of which entities show a large amount of dependencies & how they are intertwined. 

It is also a great way to learn about a project you might have recently joined. 

This is basically a re-write of [this project](https://github.com/PaulTaykalo/objc-dependency-visualizer) in Swift 
as a Mac App. 
Currently it is serving me as a way to experiment with newest tech such as SwiftUI.
The app is using [ReSwift](https://github.com/ReSwift/ReSwift) that plays nicely with SwiftUI mental model, which 
somehow encourages to have an unidirectional data flow.  

The visual representation is quite different from the Ruby project but in the future I plan to have a similar graphical 
representation of dependencies + tons of other useful features. 

### Requirements

- Xcode 11.4.1
- accio which can be installed via brew
    ````
    brew tap JamitLabs/Accio https://github.com/JamitLabs/Accio.git
    brew install accio
- carthage which can also be installed via brew
    ```
    brew install carthage

If brew is not your cup of tea, head over the projects' repos to learn about other options 👀

### How to use the tool 

- Jump into the repo folder & paste this on your terminal `cd scripts && sh bootstrap.sh`
- Run the Xcode project
- Enjoy!



#### Enter your project name 
e.g. Backend 
![Backend_image](https://github.com/Thurman1776-/Uncomplect-us/blob/master/Screenshots/Screenshot-1.png)

#### Wait while your project is being scanned 
![scanned_project](https://github.com/Thurman1776-/Uncomplect-us/blob/master/Screenshots/Screenshot-2.png) - Please note there's no trackers of any sort sending data anywhere. Everything is local. 

#### See an overview of the project status 
![project_status](https://github.com/Thurman1776-/Uncomplect-us/blob/master/Screenshots/Screenshot-3.png), including paths from files being scanned, largest dependency, and more. 

#### Tap on any item to see its dependencies 
![dependencies](https://github.com/Thurman1776-/Uncomplect-us/blob/master/Screenshots/Screenshot-4.png)


This is a very much WIP, however feedback is always welcome! 
