//
//  String+Extension.swift
//  DecorAttendance
//
//  Created by Bibin Mathew on 9/24/19.
//  Copyright © 2019 Sreeith n  krishna. All rights reserved.
//

import UIKit

extension String{
    func trimLeadingAndTrailingSpaces()->String{
       let str = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        return str
    }
}
