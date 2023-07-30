//
//  Message.swift
//  MessageKitPractice
//
//  Created by 서현웅 on 2023/07/30.
//

import MessageKit
import UIKit

struct Sender: SenderType {
    var senderId: String
    var displayName: String
}

struct Message: MessageType {
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
    
    private init(sender: SenderType, messageId: String, date: Date, kind: MessageKind) {
        self.sender = sender
        self.kind = kind
        self.messageId = messageId
        self.sentDate = date
    }
    
    init(text: String, sender: SenderType, messageId: String, date: Date) {
        self.init(sender: sender, messageId: messageId, date: date, kind: .text(text))
    }
    
    init(image: UIImage, sender: SenderType, messageId: String, date: Date) {
        let mediaItem = ImageMediaItem(image: image)
        self.init(sender: sender, messageId: messageId, date: date, kind: .photo(mediaItem))
    }
}

private struct ImageMediaItem: MediaItem {
    var url: URL?
    var image: UIImage?
    var placeholderImage: UIImage
    var size: CGSize
    
    init(image: UIImage) {
        self.image = image
        size = CGSize(width: 240, height: 240)
        placeholderImage = UIImage()
    }
}
