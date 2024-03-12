//
//  HelperFunctions.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 2/8/24.
//

import Foundation

///Returns is a role is of "Admin" status
func IsAdmin(_ role : eRole) -> Bool {
    return role == eRole.Admin
}
