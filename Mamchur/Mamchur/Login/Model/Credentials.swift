//
//  User.swift
//  Mamchur
//
//  Created by Kolya Mamchur on 18.03.2021.
//
import Foundation

struct Credentials {
    var email: String
    var password: String
}

enum KeychainError: Error {
    case noPassword
    case unexpectedPasswordData
    case unhandledError(status: OSStatus)
}
