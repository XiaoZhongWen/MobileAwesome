//
//  main.swift
//  FindKthLargest
//
//  Created by 肖仲文 on 2021/9/17.
//

import Foundation

class Solution {
    func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
        var numbers = nums;
        var stack = [(0, numbers.count - 1)];
        while stack.count > 0 {
            let boundary = stack.popLast();
            guard let left = boundary?.0 else {
                break;
            }
            guard let right = boundary?.1 else {
                break;
            }
            let pivot = median(&numbers, left, right);
            var i = left;
            var j = right;
            while true {
                while i < right && numbers[i] <= pivot {
                    i += 1;
                }
                while j > left && numbers[j] >= pivot {
                    j -= 1;
                }
                if i < j {
                    numbers.swapAt(i, j);
                } else {
                    break;
                }
            }
            numbers.swapAt(i, right);
            if numbers.count - i < k {
                stack.append((left, i - 1));
            } else if numbers.count - i > k {
                stack.append((i + 1, right));
            } else {
                return numbers[i];
            }
        }
        return 0;
    }

    func median(_ nums: inout [Int], _ left: Int, _ right: Int) -> Int {
        let center = (left + right) / 2;
        if nums[left] > nums[center] {
            nums.swapAt(left, center);
        }
        if nums[left] > nums[right] {
            nums.swapAt(left, right);
        }
        if nums[center] < nums[right] {
            nums.swapAt(center, right);
        }
        return nums[right];
    }
}

let s = Solution.init()
let result = s.findKthLargest([3, 2, 3, 1, 2, 4, 5, 5, 6], 4)
print(result)

