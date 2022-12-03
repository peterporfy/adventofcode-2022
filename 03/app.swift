#!/usr/bin/swift

import Foundation

func loadData(_ path: String) -> String {
  do {
    return try String(contentsOfFile: path)
  } catch {
    print(error)
    return ""
  }
}

func parse(_ data: String) -> [String] {
  data.split(separator: "\n").filter { $0 != "" }.map { String($0) }
}

func mistake(of sack: String) -> Character? {
    let chars = Array(sack)
    let middle = chars.count / 2
    let compartmentA = Set(chars[0..<middle])
    let compartmentB = chars[middle...chars.count - 1]

    for item in compartmentB {
      if compartmentA.contains(item) {
        return item
      }
    }

    return nil
}

func priority(of itemMaybe: Character?) -> Int {
  guard let item = itemMaybe, let ascii = item.asciiValue else { return 0 }

  if item.isUppercase {
    return Int(ascii - 38)
  } else {
    return Int(ascii - 96)
  }
}

func main() {
  let sacks = parse(loadData("data"))

  let totalPrio = sacks
    .map(mistake)
    .reduce(0, { $0 + priority(of: $1) })

  print(totalPrio)
}

main()
