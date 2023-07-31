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
            
            Message(text: "텍스트 형태의 메시지입니다.",
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
            
            Message(text: "장문의 텍스트를 입력하고있습니다. abcdEFGKLAJKLFDJLFDJSLKFJKLSJFKLSFJSLKDFJSDLFSDJFLKSJDFLKSJFLKSDFJSDLKFJSDKLFJSDLFKJSDFLKSDJFLKSDFJLSDKJFLDKSFJSDLKFJSDLFKSJDFLKJSDLFKJDKLFJSDLKFJSDLFKJSDLFKJSDFLKSDJFLKSDJFKLSDFJSDLKFJSDLFKJSDLFKJSDFLKSDJ",
                    sender: sender,
                    messageId: UUID().uuidString,
                    date: Date()),
            
            Message(image: UIImage(named: "Steve-Jobs")!,
                    sender: sender,
                    messageId: UUID().uuidString,
                    date: Date()),
            
            Message(image: UIImage(named: "Steven-Deutsch")!,
                    sender: sender,
                    messageId: UUID().uuidString,
                    date: Date()),
            
            Message(text: "메시지킷은 텍스트, 어트리뷰트텍스트, 이모지, 사진, 비디오, 지도, 오디오, 연락처 양식의 메시지를 제공하는 것 같아요.,",
                    sender: sender,
                    messageId: UUID().uuidString,
                    date: Date())
        ]
        
        return sampleMessages.randomElement()!
    }
}


/*
 text(String)- 속성 없이 일반 텍스트 메시지를 표시하려는 경우 이 경우를 사용하십시오.
 attributedText(NSAttributedString)- 속성이 있는 텍스트 메시지를 표시하려는 경우 이 경우를 사용하십시오.
 attributedText : 문자 메시지에 사용하는 것을 권장합니다 .
 emoji(String)- 이모티콘만 포함된 메시지를 표시하려면 이 케이스를 사용하십시오.
 photo(MediaItem)- 사진 메시지를 표시하려면 이 케이스를 사용하십시오.
 video(MediaItem)- 영상 메시지를 표시할 때 사용하세요.
 location(LocationItem)- 이 케이스를 사용하여 위치 메시지를 표시합니다.
 audio(AudioItem)- 오디오 메시지를 표시하려면 이 케이스를 사용하십시오.
 contact(ContactItem)- 연락처 메시지를 표시하려면 이 케이스를 사용하십시오.
 */
