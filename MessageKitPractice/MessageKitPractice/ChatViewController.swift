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
        let components = inputBar.inputTextView.components
        
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
                self?.insertMessages(components)
                self?.messagesCollectionView.scrollToLastItem()
            }
        }
    }
    
    private func insertMessages(_ data: [Any]) {
      for component in data {
        let user = currentSender
        if let str = component as? String {
            let message = Message(sender: user, messageId: UUID().uuidString, sentDate: Date(), kind: .text(str))
            insertMessage(message)
        } // else if로 component가 image일 때는 message에 이미지를 담을 수 있도록 구현하여야함.
      }
    }
    
    private func insertMessage(_ message: Message) {
        messages.append(message)
        messagesCollectionView.reloadData()
    }
    
}
