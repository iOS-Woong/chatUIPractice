//
//  ChatViewController.swift
//  MessageKitPractice
//
//  Created by 서현웅 on 2023/07/30.
//

// 기준
// 부모가 가진 작업을 모두 사용하는 경우에는 상속 , 부모의 기능 +@로 기능을 사용할 때 상속을 사용한다.
// 상속 할 때, 주의해야 할 점 (부모와 자식이 동일하게 동작하지 않을 경우를 유의하라)

import UIKit
import MessageKit
import InputBarAccessoryView

class ChatExamViewController: MessagesViewController {
    private var currentUser = Sender(senderId: "self", displayName: "본인")
    
    var messages = [MessageType]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMessageCollectionViewAttributes()
        setupInputBarAttributes()
        connectMockSocket() // 테스트메서드
        messagesCollectionView.register(CustomTagMessageContentCell.self)
    }
    
    func connectMockSocket() {
        MockSocket.shared.connect(with: currentUser)
            .onNewMessage { [weak self] message in
                self?.insertMessage(message)
                self?.messagesCollectionView.scrollToLastItem()
            }
    }
    
    func setupMessageCollectionViewAttributes() {
        messagesCollectionView.messagesDataSource = self
        // 초기에 reloadData를 호출하여 MessagesDatasource 메서드를 수동으로 호출해줘야함. 이유는 모르겠다.
        messagesCollectionView.reloadData()
    }
    
    private func setupInputBarAttributes() {
        messageInputBar.delegate = self
        messageInputBar.inputTextView.tintColor = .primaryColor
        messageInputBar.sendButton.setTitleColor(.primaryColor, for: .normal)
        messageInputBar.sendButton.setTitleColor(.primaryColor.withAlphaComponent(0.3), for: .highlighted)
    }
    
    
    func textCell(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UICollectionViewCell? {
        
        
        let cell = messagesCollectionView.dequeueReusableCell(CustomTagMessageContentCell.self, for: indexPath)
        cell.configure(with: message, at: indexPath, in: messagesCollectionView, dataSource: self, and: textMessageSizeCalculator)
        return cell
    }
    
    private lazy var textMessageSizeCalculator = CustomTextLayoutSizeCalculator(layout: self.messagesCollectionView.messagesCollectionViewFlowLayout)
    
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
    
    func cellTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        if indexPath.section % 3 == 0 {
            return NSAttributedString(
                string: MessageKitDateFormatter.shared.string(from: message.sentDate),
                attributes: [
                    NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 10),
                    NSAttributedString.Key.foregroundColor: UIColor.darkGray,
                ])
        }
        return nil
    }
    
    func messageTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        let name = message.sender.displayName
        return NSAttributedString(
            string: name,
            attributes: [
                .font: UIFont.preferredFont(forTextStyle: .caption1),
                .foregroundColor: UIColor(white: 0.3, alpha: 1)
            ]
        )
    }
    
    func messageBottomLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        let dateString = MessageKitDateFormatter.shared.formatToKoreanTime(from: message.sentDate)
        return NSAttributedString(
            string: dateString,
            attributes: [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .caption2)])
    }
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
                    components.append(UIImage(named: "Tim-Cook"))
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
