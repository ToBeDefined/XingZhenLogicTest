//
//  main.swift
//  XingZhenLogic
//
//  Created by TBD on 2018/3/2.
//  Copyright © 2018年 TBD. All rights reserved.
//

import Foundation


// MARK: DataModel

class SelectTreeNode {
    enum Select: Int {
        case None = -1
        case A = 0
        case B = 1
        case C = 2
        case D = 3
        var description: String {
            switch self {
            case .A:
                return "A"
            case .B:
                return "B"
            case .C:
                return "C"
            case .D:
                return "D"
            case .None:
                return " ERROR "
            }
        }
        
    }
    
    var data: Select?
    var a: SelectTreeNode?
    var b: SelectTreeNode?
    var c: SelectTreeNode?
    var d: SelectTreeNode?
    
    var parentNode: SelectTreeNode?
    
    var description: String {
        guard let data = self.data, data != .None else {
            return "NULL"
        }
        return data.description
    }
}

func initSelectTree(rootNode: SelectTreeNode?, deep: Int) {
    if deep == 0 {
        return
    }
    
    rootNode?.a = SelectTreeNode()
    rootNode?.a?.parentNode = rootNode
    rootNode?.a?.data = .A
    
    rootNode?.b = SelectTreeNode()
    rootNode?.b?.parentNode = rootNode
    rootNode?.b?.data = .B
    
    rootNode?.c = SelectTreeNode()
    rootNode?.c?.parentNode = rootNode
    rootNode?.c?.data = .C
    
    rootNode?.d = SelectTreeNode()
    rootNode?.d?.parentNode = rootNode
    rootNode?.d?.data = .D
    
    initSelectTree(rootNode: rootNode?.a, deep: deep - 1)
    initSelectTree(rootNode: rootNode?.b, deep: deep - 1)
    initSelectTree(rootNode: rootNode?.c, deep: deep - 1)
    initSelectTree(rootNode: rootNode?.d, deep: deep - 1)
}

func getAllLeafNode(of node: SelectTreeNode?) -> [SelectTreeNode] {
    var leafNodeArray: [SelectTreeNode] = []
    func getLeafNode(of node: SelectTreeNode?) {
        guard let node = node else { return }
        if node.a == nil && node.b == nil && node.c == nil && node.d == nil {
            leafNodeArray.append(node)
        }
        
        if node.a != nil {
            getLeafNode(of: node.a)
        }
        
        if node.b != nil {
            getLeafNode(of: node.b)
        }
        
        if node.c != nil {
            getLeafNode(of: node.c)
        }
        
        if node.d != nil {
            getLeafNode(of: node.d)
        }
    }
    getLeafNode(of: node)
    return leafNodeArray
}

func getPath(of leafNode: SelectTreeNode?) -> [SelectTreeNode.Select] {
    if leafNode == nil {
        return []
    }
    
    var path = [SelectTreeNode.Select]()
    var node: SelectTreeNode? = leafNode
    while node?.parentNode != nil {
        path.insert((node?.data)!, at: 0)
        node = node?.parentNode
    }
    return path
}

func printPath(_ path: [SelectTreeNode.Select]) {
    var str = ""
    for item in path {
        str += item.description
    }
    print(str)
}

func traverseSelectTree(rootNode: SelectTreeNode?) {
    let leafNodeArray = getAllLeafNode(of: rootNode)
    for node in leafNodeArray {
        printPath(getPath(of: node))
    }
}

// MARK: Logic Test

