//: [Previous](@previous)

import Foundation
import PlaygroundSupport

enum Cat: String {
    case bally = "cat1"
    case dodgy = "cat2"
    case waity = "cat3"
    case grumpy = "cat4"
    case jumpy = "cat5"
}

let page = PlaygroundPage.current

let view = QueueViewController()
page.liveView = view

view.enqueue(Cat.dodgy.rawValue)
view.dequeue()
