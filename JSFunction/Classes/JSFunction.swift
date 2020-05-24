//
//  JSFunction.swift
//  JSFunction
//
//  Created by DH on 2020/05/24.
//  Copyright © 2020 outofcode. All rights reserved.
//

import UIKit

public protocol JSFunction : NSObject {
    var name: String { get }
    init(name: String)
}
