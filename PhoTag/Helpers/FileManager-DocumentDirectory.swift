//
//  FileManager-DocumentDirectory.swift
//  PhoTag
//
//  Created by Al Fraser on 19/07/2023.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
