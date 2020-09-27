//
//  macOSMenu.swift
//  Mac-App
//
//  Created by Daniel Garcia on 27.09.20.
//  Copyright © 2020 Acphut Werkstatt. All rights reserved.
//

import Cocoa
import Frontend

struct macOSMenu {
    func triggerNewSearch(_: NSMenuItem) {
        DefaultDispatcher.dispatch(FileMenuAction.newProjectSearch)
    }
}
