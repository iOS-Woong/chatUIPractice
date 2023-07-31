//
//  MockSocket.swift
//  MessageKitPractice
//
//  Created by 서현웅 on 2023/07/31.
//

import UIKit

class MockSocket {
    static var shared = MockSocket()
    private init() { }
    
    private var connectedUsers: [Sender] = [
        Sender(senderId: "other", displayName: "모르는사람"),
        Sender(senderId: "otheraa", displayName: "누군가")
    ]
    private var timer: Timer?
    private var queuedMessage: Message?
    private var onNewMessageCode: ((Message) -> Void)?
    private var onTypingStatusCode: (() -> Void)?
    
    
    func connect(with user: Sender) -> Self {
        connectedUsers.append(user)
        timer = Timer.scheduledTimer(
            timeInterval: 0.5,
            target: self,
            selector: #selector(handleTimer),
            userInfo: nil,
            repeats: true)
        return self
    }
    
    @discardableResult
    func onNewMessage(code: @escaping (Message) -> Void) -> Self {
        onNewMessageCode = code
        return self
    }
    
    @objc
    private func handleTimer() {
        if let message = queuedMessage {
            onNewMessageCode?(message)
            queuedMessage = nil
        } else {
            let sender = connectedUsers.randomElement()!
            let message = sampleMessageInjection(sender: sender)
            queuedMessage = message
            onTypingStatusCode?()
        }
    }
    
    private func sampleMessageInjection(sender: Sender) -> Message {
        let sampleMessages: [Message] = [
            Message(text: "안녕하심까",
                    sender: sender,
                    messageId: UUID().uuidString,
                    date: Date()),
            
            Message(text: "두번째 텍서터",
                    sender: sender,
                    messageId: UUID().uuidString,
                    date: Date()),
            
            Message(image: UIImage(named: "screenshot1")!,
                    sender: sender,
                    messageId: UUID().uuidString,
                    date: Date()),
            
            Message(text: "뭐죠이게",
                    sender: sender,
                    messageId: UUID().uuidString,
                    date: Date()),
            
            Message(text: "이것도 대화입니까?",
                    sender: sender,
                    messageId: UUID().uuidString,
                    date: Date()),
            
            Message(text: "네 맞습니다",
                    sender: sender,
                    messageId: UUID().uuidString,
                    date: Date()),
            
            Message(image: UIImage(named: "screenshot1")!,
                    sender: sender,
                    messageId: UUID().uuidString,
                    date: Date()),
            
            Message(image: UIImage(named: "screenshot1")!,
                    sender: sender,
                    messageId: UUID().uuidString,
                    date: Date())
        ]
        
        return sampleMessages.randomElement()!
    }
    
}


