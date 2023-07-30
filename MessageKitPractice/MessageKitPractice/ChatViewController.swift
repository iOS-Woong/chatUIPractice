//
//  ChatViewController.swift
//  MessageKitPractice
//
//  Created by 서현웅 on 2023/07/30.
//

import UIKit
import MessageKit
import InputBarAccessoryView

class ChatExamViewController: MessagesViewController {
    
    private (set) var currentUser = Sender(senderId: "self", displayName: "MessageKit Practice App")
    private (set) var otherUser = Sender(senderId: "other", displayName: "PersonA")
    var messages = [MessageType]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        injectTestData()
        setupMessageCollectionViewAttributes()
        setupInputBarAttributes()
    }
    
    private func setupMessageCollectionViewAttributes() {
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        // 초기에 reloadData를 호출하여 MessagesDatasource 메서드를 수동으로 호출해줘야함. 이유는 모르겠다.
        messagesCollectionView.reloadData()
    }
    
    private func setupInputBarAttributes() {
        messageInputBar.delegate = self
        messageInputBar.inputTextView.tintColor = .primaryColor
        messageInputBar.sendButton.setTitleColor(.primaryColor, for: .normal)
        messageInputBar.sendButton.setTitleColor(.primaryColor.withAlphaComponent(0.3), for: .highlighted)
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

extension ChatExamViewController: InputBarAccessoryViewDelegate {
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        processInputBar(inputBar)
    }
    
    private func processInputBar(_ inputBar: InputBarAccessoryView) {
        var components = inputBar.inputTextView.components
        
        inputBar.inputTextView.text = String()
        inputBar.invalidatePlugins() // 이유알아보기
        inputBar.sendButton.startAnimating()
        inputBar.inputTextView.placeholder = "Sending...!"
        
        DispatchQueue.global().async {
            //fake
            sleep(1)
            
            DispatchQueue.main.async { [weak self] in
                inputBar.sendButton.stopAnimating()
                inputBar.inputTextView.placeholder = "Aa"
                
                // MARK: [임시] component가 "@이미지" 일 때, 이미지 넣어주도록함.
                if components.contains(where: { $0 as? String == "@이미지" }) {
                    components = [Any]()
                    components.append(UIImage(named: "screenshot1"))
                }
                
                self?.insertMessages(components)
                self?.messagesCollectionView.scrollToLastItem()
            }
        }
    }
    
    private func insertMessages(_ data: [Any]) {
        for component in data {
            let user = currentSender
            if let str = component as? String {
                let message = Message(text: str, sender: user, messageId: UUID().uuidString, date: Date())
                insertMessage(message)
            } else if let img = component as? UIImage {
                let message = Message(image: img, sender: user, messageId: UUID().uuidString, date: Date())
                insertMessage(message)
              }
        }
    }
    
    private func insertMessage(_ message: Message) {
        messages.append(message)
        messagesCollectionView.reloadData()
    }
    
}


/*
 else if let img = component as? UIImage {
   let message = MockMessage(image: img, user: user, messageId: UUID().uuidString, date: Date())
   insertMessage(message)
 }
 */
