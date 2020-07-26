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

    let operationQueue = OperationQueue()
    operationQueue.addOperation {
        for item in firstChunk {
            if let _item = transform(item) {
                firstChunkItems.insert(_item)
            }
        }
    }

    operationQueue.addOperation {
        for item in secondChunk {
            if let _item = transform(item) {
                secondChunkItems.insert(_item)
            }
        }
    }

    operationQueue.addBarrierBlock {
        allItems = firstChunkItems.union(secondChunkItems)
    }

    operationQueue.maxConcurrentOperationCount = 3
    operationQueue.qualityOfService = .userInitiated
    operationQueue.waitUntilAllOperationsAreFinished()

    return Array(allItems)
}
