import Foundation

class Stack<Element> {
    private var stackArray = [Element]()
    
    
    init(fromArray stackArray: [Element]) {
        self.stackArray = stackArray
    }
    
    func push(elemToPush: Element){
        stackArray.append(elemToPush)
    }
    
    func pop() -> Element? {
        if let lastElm = stackArray.last {
            self.stackArray.removeLast()
            return lastElm
        }
        return nil
    }
    
    var isEmpy: Bool {
        return stackArray.isEmpty
    }
}
