import XCTest
@testable import GlossTests

XCTMain([
     testCase(GlossTests.allTests),
	 testCase(EncoderTests.allTests),
	 testCase(DecoderTests.allTests),
	 testCase(FlowObjectCreationTests.allTests),
	 testCase(ObjectToJSONFlowTests.allTests),
	 testCase(KeyPathTests.allTests),
	 testCase(OperatorTests.allTests)
])
