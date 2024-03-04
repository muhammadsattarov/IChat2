//
//  WaitingChatsNavigation.swift
//  IChat2
//
//  Created by user on 01/03/24.
//

import Foundation

protocol WaitingChatsNavigation: AnyObject {
    func removeWaitingChat(chat: MChat)
    func changeToActive(chat: MChat)
}
