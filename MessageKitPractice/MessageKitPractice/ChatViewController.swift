//
//  ChatViewController.swift
//  MessageKitPractice
//
//  Created by 서현웅 on 2023/07/30.
//

import UIKit
import MessageKit

class ChatExamViewController: MessagesViewController {

    private let currentUser = Sender(senderId: "self", displayName: "MessageKit Practice App")
    private let otherUser = Sender(senderId: "other", displayName: "PersonA")
    private var messages = [MessageType]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        injectTestData()
        setupMessageCollectionViewAttributes()
    }
    
    private func setupMessageCollectionViewAttributes() {
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        // 초기에 reloadData를 호출하여 MessagesDatasource 메서드를 수동으로 호출해줘야함. 이유는 모르겠다.
        messagesCollectionView.reloadData()
    }
}

extension ChatExamViewController: MessagesDataSource {
    var currentSender: MessageKit.SenderType {
        return currentUser
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessageKit.MessagesCollectionView) -> MessageKit.MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessageKit.MessagesCollectionView) -> Int {
        return messages.count
    }
}

extension ChatExamViewController: MessagesLayoutDelegate {
    
}

extension ChatExamViewController: MessagesDisplayDelegate {
    
}


// MARK: TestData Injection

extension ChatExamViewController {
    func injectTestData() {
        messages.append(
            Message(sender: currentUser,
                    messageId: "1",
                    sentDate: Date().addingTimeInterval(-86400),
                    kind: .text("Hello World")))
        
        messages.append(
            Message(sender: otherUser,
                    messageId: "2",
                    sentDate: Date().addingTimeInterval(-80000),
                    kind: .text("안녕하심니까")))
        
        messages.append(
            Message(sender: currentUser,
                    messageId: "3",
                    sentDate: Date().addingTimeInterval(-75000),
                    kind: .text("잘지내심니까")))
        
        messages.append(
            Message(sender: currentUser,
                    messageId: "4",
                    sentDate: Date().addingTimeInterval(-72000),
                    kind: .text("네 저도잘지냄니다")))
        
        messages.append(
            Message(sender: otherUser,
                    messageId: "5",
                    sentDate: Date().addingTimeInterval(-70000),
                    kind: .text("네 알겠슴다")))
        
        messages.append(
            Message(sender: currentUser,
                    messageId: "6",
                    sentDate: Date().addingTimeInterval(-65000),
                    kind: .text("저는 여섯번째 보낸 메시지에요")))
        
        messages.append(
            Message(sender: otherUser,
                    messageId: "7",
                    sentDate: Date().addingTimeInterval(-50000),
                    kind: .text("예")))
        
        messages.append(
            Message(sender: otherUser,
                    messageId: "8",
                    sentDate: Date().addingTimeInterval(-50000),
                    kind: .text("예")))
    }
}
