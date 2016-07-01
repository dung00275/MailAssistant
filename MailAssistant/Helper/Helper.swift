//
//  Helper.swift
//  MailAssistant
//
//  Created by Dung Vu on 6/30/16.
//  Copyright © 2016 Zinio Pro. All rights reserved.
//

import Foundation
// OK, let's go

// MARK: - Network tracking


// MARK: - Convert character set to string
func convertCharacterSetToString(_ characterSet: NSCharacterSet) -> String{
    var array      = [String]()
    for plane: UInt8 in 0...16 where characterSet.hasMemberInPlane(plane) {
        autoreleasepool({ () -> () in
            for character: UTF32Char in UInt32(plane) << 16...(UInt32(plane) + 1) << 16 where characterSet.longCharacterIsMember(character) {
                
                var endian = character.littleEndian
                guard let string = String(bytesNoCopy: &endian, length: 4, encoding: String.Encoding.utf32LittleEndian, freeWhenDone: false) else {
                    continue
                }
                
                array.append(string)
            }
        })
    }
    
    return array.joined(separator: "")
}
