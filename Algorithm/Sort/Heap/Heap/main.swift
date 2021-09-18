//
//  main.swift
//  Heap
//
//  Created by 肖仲文 on 2021/9/13.
//  堆排序

import Foundation

class Solution {
    /// 创建堆
    /// - Parameter list: 原序列
    /// - Returns: 堆序列
    func createHeap(_ list:[Int]) -> [Int] {
        var heap = Array.init(list)
        // 从最后一个根元素开始调整堆序
        var rootIndex = list.count / 2 - 1
        while rootIndex >= 0 {
            var index = rootIndex
            // 调整当前根元素所在子树的堆序
            while index << 1 + 1 < list.count {
                let left = index << 1 + 1
                let right = left + 1
                let root = heap[index]

                // 获取最小孩子结点
                var targetIndex = left
                if right < list.count &&
                    heap[right] < heap[left] {
                    targetIndex = right
                }

                // 调整顺序
                if heap[targetIndex] < root {
                    heap[index] = heap[targetIndex]
                    heap[targetIndex] = root
                    index = targetIndex
                } else {
                    break
                }
            }
            rootIndex = rootIndex - 1
        }
        return heap
    }

    /// 堆排序
    /// - Parameter list: 原序列
    /// - Returns: 非递减序列
    func sort(_ list:[Int]) -> [Int] {
        // 1. 创建堆
        var heap = createHeap(list)
        // 2. 调整堆
        var result = [Int]()
        while heap.count > 0 {
            if let e = heap.first {
                // 2.1 添加堆顶元素
                result.append(e)
                // 2.2 删除堆元素
                heap[0] = heap[heap.count - 1]
                heap.removeLast()
                // 2.3 恢复堆序性
                var index = 0
                while index << 1 + 1 < heap.count {
                    let left = index << 1 + 1
                    let right = left + 1
                    var targetIndex = left
                    if right < heap.count &&
                        heap[right] < heap[left] {
                        targetIndex = right
                    }
                    if heap[targetIndex] < heap[index] {
                        let root = heap[index]
                        heap[index] = heap[targetIndex]
                        heap[targetIndex] = root
                        index = targetIndex
                    } else {
                        break
                    }
                }
            }

        }
        return result
    }
}

let s = Solution.init()
//let list = [3, 7, 9, 5, 17, 1, 0, 3]
//let list = [0, 0, 0, 0, 0, 0]
//let list = [6, 5, 4, 3, 2, 1]
let list = [1, 2, 3, 4, 5, 6]
let result = s.sort(list)
print(result)


