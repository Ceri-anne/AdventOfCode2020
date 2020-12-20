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

let input = text.components(separatedBy: "\n\n").map {
    $0.components(separatedBy: "\n")
}

func numberOfQuestionsAnsweredYes(_ array: [String]) -> Int {
    return Set(array.joined()).count
}

let part1 = input.map { numberOfQuestionsAnsweredYes($0) }

print("Day 6, Part 1: ", part1.reduce(0,+))

// MARK: Part 2

func numberOfQuestionsAllAnsweredYes(_ array: [String]) -> Int {
    
    var result = [String]()
    
    let allAnswers = array.joined()
    let uniqueAnswers = Set(array.joined())
    let number = array.count
    
    for item in uniqueAnswers {
        
        let count = allAnswers.filter {
            $0 == item
        }.count
    
        if count == number {
            result.append(String(item))
        }
    }

    return result.count
}

let part2 = input.map { numberOfQuestionsAllAnsweredYes($0) }

print("Day 6, Part 2: ", part2.reduce(0,+))

