//
//  MMessage.swift
//  IChat2
//
//  Created by user on 29/02/24.
//

import UIKit
import FirebaseFirestore

struct MMessage {
    var content: String
    var senderId: String
    var senderUserName: String
    var sentDate: Date
    var id: String?
    
    init(user: MUser, content: String) {
        self.content = content
        senderId = user.id
        senderUserName = user.username
        sentDate = Date()
        id = nil
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        guard let sentDate = data["created"] as? Timestamp else { return nil }
        guard let senderId = data["senderID"] as? String else { return nil }
        guard let senderName = data["senderName"] as? String else { return nil }
        guard let content = data["content"] as? String else { return nil }

        self.id = document.documentID
        self.sentDate = sentDate.dateValue()
        self.senderId = senderId
        self.senderUserName = senderName
        self.content = content
    }
    
    var representation: [String: Any] {
        var rep: [String: Any] = [
            "created": sentDate,
            "senderId": senderId,
            "senderUserName": senderUserName,
            "content": content
        ]
        return rep
    }
}

