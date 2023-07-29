//
//  Message.swift
//  MessageKitPractice
//
//  Created by 서현웅 on 2023/07/30.
//

import Foundation
import MessageKit

struct Sender: SenderType {
    var senderId: String
    var displayName: String
}

class Message: MessageType {
    var sender: MessageKit.SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKit.MessageKind
}
