//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport


let page = PlaygroundPage.current

let view = StackViewController()

page.liveView = view
view.push(1)
view.push(2)
view.pop()
view.push(3)
view.push(2)
view.push(3)
view.push(3)
view.pop()
view.pop()
view.pop()
view.pop()
view.pop()

