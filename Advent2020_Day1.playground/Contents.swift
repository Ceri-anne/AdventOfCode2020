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

let array = text.components(separatedBy: "\n").compactMap { Int($0) }

// MARK: Part 1

let remainders = array.map { 2020 - $0 }

let inBoth = array.filter { remainders.contains($0) }

print("Day 1, Part 1: ", inBoth.reduce(1,*))

// MARK: Part 2

var secondArray = [[Int]]()

for i in 0..<array.count-1 {
    
    for j in (i+1)..<array.count {
        let sum = array[i] + array[j]

        if sum < 2020 {
            secondArray.append([array[i], array[j]])
        }
    }
}

var thirdArray = [[Int]]()

for i in 0..<secondArray.count-1 {
    
    for j in 0..<array.count {
        
        if secondArray[i].contains(array[j]) {
            break
        } else {
            let sum = secondArray[i].reduce(0,+) + array[j]
            if sum == 2020 {
                thirdArray.append([secondArray[i][0], secondArray[i][1], array[j]])
            }
        }
    }
   
}

print("Day 1, Part 2: ", thirdArray.first!.reduce(1,*))


