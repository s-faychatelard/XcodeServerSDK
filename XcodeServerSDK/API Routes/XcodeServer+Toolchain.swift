//
//  XcodeServer+Toolchain.swift
//  XcodeServerSDK
//
//  Created by Laurent Gaches on 21/04/16.
//  Copyright © 2016 Laurent Gaches. All rights reserved.
//

import Foundation
import BuildaUtils

// MARK: - Toolchain XcodeSever API Routes
extension XcodeServer {
    
    /**
     XCS API call for getting all available toolchains.
     
     - parameter toolchains: Optional array of available toolchains.
     - parameter error:      Optional error.
     */
    public final func getToolchains(_ completion: @escaping (_ toolchains: [Toolchain]?,_ error: Error?) -> ()) {
        let _ = self.sendRequestWithMethod(.get, endpoint: .toolchains, params: nil, query: nil, body: nil) { (response, body, error) in
            if error != nil {
                completion(nil, error)
                return
            }
          
            if let body = (body as? NSDictionary)?["results"] as? NSArray {
                let (result, error): ([Toolchain]?, NSError?) = unthrow {
                    return try XcodeServerArray(body)
                }
                completion(result, error)
            } else {
                completion(nil, XcodeServerError.with("Wrong body \(String(describing: body))"))
            }
        }
    }
}
