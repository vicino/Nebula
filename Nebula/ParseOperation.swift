//
//  ParseOperation.swift
//  Vicino
//
//  Created by Alois Barreras on 6/28/16.
//  Copyright © 2016 Vicino. All rights reserved.
//

import Foundation
import CoreData

public class ParseOperation: NebulaOperation {
    
    public override func main() {
        guard let input = input as? Data else {
            return
        }
        
        do {
            let parsedData = try JSONSerialization.jsonObject(with: input, options: JSONSerialization.ReadingOptions.init(rawValue: 0))
            output = parsedData
        } catch {
            // do something with an error
        }
    }
}
