#/usr/bin/python
#-*- coding: utf-8 -*-

from enum import Enum

#######################################################################################
#############################           DataModel         #############################
#######################################################################################
class Select(Enum):
    none = -1
    A = 0
    B = 1
    C = 2
    D = 3

    def description(self):
        if self == Select.A:
            return "A"
        elif self == Select.B:
            return "B"
        elif self == Select.C:
            return "C"
        elif self == Select.D:
            return "D"
        else:
            return " Error "

    def rawValue(self):
        if self == Select.A:
            return 0
        elif self == Select.B:
            return 1
        elif self == Select.C:
            return 2
        elif self == Select.D:
            return 3
        else:
            return -1


def printAnswers(answers):
    str = ""
    for index in range(1, 11):
        answer = answers[index]
        str += answer.description()
    print(str)



#######################################################################################
#############################         Logic Test          #############################
#######################################################################################
def isTrueAnswers(answers):
    # 题1 不用管
    # 题2
    if (answers[2] == Select.A and answers[5] != Select.C) or (answers[2] == Select.B and answers[5] != Select.D) or (answers[2] == Select.C and answers[5] != Select.A) or (answers[2] == Select.D and answers[5] != Select.B):
        return False
    # 题3
    threeAnswerArray = [answers[3], answers[6], answers[2], answers[4]]
    threeAnswerIndex = answers[3].rawValue()
    diffrentAnswer = threeAnswerArray.pop(threeAnswerIndex)
    equealAnswerSet = set(threeAnswerArray)
    # 剩下的不是同一个答案
    if len(equealAnswerSet) != 1:
        return False

    # 四个全是相同的
    if diffrentAnswer == threeAnswerArray[0]:
        return False

    # 题4
    fourAnswerIndex = answers[4].rawValue()
    fourAnswerArray = [[1, 5], [2, 7], [1, 9], [6, 10]]
    foueAnswer = fourAnswerArray[fourAnswerIndex]
    if answers[foueAnswer[0]] != answers[foueAnswer[1]]:
        return False

    # 题5
    fiveAnswerArray = [8, 4, 9, 7]
    fiveAnswerIndex = answers[5].rawValue()
    fiveAnswer = fiveAnswerArray[fiveAnswerIndex]
    if answers[5] != answers[fiveAnswer]:
        return False

    # 题6
    sixAnswerArray = [[2, 4], [1, 6], [3, 10], [5, 9]]
    # 答案给的题号
    sixAnswer = sixAnswerArray[answers[6].rawValue()]
    # 对应题号的答案
    sixAnswersAnswerArray = [answers[sixAnswer[0]], answers[sixAnswer[1]], answers[8]]
    # 对应题号的答案Set
    sixAnswersAnswerSet = set(sixAnswersAnswerArray)
    if len(sixAnswersAnswerSet) != 1:
        return False

    # 题7
    ACount = 0
    BCount = 0
    CCount = 0
    DCount = 0
    for select in answers:
        if select == Select.A:
            ACount += 1
        elif select == Select.B:
            BCount += 1
        elif select == Select.C:
            CCount += 1
        elif select == Select.D:
            DCount += 1

    abcdCountArray = [ACount, BCount, CCount, DCount]
    sevenAnswerArray = [Select.C, Select.B, Select.A, Select.D]
    # 获取给的答案是ABCD哪个
    sevenAnswer = sevenAnswerArray[answers[7].rawValue()]
    # 从abcdCountArray取出对应字母的出现次数
    minCountAnswer = abcdCountArray[sevenAnswer.rawValue()]
    if minCountAnswer != min(ACount, BCount, CCount, DCount):
        # 如果不是真正的最小值
        return False

    # 题8
    eightAnswerArray = [7, 5, 2, 10]
    eightAnswer = eightAnswerArray[answers[8].rawValue()]
    eightAnswersAnswer = answers[eightAnswer]
    firstAnswer = answers[1]
    value1 = firstAnswer.rawValue()
    value2 = eightAnswersAnswer.rawValue()
    # 相邻 = 1
    if abs(value1 - value2) == 1:
        return False

    # 题9
    boolen16 = (answers[1] == answers[6])
    nineAnswerArray = [6, 10, 2, 9]
    nineAnswer = nineAnswerArray[answers[9].rawValue()]
    nineAnswersAnswer = answers[nineAnswer]
    boolenx5 = (answers[5] == nineAnswersAnswer)
    # 1/6 与 x/5 相反
    if boolen16 == boolenx5:
        return False

    # 题10
    maxABCDCount = max(ACount, BCount, CCount, DCount)
    minABCDCount = min(ACount, BCount, CCount, DCount)
    distance = maxABCDCount - minABCDCount
    tenAnswerArray = [3, 2, 4, 1]
    if distance != tenAnswerArray[answers[10].rawValue()]:
        return False

    return True


#######################################################################################
#############################            Start            #############################
#######################################################################################

selectArray = [Select.A, Select.B, Select.C, Select.D]

# 方便从1开始，开头加一个 Select.none
answers = [Select.none]
global trueAnswersCount
trueAnswersCount = 0
def getAnswer():
    if len(answers) <= 10:
        # 1...10位，0位不使用
        for answer in selectArray:
            answers.append(answer)
            getAnswer()
            answers.pop()
    else:
        # 判断答案
        if isTrueAnswers(answers):
            global trueAnswersCount
            trueAnswersCount += 1
            printAnswers(answers)


getAnswer()
print("总共有 " + str(trueAnswersCount)+ " 种答案")




