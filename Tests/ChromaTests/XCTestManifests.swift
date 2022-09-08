import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(ChromaErrorTests.allTests),
        testCase(FileTests.allTests),
        testCase(PlatformTests.allTests),
        testCase(StringFormatterTests.allTests)
    ]
}
#endif
