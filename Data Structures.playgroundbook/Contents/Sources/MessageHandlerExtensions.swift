import PlaygroundSupport
import UIKit

extension StackViewController: PlaygroundLiveViewMessageHandler {
    public func receive(_ message: PlaygroundValue) {
        switch message {
        case .integer(let item):
            self.push(item)
            break
        case .string(_):
            self.pop()
            break
        default:
            break
        }
    }
}

extension QueueViewController: PlaygroundLiveViewMessageHandler {
    public func receive(_ message: PlaygroundValue) {
        switch message {
        case .dictionary(let dict):
            let command = dict["command"]!
            let catName = dict["cat"]!
            switch (command, catName) {
            case (.integer(let direction), .string(let cat)):
                if direction > 0 {
                    self.pushFront(cat)
                } else {
                    self.pushBack(cat)
                }
                break
            default:
                break
            }
            break
        case .integer(let direction):
            if direction > 0 {
                self.popFront()
            } else {
                self.popBack()
            }
            break
        case .string(let catName):
            self.enqueue(catName)
            break
        case .array(_):
            self.dequeue()
            break
        default:
            break
        }
    }
}

extension HashTableViewController: PlaygroundLiveViewMessageHandler {
    public func receive(_ message: PlaygroundValue) {
        switch message {
        case .dictionary(let dict):
            let value1 = dict["key"]!
            let value2 = dict["value"]!
            switch (value1, value2) {
            case (.string(let key), .string(let value)):
                self.insert(key: key, value: value.characters.first ?? Character(""))
                break
            default:
                break
            }
            break
        case .integer(let direction):
            self.clear()
            break
        default:
            break
        }
    }
}
