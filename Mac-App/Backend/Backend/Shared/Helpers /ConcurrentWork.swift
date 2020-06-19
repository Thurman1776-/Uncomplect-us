//
//  ConcurrentWork.swift
//  Backend
//
//  Created by Daniel Garcia on 19.06.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import Foundation

func splitAndExecuteConcurrently<I: Hashable, O: Hashable>(
    _ collection: [I],
    transform: @escaping (I) -> O?
) -> [O] {
    let middleIndex: Double = floor(Double(collection.count / 2))
    let firstChunk = collection.prefix(upTo: Int(middleIndex))
    let secondChunk = collection.suffix(from: Int(middleIndex))

    var allItems: Set<O> = []
    var firstChunkItems: Set<O> = []
    var secondChunkItems: Set<O> = []

    let operation = OperationQueue()
    operation.addOperation {
        for item in firstChunk {
            if let _item = transform(item) {
                firstChunkItems.insert(_item)
            }
        }
    }

    operation.addOperation {
        for item in secondChunk {
            if let _item = transform(item) {
                secondChunkItems.insert(_item)
            }
        }
    }

    operation.addBarrierBlock {
        allItems = firstChunkItems.union(secondChunkItems)
    }

    operation.maxConcurrentOperationCount = 3
    operation.qualityOfService = .userInitiated
    operation.waitUntilAllOperationsAreFinished()

    return Array(allItems)
}
