extension Array {
  mutating func shiftRight(p: Int) {
    for _ in 0..<p {
      append(removeFirst())
    }
  }
}
