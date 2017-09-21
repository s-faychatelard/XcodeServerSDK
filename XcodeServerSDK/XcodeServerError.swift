//
//  XcodeServer.swift
//  Buildasaur
//
//  Created by Honza Dvorsky on 14/12/2014.
//  Copyright (c) 2014 Honza Dvorsky. All rights reserved.
//

import Foundation

public class XcodeServerError: Error {
    public static func with(_ info: String) -> Error {
        return NSError(domain: "xcodeserver", code: -1, userInfo: ["info": info])
    }
}
