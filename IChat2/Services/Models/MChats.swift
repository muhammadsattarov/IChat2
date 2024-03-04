//
//  Mchats.swift
//  IChat2
//
//  Created by user on 27/02/24.
//

import UIKit
import FirebaseFirestore

struct MChat: Hashable, Decodable {
    var friendUserName: String
    var friendUserImageString: String
    var lastMessage: String
    var friendId: String
    
    var representation: [String: Any] {
        var rep = ["friendUserName" : friendUserName]
        rep["friendUserImageString"] = friendUserImageString
        rep["lastMessage"] = lastMessage
        rep["friendId"] = friendId
        return rep
    }
    
    init(friendUserName: String, friendUserImageString: String, lastMessage: String, friendId: String) {
        self.friendUserName = friendUserName
        self.friendUserImageString = friendUserImageString
        self.lastMessage = lastMessage
        self.friendId = friendId
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        guard let friendUserName = data["friendUserName"] as? String,
              let friendUserImageString = data["friendUserImageString"] as? String,
              let lastMessage = data["lastMessage"] as? String,
              let friendId = data["friendId"] as? String else {
            return nil
        }
        self.friendUserName = friendUserName
        self.friendUserImageString = friendUserImageString
        self.lastMessage = lastMessage
        self.friendId = friendId
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(friendId)
    }
    
    static func == (lhs: MChat, rhs: MChat) -> Bool {
        return lhs.friendId == rhs.friendId
    }
}

