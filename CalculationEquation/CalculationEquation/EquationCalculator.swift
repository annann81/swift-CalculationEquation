
//  Created by 陳 東暘 on 2017/3/23.
//  Copyright © 2017年 陳 東暘. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import Foundation

class EquationCalculator: NSObject {
        
    //正規表達式使用
    private func regularExpression (regex:String,validateString:String) -> [String]{
    do {
    let regex: NSRegularExpression = try NSRegularExpression(pattern: regex, options: [])
    let matches = regex.matches(in: validateString, options: [], range: NSMakeRange(0, validateString.count))
    var data:[String] = Array()
    for item in matches {
    let string = (validateString as NSString).substring(with: item.range)
    data.append(string)
    }
    return data
    }
    catch {
    return ["正規表示式有問題回來看這裡"]
    }
    }

    //刪除指定字元
    private func deleteSymbol(string:String,symbol:String) -> [String] {
        let matics = string.components(separatedBy: NSCharacterSet(charactersIn: symbol) as CharacterSet)
        return matics
    }

    
    let opSymbol: [String] = ["(","+","-","*","/","π","sin","cos","tan","sin⁻¹","cos⁻¹","tan⁻¹","sinh","cosh","tanh","sinh⁻¹","cosh⁻¹","tanh⁻¹","log","ln","e","^","√","∜","∛","⁻¹","±","𝑒","²","³"]
    
    var op_priority: [Int] = [0, 1, 1, 2, 2, 4, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 4 ,4, 4, 4 ,4 ,4 ,4, 4 ,5 ,4, 4, 4]
    
    let defaultFront : [String] = ["sin","cos","tan","sin⁻¹","cos⁻¹","tan⁻¹","sinh","cosh","tanh","sinh⁻¹","cosh⁻¹","tanh⁻¹","log","ln","√","∜","∛","π","𝑒","e","±"]
    
    let defaultBehind : [String] = ["⁻¹","²","³","𝑒"]
    
    var infix: [String] = []
    
        var postfix: [String] = []
        var stack: [String] = []
    
        var topIndex: Int = -1
        
        var maxStackNum: Int = 0
        

        init(intentative: [String]) {
        
             super.init()
            
            
            var inEquation: String = ""
            for i in 0..<intentative.count {
                inEquation += intentative[i]
            }
            
            infix = strToArray(inEquation: inEquation)

            maxStackNum = infix.count + 1
             
            to_postfix(infix: infix)
            
         }
    

    
        
        init(inEquation: String) {
            
            super.init()
            
            
            infix = strToArray(inEquation: inEquation)

            

        maxStackNum = infix.count + 1
        to_postfix(infix: infix)
       
    }
    
