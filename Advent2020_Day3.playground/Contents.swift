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

struct Coordinates {
    let x: Int
    let y: Int
}

let input = text.components(separatedBy: "\n")

func move(start: Coordinates, move: Coordinates, array: [String]) -> (position: Coordinates, hitTree: Bool) {
    
    let y = start.y + move.y
    let row = Array(array[y])

    var x = start.x + move.x
   
    if x >= row.count {
        x -= row.count
    }

    let hitTree = (String(row[x]) == "#")
    return (position: Coordinates(x: x, y: y), hitTree: hitTree)
}

func countTrees(movement: Coordinates, array: [String]) -> Int {
    
    var count = 0
    var position = Coordinates(x: 0, y: 0)
    var hitTree = false
        
    repeat {
        (position, hitTree) = move(start: position, move: movement, array: array)
        
        if hitTree {
            count += 1
        }
        print(position)
        
    } while position.y < input.count - 1
 
    return count
    
}

let numberOfTrees = countTrees(movement: Coordinates(x: 3, y: 1), array: input)
print("Day 3, Part 1: ", numberOfTrees)

// MARK: Part 2

let result = countTrees(movement: Coordinates(x: 1, y: 1), array: input)
                * countTrees(movement: Coordinates(x: 3, y: 1), array: input)
                * countTrees(movement: Coordinates(x: 5, y: 1), array: input)
                * countTrees(movement: Coordinates(x: 7, y: 1), array: input)
                * countTrees(movement: Coordinates(x: 1, y: 2), array: input)

print("Day 3, Part 2: ", result)
