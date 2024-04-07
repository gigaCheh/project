import UIKit
import Foundation

var c: Int = 666

func reset(value: inout Int) {
    value = 0
}

reset(value: &c)


var array = [1,2,8,8,4,5]

func modify(value: inout [Int]) {
    value.append(0)
}

modify(value: &array)