    private func strToArray(inEquation: String) -> [String] {
        let formula : String = inEquation
        
        var aformula = formula.removeAllSapce
            aformula = aformula.replacingOccurrences(of: "(-", with: "(0-")
            aformula = aformula.replacingOccurrences(of: "ˣ√", with: "∜")
            aformula = aformula.replacingOccurrences(of: "π", with: "π0")
            
        let provision : [String] = ["\\d*(\\.)?\\d*e"]

        var science_f : [String] = []
        for h in provision{
            let list = regularExpression(regex: h, validateString: formula)
            science_f.append(contentsOf: list)
        }
        var scienceList_f : [String] = []
        for i in science_f{
            let delete = deleteSymbol(string:i,symbol:"e")
            for h in delete{
                    scienceList_f.append(String(h))
                }
        }

        scienceList_f.removeAll(where: { $0 == ""})
        science_f.removeAll(where: { $0 == "e"})
        science_f = science_f.sorted(by : {( n1 ,n2) in return n1.length() > n2.length()})
        for n in science_f{
            aformula = aformula.replacingOccurrences(of: n, with: "fe")
        }

        let provision3 : [String] = ["e(\\-)?\\d*(\\.)?(\\d*)?"]

        var science_b : [String] = []
        for h in provision3{
            let list = regularExpression(regex: h, validateString: formula)
            science_b.append(contentsOf: list)
        }
        var scienceList_b : [String] = []
        for i in science_b{
            let delete = deleteSymbol(string:i,symbol:"e")
            for h in delete{
                    scienceList_b.append(String(h))
                }
        }

        scienceList_b.removeAll(where: { $0 == ""})
        science_b.removeAll(where: { $0 == "e"})
        science_b = science_b.sorted(by : {( n1 ,n2) in return n1.length() > n2.length()})

        for n in science_b{
            aformula = aformula.replacingOccurrences(of: n, with: "eb")
        }

        if aformula.substring(to: 1) == "-" {
            aformula.insert("0", at: aformula.index(from: 0))
        }
        
        aformula.append("  ")
        
        let provision2 : [String] = ["\\d*(\\.)?\\d*"]
        var numeral : [String] = []

        for h in provision2{
            let list = regularExpression(regex: h, validateString: aformula)
            numeral.append(contentsOf: list)
            numeral.removeAll(where: { $0 == ""})
        }

        let numSorted = numeral.sorted(by : {( n1 ,n2) in return n1.length() > n2.length()})

        for n in numSorted{
            aformula = aformula.replacingOccurrences(of: n, with: "m")
        }
        
        aformula = aformula.removeAllSapce

        var trigonometric: [String] = aformula.components(separatedBy: NSCharacterSet(charactersIn: "+-*/()emfb^√∛∜π𝑒±²³") as CharacterSet)
        trigonometric.removeAll(where: { $0 == " " })
        trigonometric.removeAll(where: { $0 == ""})
        
        let trigonometricSorted = trigonometric.sorted(by : {( n1 ,n2) in return n1.length() > n2.length()})
        
        for i in trigonometricSorted{
            aformula = aformula.replacingOccurrences(of: i, with: "s")
        }
        
        var opSymbol : [String]  = []
        for p in aformula{
            opSymbol.append(String(p))
            opSymbol.removeAll(where: { $0 == " " })
            opSymbol.removeAll(where: { $0 == ""})
            opSymbol.removeAll(where: { $0 == "m" })
            opSymbol.removeAll(where: { $0 == "s" })
            opSymbol.removeAll(where: { $0 == "f" })
            opSymbol.removeAll(where: { $0 == "b" })
        }

        var q : [Int] = []
        for r in opSymbol{
            q += aformula.indexes(of: r)
        }

        var opSymbolIndex: [Int] = []

        for value in q {
            if (opSymbolIndex.contains(value)) {
                continue
            }
            opSymbolIndex.append(value)
        }

        opSymbolIndex = opSymbolIndex.sorted()

        let scienceSymbolIndex_f = aformula.indexes(of: "f")
        let scienceSymbolIndex_b = aformula.indexes(of: "b")
        let numeralIndex = aformula.indexes(of: "m")
        let trigonometricIndex = aformula.indexes(of: "s")


        let allElement = scienceList_f + scienceList_b + numeral + trigonometric + opSymbol
        
        let allIndex = scienceSymbolIndex_f + scienceSymbolIndex_b + numeralIndex + trigonometricIndex + opSymbolIndex

        var dict = [Int:String]()
        for b in 0...allIndex.count-1{
            dict[allIndex[b]] = allElement[b]
        }

        let keySorted = dict.keys.sorted()

        var pending : [String] = []
        for i in keySorted{
            let j : String! = dict[i]
            pending.append(j)
        }

        var deleteIndex : [Int] = []
        for i in 0...pending.count - 1{
            if pending[pending.count - 1 ] == "0"{
                continue
            }else  if pending[i] == "0" && pending[i+1] == "-"{
                pending[i] = pending[i+1]+pending[i+2]
                deleteIndex.append(i+1)
                deleteIndex.append(i+2)
            }
        }
        var rightmul : [Int] = []
        deleteIndex = deleteIndex.sorted(by: {(n1 ,n2 ) in return n1 > n2 })
        for i in deleteIndex{
            pending.remove(at: i)
            
        }
        
        if defaultFront.contains(pending[0]){
        pending.insert("1", at: 0)
        }
        
        for d in 0...pending.count - 1 {
            if defaultFront.contains(pending[d]){
                if opSymbol.contains(pending[d-1]){
                    pending.insert("1", at: d)
                }
            }
            if defaultBehind.contains(pending[d]){
                pending.insert("1", at: d+1)
            }
            if pending[0] == "("{
                continue
            }else if pending[d] == "(" && opSymbol.contains(pending[d-1]) == false{
                    rightmul.append(d)
                }
        }
        
        if defaultBehind.contains(pending[pending.count-1]){
            pending.append("1")
        }
        
        rightmul = rightmul.sorted(by : {( n1 ,n2) in return n1 > n2})
        for i in rightmul{
                pending.insert("*", at: i)
        }
            
        return pending
    }
    
