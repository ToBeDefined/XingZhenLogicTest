//
//  main.swift
//  XingZhenLogic
//
//  Created by TBD on 2018/3/2.
//  Copyright © 2018年 TBD. All rights reserved.
//

import Foundation


// MARK: DataModel

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

func printAnswers(_ answers: [Select]) {
    var str = ""
    for item in answers {
        str += item.description
    }
    print(str)
}



// MARK: Logic Test

func isTrueAnswers(_ answers: [Select]) -> Bool {
    var answers = answers
    // 方便从1开始
    answers.insert(Select.None, at: 0)
    // 题1 不用管
    // 题2
    if (answers[2] == .A && answers[5] != .C) ||
        (answers[2] == .B && answers[5] != .D) ||
        (answers[2] == .C && answers[5] != .A) ||
        (answers[2] == .D && answers[5] != .B) {
        return false
    }
    
    // 题3
    var threeAnswerArray = [answers[3], answers[6], answers[2], answers[4]]
    let threeAnswerIndex = answers[3].rawValue
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
    let fourAnswerIndex = answers[4].rawValue
    var fourAnswerArray: [[Int]] = [[1, 5], [2, 7], [1, 9], [6, 10]]
    var foueAnswer = fourAnswerArray[fourAnswerIndex]
    if answers[foueAnswer[0]] != answers[foueAnswer[1]]{
        return false
    }
    
    // 题5
    var fiveAnswerArray: [Int] = [8, 4, 9, 7]
    let fiveAnswerIndex = answers[5].rawValue
    let fiveAnswer = fiveAnswerArray[fiveAnswerIndex]
    if answers[5] != answers[fiveAnswer] {
        return false
    }
    
    // 题6
    var sixAnswerArray:[[Int]] = [[2, 4], [1, 6], [3, 10], [5, 9]]
    // 答案给的题号
    var sixAnswer = sixAnswerArray[answers[6].rawValue]
    // 对应题号的答案
    let sixAnswersAnswerArray = [answers[sixAnswer[0]], answers[sixAnswer[1]], answers[8]]
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
    for select in answers {
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
    var sevenAnswerArray = [Select.C, Select.B, Select.A, Select.D]
    // 获取给的答案是ABCD哪个
    let sevenAnswer = sevenAnswerArray[answers[7].rawValue]
    // 从abcdCountArray取出对应字母的出现次数
    let minCountAnswer = abcdCountArray[sevenAnswer.rawValue]
    if minCountAnswer != min(ACount, BCount, CCount, DCount) {
        // 如果不是真正的最小值
        return false
    }
    
    // 题8
    var eightAnswerArray = [7, 5, 2, 10]
    let eightAnswer = eightAnswerArray[answers[8].rawValue]
    let eightAnswersAnswer = answers[eightAnswer]
    let firstAnswer = answers[1]
    let value1 = firstAnswer.rawValue
    let value2 = eightAnswersAnswer.rawValue
    // 相邻 = 1
    if abs(value1 - value2) == 1 {
        return false
    }
    
    // 题9
    let boolen16 = (answers[1] == answers[6])
    var nineAnswerArray = [6, 10, 2, 9]
    let nineAnswer = nineAnswerArray[answers[9].rawValue]
    let nineAnswersAnswer = answers[nineAnswer]
    let boolenx5 = (answers[5] == nineAnswersAnswer)
    // 1/6 与 x/5 相反
    if boolen16 == boolenx5 {
        return false
    }
    
    // 题10
    let maxABCDCount = max(ACount, BCount, CCount, DCount)
    let minABCDCount = min(ACount, BCount, CCount, DCount)
    let distance = maxABCDCount - minABCDCount
    var tenAnswerArray = [3, 2, 4, 1]
    if distance != tenAnswerArray[answers[10].rawValue] {
        return false
    }
    return true
}


// MARK: Start

let selectArray: [Select] = [.A, .B, .C, .D]

var answers: [Select] = []
var trueAnswersCount = 0
func getAnswer(for index: Int = 0) {
    if index >= 10 {// 0...9
        // 判断答案
        if isTrueAnswers(answers) {
            trueAnswersCount += 1
            printAnswers(answers)
        }
        return
    }
    for answer in selectArray {
        answers.append(answer)
        getAnswer(for: (index + 1))
        answers.removeLast()
    }
}

getAnswer()
print("总共有 \(trueAnswersCount) 种答案")



