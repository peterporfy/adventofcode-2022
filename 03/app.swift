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

extension Array {
  func chunked(size: Int) -> [[Element]] {
    stride(from: 0, to: count, by: size).map {
      Array(self[$0..<Swift.min($0 + size, count)])
    }
  }
}

func mistake(of sack: String) -> Character? {
  let chars = Array(sack)
  let middle = chars.count / 2
  let compartmentA = Set(chars[0..<middle])
  let compartmentB = chars[middle...chars.count - 1]

  return compartmentB.first { compartmentA.contains($0) }
}

func priority(of itemMaybe: Character?) -> Int {
  guard let item = itemMaybe, let ascii = item.asciiValue else { return 0 }

  if item.isUppercase {
    return Int(ascii - 38)
  } else {
    return Int(ascii - 96)
  }
}

func badge(of group: [String]) -> Character? {
  guard let ref = group.first else { return nil }
  let rest = group.dropFirst()

  return ref.first { item in
    rest.allSatisfy { $0.contains(item) }
  }
}

func main() {
  let sacks = parse(loadData("data"))

  let totalPrio = sacks
    .map(mistake)
    .reduce(0, { $0 + priority(of: $1) })

  let badgePriorities = sacks
    .chunked(size: 3)
    .map(badge)
    .reduce(0, { $0 + priority(of: $1) })

  print("1: \(totalPrio)")
  print("2: \(badgePriorities)")
}

main()
