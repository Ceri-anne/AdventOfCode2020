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

let input = text.components(separatedBy: "\n")

// MARK: Part 1

func isValidPassword(_ string: String) -> Bool {
    
    let array = string.components(separatedBy: " ")

    let frequencies = array[0].components(separatedBy: "-")
   
    guard let min = Int(frequencies[0]), let max = Int(frequencies[1]) else {
        fatalError("Expected min and max")
    }
   
    let letter = String(array[1].components(separatedBy: ":")[0])
    
    let count = Array(array[2]).filter { String($0) == letter }.count
    
    return count >= min && count <= max
}

let validPasswords = input.filter { isValidPassword($0) == true }

print("Day 2, Part 1: ", validPasswords.count)

func isValidPasswordDay2(_ string: String) -> Bool {
    
    let array = string.components(separatedBy: " ")

    let frequencies = array[0].components(separatedBy: "-")
   
    guard let firstPosition = Int(frequencies[0]), let secondPosition = Int(frequencies[1]) else {
        fatalError("Expected min and max")
    }
   
    let letter = String(array[1].components(separatedBy: ":")[0])

    let password = Array(array[2])

    let firstLetter = String(password[firstPosition - 1])
    let secondLetter = String(password[secondPosition - 1])
    
    if firstLetter == letter && secondLetter == letter {
        return false
    }
    
    return firstLetter == letter || secondLetter == letter
}

let validPasswordsDay2 = input.filter { isValidPasswordDay2($0) == true }

print("Day 2, Part 2: ", validPasswordsDay2.count)
