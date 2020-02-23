//
//  YamlParserSpec.swift
//  Backend
//
//  Created by Daniel GARCÍA on 23.02.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

@testable import Backend
import Nimble
import Quick

final class YamlParserSpec: QuickSpec {
    override func spec() {
        describe("YamlParserSpec") {
            context("given it takes a valid input") {
                it("returns correctly parsed Yaml objects") {
                    let output = findProjectOutputDirectories(projectName: "Mac-App")
                    let result = parseYamlUrls(from: output)

                    expect(result).notTo(beEmpty())
                }
            }

            context("given it takes an invalid input") {
                it("returns an empty array") {
                    let result = parseYamlUrls(from: [])

                    expect(result).to(beEmpty())
                }
            }
        }
    }
}