    func pushStack(item: String) {
     
        if (topIndex >= (maxStackNum - 1)) {
            
        } else {
            topIndex += 1

            stack.append(item)
           
        }

    }

    func popStack() -> String {
        var topIndexStack: String = ""
        if (topIndex == -1) {
            
            
        } else {
            topIndexStack = stack[topIndex]
            stack.remove(at: topIndex)
            
            topIndex -= 1
        }
       
        return topIndexStack

    }
    
    func stackPrint() {
        
        for i: Int in 0..<(topIndex + 1) {
            
        }
       
    }
    
    func IsEmpty() -> Bool
    {
      
        return (topIndex < 0) ? true : false
    }
    
    func IsFullinStack() -> Bool
    {
       
        return (topIndex >= maxStackNum - 1) ? true : false
    }
    
    func top_stackData() -> String
    {
        
        
        if stack == []{
            return "("
        }else{
        
        
        return stack[topIndex]
    }
    }
    func priority(c: String) -> Int
    {
        for i: Int in 0..<30 {
            if(opSymbol[i] == c) {

                return op_priority[i]
            }
        }
        return -1;
    }
    
    func to_postfix(infix: [String]) {
        
        var x: String = ""
        var y: String = ""
        
        for i in 0..<infix.count {
            
            x = infix[i]
           
            switch x {
            case "(":
                pushStack(item: x)
            case ")":
                while !IsEmpty() {
                    x = popStack()
                    if x == "(" {
                        break
                    } else {
                        postfix.append(x)
                    }
                }
            case "+":
                
                y = top_stackData()
                while priority(c: y) >= priority(c: x) {
                    postfix.append(popStack())
                    y = top_stackData()
                    
                }
                pushStack(item: x)
            case "-":
                
                y = top_stackData()
                
                while priority(c: y) >= priority(c: x) {
                    postfix.append(popStack())
                    y = top_stackData()
                    
                }
    
                pushStack(item: x)
            case "*":
                y = top_stackData()
                while priority(c: y) >= priority(c: x) {
                    postfix.append(popStack())
                    
                    y = top_stackData()
                }
                pushStack(item: x)
            case "/":
                y = top_stackData()
                while priority(c: y) >= priority(c: x) {
                    postfix.append(popStack())
                    y = top_stackData()
                }
                pushStack(item: x)
                
            case "sin":
                  y = top_stackData()
                  while priority(c: y) >= priority(c: x) {
                    postfix.append(popStack())
                    y = top_stackData()
                }
                pushStack(item: x)
                
            case "cos":
                  y = top_stackData()
                  while priority(c: y) >= priority(c: x) {
                    postfix.append(popStack())
                    y = top_stackData()
                }
                pushStack(item: x)
                
            case "tan":
                  y = top_stackData()
                  while priority(c: y) >= priority(c: x) {
                    postfix.append(popStack())
                    y = top_stackData()
                }
                pushStack(item: x)
                
            case "sin⁻¹":
                  y = top_stackData()
                  while priority(c: y) >= priority(c: x) {
                    postfix.append(popStack())
                    y = top_stackData()
                }
                pushStack(item: x)
                
            case "cos⁻¹":
              y = top_stackData()
              while priority(c: y) >= priority(c: x) {
                postfix.append(popStack())
                y = top_stackData()
            }
            pushStack(item: x)
                
            case "tan⁻¹":
              y = top_stackData()
              while priority(c: y) >= priority(c: x) {
                postfix.append(popStack())
                y = top_stackData()
            }
            pushStack(item: x)
                
            case "sinh":
              y = top_stackData()
              while priority(c: y) >= priority(c: x) {
                postfix.append(popStack())
                y = top_stackData()
            }
            pushStack(item: x)
                
            case "cosh":
              y = top_stackData()
              while priority(c: y) >= priority(c: x) {
                postfix.append(popStack())
                y = top_stackData()
            }
            pushStack(item: x)
                
            case "tanh":
              y = top_stackData()
              while priority(c: y) >= priority(c: x) {
                postfix.append(popStack())
                y = top_stackData()
            }
            pushStack(item: x)
                
            case "sinh⁻¹":
              y = top_stackData()
              while priority(c: y) >= priority(c: x) {
                postfix.append(popStack())
                y = top_stackData()
            }
            pushStack(item: x)
                
            case "cosh⁻¹":
              y = top_stackData()
              while priority(c: y) >= priority(c: x) {
                postfix.append(popStack())
                y = top_stackData()
            }
            pushStack(item: x)
                
            case "tanh⁻¹":
              y = top_stackData()
              while priority(c: y) >= priority(c: x) {
                postfix.append(popStack())
                y = top_stackData()
            }
            pushStack(item: x)
                
            case "^":
                y = top_stackData()
                while priority(c: y) >= priority(c: x) {
                  postfix.append(popStack())
                  y = top_stackData()
              }
              pushStack(item: x)
                
            case "e":
                y = top_stackData()
                while priority(c: y) >= priority(c: x) {
                        postfix.append(popStack())
                        y = top_stackData()
                    }
                    pushStack(item: x)
                
            case "√":
                y = top_stackData()
                while priority(c: y) >= priority(c: x) {
                        postfix.append(popStack())
                        y = top_stackData()
                    }
                    pushStack(item: x)
                
            case "∛":
                y = top_stackData()
                while priority(c: y) >= priority(c: x) {
                        postfix.append(popStack())
                        y = top_stackData()
                    }
                    pushStack(item: x)
                
            case "∜":
                y = top_stackData()
                while priority(c: y) >= priority(c: x) {
                        postfix.append(popStack())
                        y = top_stackData()
                    }
                    pushStack(item: x)
                    
            case "log":
                y = top_stackData()
                while priority(c: y) >= priority(c: x) {
                        postfix.append(popStack())
                        y = top_stackData()
                    }
                pushStack(item: x)
            case "ln":
                y = top_stackData()
                while priority(c: y) >= priority(c: x) {
                        postfix.append(popStack())
                        y = top_stackData()
                    }
                pushStack(item: x)
            
            case "𝑒":
                y = top_stackData()
                while priority(c: y) >= priority(c: x) {
                        postfix.append(popStack())
                        y = top_stackData()
                    }
                    pushStack(item: x)
                
            case "π":
                y = top_stackData()
                while priority(c: y) >= priority(c: x) {
                        postfix.append(popStack())
                        y = top_stackData()
                    }
                    pushStack(item: x)
                
                
            case "⁻¹":
                y = top_stackData()
                while priority(c: y) >= priority(c: x) {
                        postfix.append(popStack())
                        y = top_stackData()
                    }
                    pushStack(item: x)
                    
            case "²":
                y = top_stackData()
                while priority(c: y) >= priority(c: x) {
                        postfix.append(popStack())
                        y = top_stackData()
                    }
                    pushStack(item: x)
                
            case "³":
                y = top_stackData()
                while priority(c: y) >= priority(c: x) {
                        postfix.append(popStack())
                        y = top_stackData()
                    }
                    pushStack(item: x)
            
            case "±":
            y = top_stackData()
            while priority(c: y) >= priority(c: x) {
                    postfix.append(popStack())
                    y = top_stackData()
                }
                pushStack(item: x)
                
            default:
                postfix.append(x)
            }
        }
        
        
        while !IsEmpty() {
            postfix.append(popStack())
            
        }
        postfix.append("\0")
    }
//C為字元長度。裡面的數字為ＡＳＣＬＬ碼 //判斷數字
    func IsValue(c: String) -> Bool {
        var isValue: Bool = true
        if !c.hasPrefix("'") && !c.hasPrefix("\"") {
            for i: Int in 0..<(c as NSString).length {
                if !((((c as NSString).character(at: i) >= 48) && ((c as NSString).character(at: i) <= 57)) || ((c as NSString).character(at: i) == 46) || ((i == 0) && ((c as NSString).character(at: i) == 45) && (c as NSString).length >= 2) || ((i > 1) && ((c as NSString).character(at: i) == 45) && ((c as NSString).character(at: i - 1) == 101))) {
                    isValue = false
                }
            }
        } else {
            isValue = false
        }
        return isValue
    }
    
