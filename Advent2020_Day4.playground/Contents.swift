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

let input = text.components(separatedBy: "\n\n").map { $0.replacingOccurrences(of: "\n", with: " ").components(separatedBy: " ") }

// MARK: Part 1

func isValidPassport(_ array: [String]) -> Bool {

    var dict = [String: String]()

    for item in array {
        let components = item.components(separatedBy: ":")
        dict[components[0]] = components[1]
    }

    return dict.keys.contains("byr")
        && dict.keys.contains("iyr")
        && dict.keys.contains("eyr")
        && dict.keys.contains("hgt")
        && dict.keys.contains("hcl")
        && dict.keys.contains("ecl")
        && dict.keys.contains("pid")
   
}


let validPassports = input.map { isValidPassport($0) }.filter { $0 == true }.count
print("Day 4, Part 1 :", validPassports)

// MARK: Part 2

func isValidPassport2(_ array: [String]) -> Bool {

    var dict = [String: String]()

    for item in array {
        let components = item.components(separatedBy: ":")
        dict[components[0]] = components[1]
    }
        
    guard dict.keys.contains("byr"), let birthYear = dict["byr"], isValidBirthYear(birthYear) else {
        return false
    }
    
    guard dict.keys.contains("iyr"), let issueYear = dict["iyr"], isValidIssueYear(issueYear) else {
        return false
    }
    
    guard dict.keys.contains("eyr"), let expiryYear = dict["eyr"], isValidExpiryYear(expiryYear) else {
        return false
    }
  
    guard dict.keys.contains("hgt"), let height = dict["hgt"], isValidHeight(height) else {
        return false
    }
    
    guard dict.keys.contains("hcl"), let hairColour = dict["hcl"], isValidHairColour(hairColour) else {
        return false
    }
    
    guard dict.keys.contains("ecl"), let eyeColour = dict["ecl"], isValidEyeColour(eyeColour) else {
        return false
    }
    
    guard dict.keys.contains("pid"), let passportID = dict["pid"], isValidPassportID(passportID) else {
        return false
    }
  
    return true

}

func isValidBirthYear(_ year: String) -> Bool {
    
    guard let intBirthYear = Int(year) else {
        return false
    }
    
    guard intBirthYear >= 1920 && intBirthYear <= 2002 else {
        return false
    }
    
    return true
}

func isValidIssueYear(_ year: String) -> Bool {
    
    guard let intIssueYear = Int(year) else {
        return false
    }
    
    guard intIssueYear >= 2010 && intIssueYear <= 2020 else {
        return false
    }
    
    return true
}

func isValidExpiryYear(_ year: String) -> Bool {
    
    guard let intExpiryYear = Int(year) else {
        return false
    }
    
    guard intExpiryYear >= 2020 && intExpiryYear <= 2030 else {
        return false
    }
    
    return true
}

func isValidHeight(_ height: String) -> Bool {
    
    if height.contains("cm") {
         guard let intHeight = Int(String(height.dropLast(2))) else {
             return false
         }
         
         guard intHeight >= 150 && intHeight <= 193 else {
             return false
         }
         
     } else if height.contains("in") {
         guard let intHeight = Int(String(height.dropLast(2))) else {
             return false
         }
         
         guard intHeight >= 59 && intHeight <= 76 else {
             return false
         }
         
     } else {
         return false
     }
    
    return true
}

func isValidHairColour(_ colour: String) -> Bool {

    guard let first = colour.first, first == "#" else {
        return false
    }
    
    let item = colour.dropFirst()
    
    guard item.count == 6 else {
        return false
    }
  
    let hex = item.filter { $0.isHexDigit }
    
    guard hex.count == 6 else {
        return false
    }
   
    return true
}

func isValidEyeColour(_ colour: String) -> Bool {
    
    switch colour {
    case "amb", "blu", "brn", "gry", "grn", "hzl", "oth":
        return true
    default:
        return false
    }
   
}

func isValidPassportID(_ id: String) -> Bool {
    
    guard id.count == 9 else {
        return false
    }
    
    guard let _ = Int(id) else {
        return false
    }

    return true
}

let validPassports2 = input.map { isValidPassport2($0)}.filter { $0 == true }.count

print("Day 4, Part 2 :", validPassports2)
