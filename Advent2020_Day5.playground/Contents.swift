//// Playground that reads data in from a file on disk

import Foundation

// MARK: Import data

guard let fileUrl = Bundle.main.url(forResource: "input", withExtension: "txt") else {

    fatalError(
    """
    Expected input.txt to exist in Resources.
    To add file to playground:
    1. Open the Utility Inspector (Option+Cmd+1)
    2. Drag file from Finder to Resources folder
    """)
}

guard let text = try? String(contentsOf: fileUrl, encoding: String.Encoding.utf8) else {
    fatalError("Expected data to be text")
}

// MARK: Part 1

let input = text.components(separatedBy: "\n")

let string = "FBFBBFFRLR"

func row(_ text: String, range: ClosedRange<Int>) -> Int {
    
    let array  = Array(text)[0...6]
    
    var mutableRange = range
    
    for item in array {
        if String(item) == "F" {
            mutableRange = half(mutableRange, type: .lower)
        } else {
            mutableRange = half(mutableRange, type: .upper)
        }
       
    }
    
    return mutableRange.first!
}

enum Type {
    case upper
    case lower
}

func half(_ range: ClosedRange<Int>, type: Type) -> ClosedRange<Int> {
  
    let half = range.count / 2
     
    let midpoint = range.first! + half
   
    switch type {
    case .lower:
        return range.first!...(midpoint - 1)
    case .upper:
        return midpoint...range.last!
    }
}

func column(_ text: String, range: ClosedRange<Int>) -> Int {
    
    let array  = Array(text)[7...9]
    
    var mutableRange = range
    
    for item in array {

        if String(item) == "L" {
            mutableRange = half(mutableRange, type: .lower)
        } else {
            mutableRange = half(mutableRange, type: .upper)
        }
       
    }
    
    return mutableRange.first!
    
}

func seatID(row: Int, column: Int) -> Int {
    return row * 8 + column
}

let seatIDs = input.map {
    seatID(
        row: row($0, range: 0...127),
        column: column($0, range: 0...7))
}

print("Day 5, Part 1: ", seatIDs.max()!)

// MARK: Part 2

func missingBoardingPass(in array: [Int]) -> Int {

    let sorted = seatIDs.sorted()

    for i in 1..<(sorted.count-1) {
        
        if sorted[i] != sorted[i-1] + 1 {
            return sorted[i] - 1
        }
    }
    
    return 0
}

let id = missingBoardingPass(in: seatIDs)
print("Day 5, Part 2: ", id)