    func isValue(c: String) -> Bool {
        var isValue: Bool = true
        if !c.hasPrefix("'") && !c.hasPrefix("\"") {
            var s: String = c
            if c.hasSuffix("k") || c.hasSuffix("m") || c.hasSuffix("u") || c.hasSuffix("n") || c.hasSuffix("p") || c.hasSuffix("f") {
                s = (c as NSString).substring(to: ((c as NSString).length - 2))
            }
            for i: Int in 0..<(s as NSString).length {
                if !((((s as NSString).character(at: i) >= 48) && ((s as NSString).character(at: i) <= 57)) || ((s as NSString).character(at: i) == 46) || ((s as NSString).character(at: i) == 101) || ((i == 0) && ((s as NSString).character(at: i) == 45)) || ((i > 1) && ((s as NSString).character(at: i) == 45) && ((s as NSString).character(at: i - 1) == 101))) {
                    isValue = false
                }
            }
        } else {
            isValue = false
        }
        return isValue
    }
    
    func calculate() -> Any {
        
        if chackformula(formula: infix) == "ERROR"{
            
            return "Syntax ERROR"
        }
        
        
        var point: Int = 0
            stack.removeAll()
            stack = []
            topIndex = -1
        while postfix[point] != "\0" {
           
            while IsValue(c: postfix[point]) {
                
                pushStack(item: postfix[point])
                point += 1
              
            }
          
            let a: Double = Double(popStack())!
            stackPrint()
            
            
            let b: Double = Double(popStack())!
            var c: Double = 0.0

            switch postfix[point] {

            case "+":
                c = b + a
            case "-":
                c = b - a
            case "*":
                c = b * a
            case "/":
                c = b / a
            case "sin":
                c = b * sin(a * Double.pi / 180)
            case "cos":
                c = b * cos(a * Double.pi / 180)
            case "tan":
                c = b * tan(a * Double.pi / 180)
            case "sin⁻¹":
                c = b * (asin(a)) * 180 / Double.pi
            case "cos⁻¹":
                c = b * (acos(a)) * 180 / Double.pi
            case "tan⁻¹":
                c = b * (atan(a)) * 180 / Double.pi
            case "sinh":
                c = b * sinh(a)
            case "cosh":
                c = b * cosh(a)
            case "tanh":
                c = b * tanh(a)
            case "sinh⁻¹":
                c = b * asinh(a)
            case "cosh⁻¹":
                c = b * acosh(a)
            case "tanh⁻¹":
                c = b * atanh(a)
            case "e":
                c = b * pow(10, a)
            case "^":
                c = pow(b, a)
            case "√":
                c = b * sqrt(a)
            case "∛":
                c = b * pow( a ,1.0/3.0)
            case "∜":
                c = pow( a ,1.0/b)
            case "log":
                c = b * log10( a )
            case "ln":
                c = b * log( a )
            case "𝑒":
                c = b * exp( a )
            case "π":
                c = b * Double.pi + a
            case "⁻¹":
                c = a * pow(b,-1.0)
            case "²":
                c = a * pow(b, 2.0)
            case "³":
                c = a * pow(b, 3.0)
            case "±":
                c = a * b * (-1)
            default:
                c = b
            }
            
           
            pushStack(item: "\(c)")
            point += 1
        }
        
        return Double(popStack())!
        
    }
}



func chackformula(formula:[String]) -> String {
    
    let opSym: [String] = ["(","+","-","*","/","π","sin","cos","tan","sin⁻¹","cos⁻¹","tan⁻¹","sinh","cosh","tanh","sinh⁻¹","cosh⁻¹","tanh⁻¹","log","ln","e","^","√","∜","∛","⁻¹","±","²","³","𝑒"]

    var aformula = formula
    aformula.removeAll(where: { $0 == "("})
    aformula.removeAll(where: { $0 == ")"})


    for i in 0...aformula.count - 1 {
        if i % 2 != 0 && opSym.contains(aformula[i]) == false{
            return "ERROR"
        }else if i % 2 == 0 && opSym.contains(aformula[i]) == true{
            return "ERROR"
        }else if aformula.count <= 2{
            return "ERROR"
        }
    }
    return "ok"
}


