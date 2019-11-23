//
//  JsonableExt.swift
//  Reach Plus
//
//  Created by Sameh sayed on 7/25/19.
//  Copyright © 2019 Reach. All rights reserved.

import Foundation

protocol Jsonable
{}

extension Jsonable where Self: Codable
{
    func convertToDictionary() -> NSDictionary?
    {
        guard let userData = try? JSONEncoder().encode(self) else { return nil }
        let dictionary = try? JSONSerialization.jsonObject(with: userData, options: .allowFragments) as? NSDictionary
        return dictionary
    }
}
