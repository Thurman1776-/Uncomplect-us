//
//  CLParserSpec.swift
//  Backend
//
//  Created by Daniel GARCÍA on 23.02.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

@testable import Backend
import Nimble
import Quick

final class CLParserSpec: QuickSpec {
    override func spec() {
        describe("CLParserSpec") {
            context("given it takes a valid input") {
                it("returns a fully mapped array version exluding tests paths") {
                    let result = parseCommandLineOutputSkippingTestFiles(execDefaultFindCommand())

                    expect(result).notTo(beEmpty())
                    let testsPaths = result.filter { $0.lowercased().contains("test") == true }
                    expect(testsPaths).to(beEmpty())
                }
            }

            context("given it takes an invalid input") {
                it("returns an empty array") {
                    let result = parseCommandLineOutputSkippingTestFiles("")

                    expect(result).to(beEmpty())
                }
            }
        }
    }
}
