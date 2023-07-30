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
    func textColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        isFromCurrentSender(message: message) ? .white : .black
    }
}

extension ChatBotViewController: MessagesLayoutDelegate {
    
}

