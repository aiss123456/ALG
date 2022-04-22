import Foundation

 public class ListNode {
     public var val: Int
     public var next: ListNode?
     public init() { self.val = 0; self.next = nil; }
     public init(_ val: Int) { self.val = val; self.next = nil; }
     public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
 }

/**
 两数之和
 
 给定一个整数数组 nums 和一个整数目标值 target，请你在该数组中找出 和为目标值 target  的那 两个 整数，并返回它们的数组下标。

 你可以假设每种输入只会对应一个答案。但是，数组中同一个元素在答案里不能重复出现。

 你可以按任意顺序返回答案。
 */
public func twoSum(_ nums:[Int],_ target:Int) -> [Int] {
    var map = [Int:Int]()
    
    for index in 0..<nums.count {
        let num:Int = nums[index]
        if (map[target-num] != nil){
            return [map[target-num]!,index]
        }
        map[nums[index]] = index
    }
    return[0]
}

/**
 两数相加
 给你两个 非空的链表，表示两个非负的整数。它们每位数字都是按照 逆序 的方式存储的，并且每个节点只能存储 一位 数字。请你将两个数相加，并以相同形式返回一个表示和的链表。
 你可以假设除了数字 0 之外，这两个数都不会以 0 开头。
 */
public func addTwoNumber(_ l1 : ListNode?,_ l2 : ListNode?) -> ListNode? {
    var L1 = l1
    var L2 = l2
    
    var head:ListNode?
    var tail:ListNode?
    var carry:Int = 0
    while(L1 != nil || L2 != nil){
        let num1:Int = L1?.val ?? 0
        let num2:Int = L2?.val ?? 0
        let sum:Int = num1 + num2 + carry
        let node:ListNode = ListNode(sum % 10)
        if head == nil {
            head = node
            tail = node
        }else{
            tail?.next = node
            tail = tail?.next
        }
        carry = sum/10
        
        if L1 != nil {
            L1 = L1!.next
        }
        
        if  L2 != nil {
            L2 = L2!.next
        }
    }
    if (carry > 0) {
        tail?.next = ListNode(carry)
    }
    return head
}

/**
 abcdcabc
 给定一个字符串 s ，请你找出其中不含有重复字符的 最长子串 的长度
 */
//滑动窗口
public func lengthOfLongestSubstring(_ s:String) -> Int {
    let chs = Array<Character>(s)
    var map = [Character:Int]()
    var left = 0
    var right = 0
    var imax = 0
    
    for i in 0..<chs.count {
        let char = chs[i]
        right += 1
        if let pre = map[char] {
            left = max(pre + 1, left)
//            map.removeValue(forKey: char)
           // print(left)
        }
        map[char] = i
        imax = max(imax, right-left)
    }
    return imax
}

