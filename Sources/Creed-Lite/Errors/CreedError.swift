//
//  CreedError.swift
//  
//
//  Created by Scott Petit on 6/7/24.
//

import Foundation

public enum CreedError: Sendable, Error, LocalizedError {
    case invalidCredential(InvalidCredentialError)
    case contentNotFound
    
    public var errorDescription: String? {
        switch self {        
        case .invalidCredential(let invalidCredentialError):
            invalidCredentialError.errorDescription
        case .contentNotFound:
            "Content Not Found"
        }
    }
}
