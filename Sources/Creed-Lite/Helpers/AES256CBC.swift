//
//  AES256CBC.swift
//  AES256CBC https://github.com/SwiftyBeaver/AES256CBC
//
//  Created by Sebastian Kreutzberger on 2/9/16.
//  Copyright © 2016 SwiftyBeaver. All rights reserved.
//
import Foundation
import CommonCrypto

public final class AES256CBC {

    enum Error: Swift.Error {
        case encryptionError(status: CCCryptorStatus)
        case decryptionError(status: CCCryptorStatus)
        case keyDerivationError(status: CCCryptorStatus)
    }

    public class func encrypt(data: Data, key: Data) -> Data? {
        // Output buffer (with padding)
        let iv = generateBytes(length: 16)!
        let outputLength = data.count + kCCBlockSizeAES128
        var outputBuffer = [UInt8](repeating: 0,
                                        count: outputLength)
        var numBytesEncrypted = 0
        let status = CCCrypt(CCOperation(kCCEncrypt),
                             CCAlgorithm(kCCAlgorithmAES),
                             CCOptions(kCCOptionPKCS7Padding),
                             Array(key),
                             kCCKeySizeAES256,
                             Array(iv),
                             Array(data),
                             data.count,
                             &outputBuffer,
                             outputLength,
                             &numBytesEncrypted)
        guard status == kCCSuccess else {
            return nil
        }
        let outputBytes = iv + outputBuffer.prefix(numBytesEncrypted)
        return Data(outputBytes)
    }

    public class func decrypt(data cipherData: Data, key: Data) -> Data? {
        // Split IV and cipher text
        let iv = cipherData.prefix(kCCBlockSizeAES128)
        let cipherTextBytes = cipherData
                               .suffix(from: kCCBlockSizeAES128)
        let cipherTextLength = cipherTextBytes.count
        // Output buffer
        var outputBuffer = [UInt8](repeating: 0,
                                        count: cipherTextLength)
        var numBytesDecrypted = 0
        let status = CCCrypt(CCOperation(kCCDecrypt),
                             CCAlgorithm(kCCAlgorithmAES),
                             CCOptions(kCCOptionPKCS7Padding),
                             Array(key),
                             kCCKeySizeAES256,
                             Array(iv),
                             Array(cipherTextBytes),
                             cipherTextLength,
                             &outputBuffer,
                             cipherTextLength,
                             &numBytesDecrypted)
        guard status == kCCSuccess else {
            return nil
        }
        // Discard padding
        let outputBytes = outputBuffer.prefix(numBytesDecrypted)
        return Data(outputBytes)
    }

    public class func generateBytes(length: Int) -> Data? {
        var bytes = [UInt8](repeating: UInt8(0), count: length)
        let statusCode = CCRandomGenerateBytes(&bytes, bytes.count)
        if statusCode != CCRNGStatus(kCCSuccess) {
            return nil
        }
        return Data(bytes)
    }
}
