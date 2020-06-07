import Frontend
import PlaygroundSupport
import SwiftUI

let loadingView = LoadingView(title: "This is a title", titleColor: Color.green, isloading: true)

PlaygroundPage.current.setLiveView(loadingView)
