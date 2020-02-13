import UIKit

// I didn't really get, what the methods should do?

class Spoon {
    let index: Int
    func pickUp() {
        
    }
    func putDown() {
        
    }
    init(index: Int) {
        self.index = index
    }
}

class Developer {
    var leftSpoon: Spoon?
    var rightSpoon: Spoon?
    let lock = NSLock()
    
    func think() {
        lock.lock()
        guard let lindex = leftSpoon?.index, let rindex = rightSpoon?.index else { return }
        if lindex > rindex { rightSpoon?.pickUp() }
        else { leftSpoon?.pickUp() }
    }
    func eat() {
        usleep(useconds_t(Int.random(in: 1...10000000)))
        leftSpoon?.putDown()
        rightSpoon?.putDown()
        lock.unlock()
    }
    func run() {
        while true {
            think()
            eat()
        }
    }
}

var developers = [Developer(), Developer(), Developer(), Developer(), Developer()]
var spoons = [Spoon(index: 0), Spoon(index: 1), Spoon(index: 2), Spoon(index: 3), Spoon(index: 4)]
let i = 0
developers[0].leftSpoon = spoons[4]
developers[0].rightSpoon = spoons[0]
developers[1].leftSpoon = spoons[0]
developers[1].rightSpoon = spoons[1]
developers[2].leftSpoon = spoons[1]
developers[2].rightSpoon = spoons[2]
developers[3].leftSpoon = spoons[2]
developers[3].rightSpoon = spoons[3]
developers[4].leftSpoon = spoons[3]
developers[4].rightSpoon = spoons[4]

DispatchQueue.concurrentPerform(iterations: 5) {
    developers[$0].run()
}
