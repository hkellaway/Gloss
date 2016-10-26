//
//  Comparators.swift
//  Gloss
//
//  Created by Maciej Kołek on 10/18/16.
//  Copyright © 2016 Harlan Kellaway. All rights reserved.
//

import Foundation
import Gloss

func ==(lhs: JSON, rhs: JSON ) -> Bool {
    return NSDictionary(dictionary: lhs).isEqual(to: rhs)
}
