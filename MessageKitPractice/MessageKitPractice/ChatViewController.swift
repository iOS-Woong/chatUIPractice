//
//  ChatViewController.swift
//  MessageKitPractice
//
//  Created by 서현웅 on 2023/07/30.
//

import UIKit
import MessageKit

class ChatViewController: MessagesViewController {

    private let currentUser = Sender(senderId: "self", displayName: "MessageKit Practice App")
    private let otherUser = Sender(senderId: "other", displayName: "PersonA")
    private var messages = [MessageType]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMessageCollectionViewAttributes()
        injectTestData()
    }
    
    private func setupMessageCollectionViewAttributes() {
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
    }
    
}

extension ChatViewController: MessagesDataSource {
    var currentSender: MessageKit.SenderType {
        return currentUser
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessageKit.MessagesCollectionView) -> MessageKit.MessageType {
        <#code#>
    }
    
    func numberOfSections(in messagesCollectionView: MessageKit.MessagesCollectionView) -> Int {
        <#code#>
    }
    
    
}

extension ChatViewController: MessagesLayoutDelegate {
    
}

extension ChatViewController: MessagesDisplayDelegate {
    
}


// MARK: TestData Injection

extension ChatViewController {
    func injectTestData() {
        messages.append(
            Message(sender: currentUser,
                    messageId: "1",
                    sentDate: Date().addingTimeInterval(-86400),
                    kind: .text("Hello World")))
        
        messages.append(
            Message(sender: currentUser,
                    messageId: "1",
                    sentDate: Date().addingTimeInterval(-86400),
                    kind: .text("Hello World")))
        
        messages.append(
            Message(sender: currentUser,
                    messageId: "1",
                    sentDate: Date().addingTimeInterval(-86400),
                    kind: .text("Hello World")))
        
        messages.append(
            Message(sender: currentUser,
                    messageId: "1",
                    sentDate: Date().addingTimeInterval(-86400),
                    kind: .text("Hello World")))
        
        messages.append(
            Message(sender: currentUser,
                    messageId: "1",
                    sentDate: Date().addingTimeInterval(-86400),
                    kind: .text("Hello World")))
        
        messages.append(
            Message(sender: currentUser,
                    messageId: "1",
                    sentDate: Date().addingTimeInterval(-86400),
                    kind: .text("Hello World")))
        
        messages.append(
            Message(sender: currentUser,
                    messageId: "1",
                    sentDate: Date().addingTimeInterval(-86400),
                    kind: .text("Hello World")))
    }
}
