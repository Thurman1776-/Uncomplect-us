//
//  DependencyNodeSpec.swift
//  BackendTests
//
//  Created by Daniel Garcia on 01.02.21.
//  Copyright © 2021 Acphut Werkstatt. All rights reserved.
//

@testable import Backend
import Nimble
import Quick

final class DependencyNodeSpec: QuickSpec {
    override func spec() {
        describe("DependencyNode") {
            context("when DependencyNode is initialised") {
                let name = "backend"
                var sut: DependencyNode!

                beforeEach {
                    sut = DependencyNode(name: name)
                }

                it("has the correct name set") {
                    expect(sut.name).to(equal(name))
                }

                it("does not contain any children") {
                    expect(sut.dependencies).to(beEmpty())
                }

                it("does not have a parent set") {
                    expect(sut.parent).to(beNil())
                }
            }

            context("when DependencyNode adds a child") {
                let name = "backend"
                let depName = "redux"
                let sut = DependencyNode(name: name)

                beforeEach {
                    sut.add(DependencyNode(name: depName))
                }

                it("has the correct name set") {
                    expect(sut.name).to(equal(name))
                }

                it("contains correct children") {
                    expect(sut.dependencies.first!.name) == depName
                }

                it("its child have a correct parent set") {
                    let dependency = sut.dependencies.first!

                    expect(dependency.parent).to(equal(sut))
                }
            }

            context("when DependencyNode adds several children") {
                let sut = DependencyNode(name: "beverages")

                let hotBeverage = DependencyNode(name: "hot")

                let tea = DependencyNode(name: "tea")
                let coffee = DependencyNode(name: "coffee")
                let cocoa = DependencyNode(name: "cocoa")

                let blackTea = DependencyNode(name: "black")
                let greenTea = DependencyNode(name: "green")
                let chaiTea = DependencyNode(name: "chai")

                beforeEach {
                    sut.add(hotBeverage)

                    hotBeverage.add(tea)
                    hotBeverage.add(coffee)
                    hotBeverage.add(cocoa)

                    tea.add(blackTea)
                    tea.add(greenTea)
                    tea.add(chaiTea)
                }

                it("sets correct number of children to nodes") {
                    expect(sut.dependencies.count) == 1
                    expect(hotBeverage.dependencies.count) == 3
                    expect(tea.dependencies.count) == 3
                }

                it("sets correct parent to nodes") {
                    expect(sut.parent).to(beNil())
                    expect(hotBeverage.parent) == sut
                    expect(tea.parent) == hotBeverage
                    expect(greenTea.parent) == tea
                }
            }

            context("when Dependency Node adds multiple dependencies") {
                let name = "Deutschland"
                let depName_1 = "Düsseldorf"
                let depName_2 = "München"
                let depName_3 = "Hamburg"
                let expectedNumberOfDeps = 3
                let sut = DependencyNode(name: name)

                beforeEach {
                    sut.add([
                        DependencyNode(name: depName_1),
                        DependencyNode(name: depName_2),
                        DependencyNode(name: depName_3),
                    ])
                }

                it("has the correct name set") {
                    expect(sut.name).to(equal(name))
                }

                it("contains correct number of children") {
                    expect(sut.dependencies.count).to(equal(expectedNumberOfDeps))
                }

                it("its child have a correct parent set") {
                    sut.dependencies.forEach { node in
                        expect(node.parent).to(equal(sut))
                    }
                }
            }
        }
    }
}
