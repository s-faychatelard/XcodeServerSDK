//
//  Bot.swift
//  Buildasaur
//
//  Created by Honza Dvorsky on 14/12/2014.
//  Copyright (c) 2014 Honza Dvorsky. All rights reserved.
//

import Foundation

open class Bot : XcodeServerEntity {
    
    open let name: String
    open let configuration: BotConfiguration
    open let integrationsCount: Int
    open let json: NSDictionary?

    public required init(json: NSDictionary) throws {
        
        self.json = json
        self.name = try json.stringForKey("name")
        self.configuration = try BotConfiguration(json: try json.dictionaryForKey("configuration"))
        self.integrationsCount = json.optionalIntForKey("integration_counter") ?? 0
        
        try super.init(json: json)
    }
    
    /**
    *  Creating bots on the server. Needs dictionary representation.
    */
    public init(name: String, configuration: BotConfiguration) {
        
        self.json = nil
        self.name = name
        self.configuration = configuration
        self.integrationsCount = 0
        
        super.init()
    }

    open override func dictionarify() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        //name
        dictionary["name"] = self.name
        
        //configuration
        dictionary["configuration"] = self.configuration.dictionarify()
        
        //others
        dictionary["type"] = 1 // magic more
        dictionary["requiresUpgrade"] = false
        dictionary["group"] = [
            "name": UUID().uuidString
        ]
        
        return dictionary
    }
    

}

extension Bot : CustomStringConvertible {
    public var description : String {
        get {
            return "[Bot \(self.name), \(self.json ?? [:])]"
        }
    }
}


