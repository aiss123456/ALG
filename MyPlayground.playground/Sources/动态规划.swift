import Foundation
/*
 给你一个字符串 s，找到 s 中最长的回文子串
 输入：s = "babad"
 输出："bab"
 解释："aba" 同样是符合题意的答案。
 示例 2：
 输入：s = "cbbd"
 输出："bb"
 */

//解法1
//暴力解法 n^3
public func longestPalindrome(_ s:String) -> String {
    let strArr = Array<Character>(s)
    let len = strArr.count
    var maxLen:Int = 1
    var begin:Int = 0
    
    if strArr.count < 2 {
        return s
    }
    //枚举子串长度
    for L in 2...len {
        //枚举左边界
        for i in 0..<len {
            let j = i + L - 1
            if (j > len - 1) {
                break
            }
            //判断是否是回文串
            if isPalindrome(s: s, start: i, end: j){
                if (j - i + 1) > maxLen {
                    maxLen = j - i + 1
                    begin = i
                }
            }
            
        }
        
    }
    
    let starIndex = s.index(s.startIndex, offsetBy: begin)
    let endIndex = s.index(s.startIndex, offsetBy: begin + maxLen - 1)
    
    print(String(s[starIndex...endIndex]))
    return String(s[starIndex...endIndex])
}

//解法2
//动态规划 n^2 空间2n数组
public func longestPalindrome2(_ s:String) -> String {
    let strArr = Array<Character>(s)
    let len = strArr.count
    
    var dp = [[Bool]](repeating: [Bool](repeating: false, count: len), count: len)
    for i in 0..<len {
        dp[i][i] = true
    }
    var maxLen:Int = 1
    var begin:Int = 0
    
    if strArr.count < 2 {
        return s
    }
    //枚举子串长度
    for L in 2...len {
        //枚举左边界
        for i in 0..<len {
            let j = i + L - 1
            if (j > len - 1) {
                break
            }
            //判断是否是回文串
            if strArr[i] != strArr[j] {
                dp[i][j] = false
            }else{
                if (j - i) < 3 {
                    dp[i][j] = true
                }else{
                    dp[i][j] = dp[i + 1][j - 1]
                }
            }
            if dp[i][j] && (j - i + 1) > maxLen {
                maxLen = j - i + 1
                begin = i
            }
            
        }
        
    }
    
    let starIndex = s.index(s.startIndex, offsetBy: begin)
    let endIndex = s.index(s.startIndex, offsetBy: begin + maxLen - 1)
    
    print(String(s[starIndex...endIndex]))
    return String(s[starIndex...endIndex])
}

//解法3 中心扩展算法
// O n^2 空间 n^2数组
public func longestPalindrome3(_ s:String) -> String {
    let strArr = Array<Character>(s)
    let len = strArr.count
    
    var maxLen:Int = 1
    var begin:Int = 0
    
    if strArr.count < 2 {
        return s
    }
    for i in 0..<len {
        //枚举左边界
        let len1 = expandAroundCenter(s: s, start: i, end: i)
        let len2 = expandAroundCenter(s: s, start: i, end: i+1)
        let max = max(len1, len2)
        if max > maxLen {
            maxLen = max
            begin = i - (max - 1)/2
        }
    }
    
    let starIndex = s.index(s.startIndex, offsetBy: begin)
    let endIndex = s.index(s.startIndex, offsetBy: begin + maxLen - 1)
    
    print(String(s[starIndex...endIndex]))
    return String(s[starIndex...endIndex])
}

//判断一个字符串是否是回文串
func isPalindrome(s:String,start:Int,end:Int) -> Bool {
//    print(String(start)...String(end))
    let strArr = Array<Character>(s)
    var start = start
    var end = end
    while (start < end){
        if strArr[start] != strArr[end] {
            return false
        }
        start += 1
        end -= 1
    }
    return true
}

//中心扩展算法计算长度
func expandAroundCenter(s:String,start:Int,end:Int) -> Int {
//    print(String(start)...String(end))
    let strArr = Array<Character>(s)
    var start = start
    var end = end
    while (start >= 0 && end < strArr.count){
        if strArr[start] != strArr[end] {
          break
        }
        start -= 1
        end += 1
    }
    return end - start - 1
}
