//
//  InvalidCredentialError.swift
//  
//
//  Created by Scott Petit on 4/5/23.
//

import Foundation

public struct InvalidCredentialError: Error, LocalizedError {
    
    public var errorDescription: String? {
        "Invalid Credential"
    }
    
}
