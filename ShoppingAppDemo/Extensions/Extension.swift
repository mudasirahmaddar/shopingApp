//
//  Extension.swift
//  ShoppingAppDemo
//
//  Created by mudasir ahmad dar on 26/01/24.
//

import Foundation

extension Decodable {
  static func parse(jsonFile: String) -> Self? {
    guard let url = Bundle.main.url(forResource: jsonFile, withExtension: "json"),
          let data = try? Data(contentsOf: url),
          let output = try? JSONDecoder().decode(self, from: data)
        else {
      return nil
    }

    return output
  }
}
