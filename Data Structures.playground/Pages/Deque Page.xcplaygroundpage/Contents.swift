//: [Previous](@previous)

import Foundation
import PlaygroundSupport
import UIKit

let page = PlaygroundPage.current

let view = DequeViewController()
page.liveView = view

view.pushFront(1)
view.pushBack(2)
view.pushBack(2)

view.pushFront(1)
view.pushFront(1)
let a = #imageLiteral(resourceName: "cat2.png")
//let a = UIImage(imageLiteralResourceName: Image Literal)
