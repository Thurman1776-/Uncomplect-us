//
//  SwiftDepsParserSpec.swift
//  Backend
//
//  Created by Daniel GARCÍA on 23.02.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

@testable import Backend
import Nimble
import Quick

final class SwiftDepsParserSpec: QuickSpec {
    override func spec() {
        describe("parseSwiftDeps") {
            context("given it takes a valid input") {
                var result: [DependencyNode] = []

                beforeEach {
                    // Do not perform same search for each test case as the results are the same
                    // And it is expensive & long
                    if result.isEmpty {
                        result = parseSwiftDeps(
                            parseYamlUrls(
                                from: findProjectOutputDirectories(projectName: "Backend")
                            )
                        )
                    }
                }

                it("returns correctly parsed DependencyNode objects") {
                    expect(result).toNotEventually(beEmpty(), timeout: timeout)
                }

                it("does not store the owner name in the dependencies list") {
                    let randomItem = result.randomElement()!
                    let randomItemDeps = randomItem.dependencies.map { $0.name }
                    expect(randomItemDeps.contains(randomItem.owner)).toEventually(beFalse(), timeout: timeout)
                }

                it("does not include any system/framework symbols") {
                    let randomItem = result.randomElement()!
                    let randomItemDeps = randomItem.dependencies.map { $0.name }

                    expect(randomItemDeps.contains(systemSymbols.randomElement()!)).toEventually(beFalse(), timeout: timeout)
                    expect(randomItemDeps.randomElement()!.contains("UI")).toEventually(beFalse(), timeout: timeout)
                    expect(randomItemDeps.randomElement()!.contains("NS")).toEventually(beFalse(), timeout: timeout)
                    expect(randomItemDeps.randomElement()!.contains("CF")).toEventually(beFalse(), timeout: timeout)
                }
            }

            context("given it takes an invalid input") {
                it("returns an empty array") {
                    let result = parseSwiftDeps([])

                    expect(result).to(beEmpty())
                }
            }
        }
    }
}
