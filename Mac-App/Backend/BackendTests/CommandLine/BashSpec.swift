//
//  BashSpec.swift
//  Backend
//
//  Created by Daniel GARCÍA on 23.02.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

@testable import Backend
import Nimble
import Quick

final class BashSpec: QuickSpec {
    override func spec() {
        describe("BashSpec") {
            it("Returns nil for non existing command") {
                let sut = Bash()
                let result = sut.execute(command: "funky", arguments: [])
                expect(result).to(beNil())
            }

            context("given the command exist but not the option") {
                it("Returns nil") {
                    let sut = Bash()
                    let result = sut.execute(command: "ls", arguments: ["-"])
                    expect(result).to(beNil())
                }
            }

            context("given the command and the option exist") {
                it("lists files in current directory") {
                    let sut = Bash()
                    let result = sut.execute(command: "ls", arguments: ["-lh"])
                    expect(result).notTo(beNil())
                    expect(result).notTo(beEmpty())
                }

                it("prints current working directory") {
                    let sut = Bash()
                    let result = sut.execute(command: "pwd", arguments: ["-L"])
                    expect(result).notTo(beNil())
                    expect(result).notTo(beEmpty())
                }

                it("finds itself in derived data") {
                    let sut = Bash()
                    let result = sut.execute(
                        command: "find",
                        arguments: ["$HOME/Library/Developer/Xcode/DerivedData", "-name", "*Mac-App*"]
                    )
                    expect(result).notTo(beNil())
                    expect(result).notTo(beEmpty())
                }
            }

            context("given a full valid path to object files exists for itself") {
                // Command in shell

                // find ~/Library/Developer/Xcode/DerivedData -depth 1 -name "*Mac-App*"
                // -type d -exec find {} -name "i386" -o -name "armv*" -o -name "x86_64" -type d \;
                it("correctly finds all occurances") {
                    let sut = Bash()
                    let result = sut.execute(
                        command: "find", arguments: ["$HOME/Library/Developer/Xcode/DerivedData",
                                                     "-name", "*Mac-App*",
                                                     "-type", "d",
                                                     "-exec", "find", "{}",
                                                     "-name", "i386",
                                                     "-o", "-name", "armv*",
                                                     "-o", "-name", "x86_64",
                                                     "-type", "d", ";"]
                    )

                    expect(result).notTo(beNil())
                    expect(result).notTo(beEmpty())
                }
            }
        }
    }
}
