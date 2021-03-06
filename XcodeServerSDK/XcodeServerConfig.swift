//
//  XcodeServerConfig.swift
//  XcodeServerSDK
//
//  Created by Mateusz Zając on 13.06.2015.
//  Copyright © 2015 Honza Dvorsky. All rights reserved.
//

import Foundation
import BuildaUtils

/// Posible errors thrown by `XcodeServerConfig`
public enum ConfigurationErrors : Error {
    /// Thrown when no host was provided
    case noHostProvided
    /// Thrown when an invalid host is provided (host is returned)
    case invalidHostProvided(String)
    /// Thrown when a host is provided with an invalid scheme (explanation message returned)
    case invalidSchemeProvided(String)
    /// Thrown when only one of (username, password) is provided, which is not valid
    case invalidCredentialsProvided
}

private struct Keys {
    static let Host = "host"
    static let User = "user"
    static let Password = "password"
    static let Id = "id"
}

public struct XcodeServerConfig : JSONSerializable {
    public let id: RefType
    public var host: String
    public var user: String?
    public var password: String?
    
    public let port: Int = 20343
    
    //if set to false, fails if server certificate is not trusted yet
    public let automaticallyTrustSelfSignedCertificates: Bool = true
    
    public func jsonify() -> [String : Any] {
        let dict = NSMutableDictionary()
        dict[Keys.Id] = self.id
        dict[Keys.Host] = self.host
        dict.optionallyAddValueForKey(self.user as AnyObject, key: Keys.User)
        return dict as! [String : Any]
    }
    
    //creates a new default config
    public init() {
        self.id = Ref.new()
        self.host = ""
        self.user = nil
        self.password = nil
    }
    
    /**
    Initializes a server configuration with the provided host.
    - parameter host: `Xcode` server host.
    - paramater user: Username that will be used to authenticate against the `host` provided.
    Can be `nil`.
    
    - parameter password: Password that will be used to authenticate against the `host` provided.
    Can be `nil`.
    
    - returns: A fully initialized `XcodeServerConfig` instance.
    
    - throws:
        - `NoHostProvided`: When the host string is empty.
        - `InvalidHostProvided`: When the host provided doesn't produce a valid `URL`
        - `InvalidSchemeProvided`: When the provided scheme is not `HTTPS`
    */
    public init(host _host: String, user: String? = nil, password: String? = nil, id: RefType? = nil) throws {
        
        var host = _host
        
        guard !host.isEmpty else {
            throw ConfigurationErrors.noHostProvided
        }
        
        guard let url = NSURL(string: host) else {
            throw ConfigurationErrors.invalidHostProvided(host)
        }
        
        guard url.scheme?.isEmpty == true || url.scheme == "https" else {
            let errMsg = "Xcode Server generally uses https, please double check your hostname"
            Log.error(errMsg)
            throw ConfigurationErrors.invalidSchemeProvided(errMsg)
        }
        
        // validate if host is a valid URL
        if url.scheme?.isEmpty == true {
            // exted host with https scheme
            host = "https://" + host
        }
        
        self.host = host
        self.user = user
        self.password = password
        self.id = id ?? Ref.new()
    }
    
    /**
    Initializes a server configuration with the provided `json`.
    - parameter json: `NSDictionary` containing the `XcodeServerConfig` «configuration».
    
    - returns: A fully initialized `XcodeServerConfig` instance.
    
    - throws:
        - `NoHostProvided`: When no `host` key was found on the provided `json` dictionary.
        - `InvalidHostProvided`: When the host provided doesn't produce a valid `URL`
        - `InvalidSchemeProvided`: When the provided scheme is not `HTTPS`
    */
    public init(json: [String : Any]) throws {
        
        guard let host = (json as NSDictionary).optionalStringForKey(Keys.Host) else {
            throw ConfigurationErrors.noHostProvided
        }

        let user = (json as NSDictionary).optionalStringForKey(Keys.User)
        let password = (json as NSDictionary).optionalStringForKey(Keys.Password)
        let id = (json as NSDictionary).optionalStringForKey(Keys.Id)
        try self.init(host: host, user: user, password: password, id: id)
    }
}
