import XCTest
@testable import LibSGR

final class LibSGRTests: XCTestCase {

  func testRead() {
    readFile(named: "mastaba.sg3")
  }

  func testNotFound() {
    readFile(named: "notfound.sg3")
  }

}
