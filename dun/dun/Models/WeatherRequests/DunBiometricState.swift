//
//  DunBiometricState.swift
//  dun
//
//  Created by Sizwe Khathi on 2025/05/02.
//

import Foundation

public class DunLocationState {
    
    var lat: String = ""
    var long: String = ""
    
    public static let sharedInstance = DunLocationState()
    
    public init() {}
}
