//
//  ProjectOutputSpec.swift
//  Backend
//
//  Created by Daniel GARCÍA on 23.02.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

@testable import Backend
import Nimble
import Quick

final class ProjectOutputSpec: QuickSpec {
    override func spec() {
        describe("ProjectOutputSpec") {
            context("Given derived data paths for the project exists") {
                context("when test files are skipped") {
                    it("returns located folders containing dependency files as valid URLs") {
                        let output = findProjectOutputDirectories(projectName: "Backend")

                        expect(output).notTo(beEmpty())

                        let firstItem = output.first!
                        expect(firstItem.isFileURL).to(beTrue())
                    }
                }

                context("when test files are included") {
                    it("returns located folders containing dependency files (including tests) as valid URLs") {
                        let output = findProjectOutputDirectories(projectName: "Backend", excludingTests: false)

                        expect(output).notTo(beEmpty())

                        let firstItem = output.first!
                        expect(firstItem.isFileURL).to(beTrue())

                        let testsPaths = output.filter { $0.absoluteString.lowercased().contains("test") == true }
                        expect(testsPaths).notTo(beEmpty())
                    }
                }
            }
        }
    }
}
