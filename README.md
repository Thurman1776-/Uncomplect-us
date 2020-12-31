[![Build Status](https://app.bitrise.io/app/84713dd82975d73b/status.svg?token=l5L6XnOKx-88HpwVnBQhkQ&branch=master)](https://app.bitrise.io/app/84713dd82975d73b)

# How much you are complecting your code? 

Complect what? [Rich Hickey explain us what it means](https://www.youtube.com/watch?v=oytL881p-nQ&t=1320s) to complect your software. 

This is a tool that intents to help you uncomplect your software relationship
by giving you an indication of which entities show a large amount of dependencies & how they might be intertwined. 

It is also a great way to learn about a project you might have recently joined or for open sourced projects you might be digging into. 

### Requirements

- Xcode 12.0 or higher
- Project to be scanned has to be compiled at least once (its derived data needs to be there)
- Use default location for derived data

### How to use the tool 

- Jump into the repo folder & open `Uncomplect-us.xcworkspace` with Xcode
- Let SPM fetch & resolve deps (takes a minute or two)
- Select the `Mac-App` target & run
- Enjoy!

### Executing the binary

Alternatively, download & run the binary directly from [here](https://github.com/Thurman1776-/Uncomplect-us/tree/master/Mac-App/bin/alpha/Uncomplect-us_2.0.0-alpha.app)

## Sample usage 

#### Enter your project/target name
e.g. Backend 

![Backend_image](https://github.com/Thurman1776-/Uncomplect-us/blob/master/Screenshots/Startup.png)
![Backend_image](https://github.com/Thurman1776-/Uncomplect-us/blob/master/Screenshots/Typing.png)

#### Wait while your project is being scanned 
> Please note there's no trackers of any sort sending data anywhere. Everything is local.

![scanned_project](https://github.com/Thurman1776-/Uncomplect-us/blob/master/Screenshots/Searching.png) 

#### See an overview of the project status 

> including paths from files being scanned, largest dependency, and more. 

![project_status](https://github.com/Thurman1776-/Uncomplect-us/blob/master/Screenshots/Results.png)

#### You can filter results using the search field

![filtered_results](https://github.com/Thurman1776-/Uncomplect-us/blob/master/Screenshots/Filter.png)

#### Tap on any item to see its dependencies 
![dependencies](https://github.com/Thurman1776-/Uncomplect-us/blob/master/Screenshots/Dep-details.png)

### Motivation 

I found this [unmaintained project](https://github.com/PaulTaykalo/objc-dependency-visualizer) a while ago & it became really useful for the problem I was facing back then. As I thought many of us run into the same issue, I decided to build a Mac app for it in Swift (powered by SwiftUI + Redux).

The visual representation will likely change a lot during the time to come, as a result of experimentation & feedback. 
