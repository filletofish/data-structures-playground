//: [Previous](@previous)

import Foundation
import PlaygroundSupport
import UIKit

let page = PlaygroundPage.current

let view = DequeViewController()
page.liveView = view


enum Cat: String {
    case bally = "cat1"
    case dodgy = "cat2"
    case waity = "cat3"
    case grumpy = "cat4"
    case jumpy = "cat5"
}


view.pushFront(Cat.bally.rawValue)
view.pushBack(Cat.grumpy.rawValue)
