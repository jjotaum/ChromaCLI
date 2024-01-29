import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(ChromaErrorTests.allTests),
        testCase(FileTests.allTests),
        testCase(FrameworkTests.allTests),
        testCase(StringFormatterTests.allTests)
    ]
}
#endif
