//
//  Helpers.swift
//  App
//
//  Created by Stephen Bodnar on 5/12/18.
//

import Foundation

class Helpers {
    // credit for this randomToken method: https://stackoverflow.com/questions/26845307/generate-random-alphanumeric-string-in-swift
    class func randomToken(withLength length: Int) -> String {
        let allowedChars = "$!@&#abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let allowedCharsCount = UInt32(allowedChars.count)
        var randomString = ""
        for _ in 0..<length {
            let randomNumber = Int(arc4random_uniform(allowedCharsCount))
            let randomIndex = allowedChars.index(allowedChars.startIndex, offsetBy: randomNumber)
            let newCharacter = allowedChars[randomIndex]
            randomString += String(newCharacter)
        }
        return randomString
    } 
}
