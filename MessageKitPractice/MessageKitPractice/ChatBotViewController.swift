//
//  ChatBotViewController.swift
//  MessageKitPractice
//
//  Created by 서현웅 on 2023/07/31.
//

import UIKit
import MessageKit

class ChatBotViewController: ChatExamViewController {

    override func setupMessageCollectionViewAttributes() {
        super.setupMessageCollectionViewAttributes()
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
    }
}

extension ChatBotViewController: MessagesDisplayDelegate {
    // MARK: - Text Message
    
    func textColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        isFromCurrentSender(message: message) ? .white : .black
    }
    
    // MARK: - All Messages
    
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        isFromCurrentSender(message: message) ? .primaryColor : UIColor(red: 230 / 255, green: 230 / 255, blue: 230 / 255, alpha: 1)
    }
    
    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle { // custom 가능
        let tail: MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .bottomRight : .bottomLeft
        return .bubbleTail(tail, .curved)
    }
}

extension ChatBotViewController: MessagesLayoutDelegate {
    
}