func isTruePath(_ path: [SelectTreeNode.Select]) -> Bool {
    var path = path
    // 方便从1开始
    path.insert(SelectTreeNode.Select.None, at: 0)
    // 题1 不用管
    // 题2
    if (path[2] == .A && path[5] != .C) ||
        (path[2] == .B && path[5] != .D) ||
        (path[2] == .C && path[5] != .A) ||
        (path[2] == .D && path[5] != .B) {
        return false
    }
    
    // 题3
    var threeAnswerArray = [path[3], path[6], path[2], path[4]]
    let threeAnswerIndex = path[3].rawValue
    let diffrentAnswer = threeAnswerArray.remove(at: threeAnswerIndex)
    let equealAnswerSet = Set.init(threeAnswerArray)
    // 剩下的不是同一个答案
    if equealAnswerSet.count != 1 {
        return false
    }
    // 四个全是相同的
    if diffrentAnswer == threeAnswerArray[0] {
        return false
    }
    
    // 题4
    let fourAnswerIndex = path[4].rawValue
    var fourAnswerArray: [[Int]] = [[1, 5], [2, 7], [1, 9], [6, 10]]
    var foueAnswer = fourAnswerArray[fourAnswerIndex]
    if path[foueAnswer[0]] != path[foueAnswer[1]]{
        return false
    }
    
    // 题5
    var fiveAnswerArray: [Int] = [8, 4, 9, 7]
    let fiveAnswerIndex = path[5].rawValue
    let fiveAnswer = fiveAnswerArray[fiveAnswerIndex]
    if path[5] != path[fiveAnswer] {
        return false
    }
    
    // 题6
    var sixAnswerArray:[[Int]] = [[2, 4], [1, 6], [3, 10], [5, 9]]
    // 答案给的题号
    var sixAnswer = sixAnswerArray[path[6].rawValue]
    // 对应题号的答案
    let sixAnswersAnswerArray = [path[sixAnswer[0]], path[sixAnswer[1]], path[8]]
    // 对应题号的答案Set
    let sixAnswersAnswerSet = Set.init(sixAnswersAnswerArray)
    if sixAnswersAnswerSet.count != 1 {
        return false
    }
    
    // 题7
    var ACount = 0
    var BCount = 0
    var CCount = 0
    var DCount = 0
    for select in path {
        switch select {
        case .A:
            ACount += 1
        case .B:
            BCount += 1
        case .C:
            CCount += 1
        case .D:
            DCount += 1
        default:
            break
        }
    }
    var abcdCountArray = [ACount, BCount, CCount, DCount]
    var sevenAnswerArray = [SelectTreeNode.Select.C, SelectTreeNode.Select.B,  SelectTreeNode.Select.A, SelectTreeNode.Select.D]
    // 获取给的答案是ABCD哪个
    let sevenAnswer = sevenAnswerArray[path[7].rawValue]
    // 从abcdCountArray取出对应字母的出现次数
    let minCountAnswer = abcdCountArray[sevenAnswer.rawValue]
    if minCountAnswer != min(ACount, BCount, CCount, DCount) {
        // 如果不是真正的最小值
        return false
    }
    
    // 题8
    var eightAnswerArray = [7, 5, 2, 10]
    let eightAnswer = eightAnswerArray[path[8].rawValue]
    let eightAnswersAnswer = path[eightAnswer]
    let firstAnswer = path[1]
    let value1 = firstAnswer.rawValue
    let value2 = eightAnswersAnswer.rawValue
    // 相邻 = 1
    if abs(value1 - value2) == 1 {
        return false
    }
    
    // 题9
    let boolen16 = (path[1] == path[6])
    var nineAnswerArray = [6, 10, 2, 9]
    let nineAnswer = nineAnswerArray[path[9].rawValue]
    let nineAnswersAnswer = path[nineAnswer]
    let boolenx5 = (path[5] == nineAnswersAnswer)
    // 1/6 与 x/5 相反
    if boolen16 == boolenx5 {
        return false
    }
    
    // 题10
    let maxABCDCount = max(ACount, BCount, CCount, DCount)
    let minABCDCount = min(ACount, BCount, CCount, DCount)
    let distance = maxABCDCount - minABCDCount
    var tenAnswerArray = [3, 2, 4, 1]
    if distance != tenAnswerArray[path[10].rawValue] {
        return false
    }
    return true
}

// MARK: Start

var rootNode: SelectTreeNode? = SelectTreeNode()
initSelectTree(rootNode: rootNode, deep: 10)
let array = getAllLeafNode(of: rootNode)
var truePathCount = 0
for leafNode in array {
    let path = getPath(of: leafNode)
    if isTruePath(path) {
        truePathCount += 1
        printPath(path)
    }
}
print("总共有 \(truePathCount) 种答案")

