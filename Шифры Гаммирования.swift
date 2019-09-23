let surname = "вдовиченко"
let letters = ["а", "б", "в", "г", "д", "е", "ё", "ж", "з", "и", "й", "к", "л", "м", "н", "о", "п", "р", "с", "т", "у", "ф", "х", "ц", "ч", "ш", "щ", "ъ", "ы", "ь", "э", "ю", "я"]

let key = "програмный"

//Завдання 1

func addLettersToKey(_ key: String, surname: String) -> String {
    var index = 0
    var array = Array(key)
    
    while array.count != surname.count {
        array.append(array[index])
        index += 1
    }
    var strToReturn = ""
    for letter in array {
        strToReturn.append(letter)
    }
    return strToReturn
}

var newKey = addLettersToKey(key, surname: surname)

func generateDict(_ array: [String], startIndex: Int = 0) -> [String: Int] {
    var lettersDict = [String: Int]()
    var index = startIndex
    for letter in array {
        lettersDict.updateValue(index, forKey: letter)
        index += 1
    }
return lettersDict
}

let dict = generateDict(letters)

func getArrayOfKeys(_ str: String, from dict: [String: Int]) -> [Int] {
    var keys = [Int]()
    for letter in str {
        let workChar = String(letter)
        guard let key = dict[workChar] else {return keys}
        keys.append(key)
    }
    return keys
}

let surnameKeys = getArrayOfKeys(surname, from: dict)

let newKeyKeys = getArrayOfKeys(newKey, from: dict)

func generateMessage(_ first: [Int], and second: [Int]) -> String {
    var strToReturn = ""
    let count = letters.count
    
    for index in first.indices {
        let firstNum = first[index]
        let secondNum = second[index]
        
        var sum = firstNum + secondNum
        
        if sum >= count {
            sum -= count
        }
        strToReturn.append(letters[sum])
    }
    
    return strToReturn
}
let message1 = generateMessage(surnameKeys, and: newKeyKeys)
print("Задание 1: \(message1)")


//Завдання 2

class Letter {
    let ascii: Int
    let binary: UInt8
    
    init(ascii: Int, binary: UInt8) {
        self.ascii = ascii
        self.binary = binary
    }
}

let newLetters = ["а", "б", "в", "г", "д", "е", "ж", "з", "и", "й", "к", "л", "м", "н", "о", "п", "р", "с", "т", "у", "ф", "х", "ц", "ч", "ш", "щ", "ъ", "ы", "ь", "э", "ю", "я"]
let dictFromNewLetters = generateDict(newLetters, startIndex: 192)

func pad(string : String, toSize: Int) -> String {
    var padded = string
    for _ in 0..<(toSize - string.count) {
        padded = "0" + padded
    }
    return padded
}

func generateBinaryDict(from dict: [String : Int]) -> [String: Letter] {
    var dictToReturn = [String : Letter]()
    for line in dict {
        let key = line.key
        let value = line.value
        let letter = Letter(ascii: value, binary: UInt8(value))
        dictToReturn.updateValue(letter, forKey: key)
    }
    return dictToReturn
}

let binaryDict = generateBinaryDict(from: dictFromNewLetters)


func generateBinaryFrom(_ binary: [String : Letter]) -> String {
    var str = ""
    for index in surname.indices {
        let surnameLetter = surname[index]
        let keyLetter = newKey[index]
        
        guard let sL = binaryDict[String(surnameLetter)] else {return str}
        guard let kL = binaryDict[String(keyLetter)] else {return str}
        
        let num = sL.binary^kL.binary
        let binaryStr = String(num, radix: 2)
        let padded = pad(string: binaryStr, toSize: 8)
        str.append(padded + " ")
    }
    return str
}

let binaryString = generateBinaryFrom(binaryDict)
print("Задание 2:", binaryString)







