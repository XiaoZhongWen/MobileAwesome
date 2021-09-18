//
//  main.swift
//  Quick
//
//  Created by 肖仲文 on 2021/9/14.
//

import Foundation

class Solution {

    func swap(_ list: inout [Int], _ left:Int, _ right: Int) {
        let tmp = list[left]
        list[left] = list[right]
        list[right] = tmp
    }

    func median3(_ list:inout [Int], _ left:Int, _ right: Int) -> Int {
        let center = (left + right) / 2
        if list[left] > list[center] {
            swap(&list, left, center)
        }
        if list[left] > list[right] {
            swap(&list, left, right)
        }
        if list[center] > list[right] {
            swap(&list, center, right)
        }
        swap(&list, center, right)
        return list[right]
    }

    func sort(_ list:inout [Int], _ left:Int, _ right: Int) {
        if left >= right {
            return
        }
        let pivot = median3(&list, left, right)
        var i = left
        var j = right - 1
        while true {
            while i <= right - 1 && list[i] <= pivot {
                i = i + 1
            }
            while j >= left && list[j] >= pivot {
                j = j - 1
            }
            if i < j {
                swap(&list, i, j)
            } else {
                break
            }
        }
        swap(&list, i, right)
        sort(&list, left, i - 1)
        sort(&list, i + 1, right)
    }

    func sort(_ list:[Int]) -> [Int] {
        var result = Array.init(list)
        sort(&result, 0, result.count - 1)
        return result
    }
}

let s = Solution.init()
//let list = [49, 38, 65, 97, 76, 13, 27]
//let list = [3, 7, 9, 5, 17, 1, 0, 3]
//let list = [0, 0, 0, 0, 0, 0]
//let list = [6, 5, 4, 3, 2, 1]
//let list = [1, 2, 3, 4, 5, 6]
let list = [2, 3, 5, 7, 1, 4, 6, 15, 5, 2, 7, 9, 10, 15, 9, 17, 12]
let result = s.sort(list)
print(result)



