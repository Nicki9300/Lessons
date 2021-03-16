//
//  Secitons.swift
//  Mamchur
//
//  Created by Kolya Mamchur on 03.03.2021.
//


enum EnumFirstSection: Int, CaseIterable {
    case firstName
    case secondName
    case mobileNumber
    case emailAdress
}

enum EnumSecondSection: Int, CaseIterable {
    case newPassword
    case retypeNewPassword
    case button
}

enum EnumOfSections: Int, CaseIterable {
    
    case enumFirstSection
    case enumSecondSection
}
