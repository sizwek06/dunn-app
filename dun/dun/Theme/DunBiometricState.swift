//
//  DunBiometricState.swift
//  dun
//
//  Created by Sizwe Khathi on 2025/05/02.
//

import Foundation

public class DunBiometricState {
    
    var currentState: DunBiometricStates = .signedInNoFaceId
    
    public static let sharedInstance = DunBiometricState()
    
    public init() {}
}

enum DunBiometricStates {
    case signedInWithFaceId
    case verifyFaceIdFailed
    case signingInWithFaceId
    case faceIDRequired
    case signedInNoFaceId
}
