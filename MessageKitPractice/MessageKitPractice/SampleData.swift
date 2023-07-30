//
//  SampleData.swift
//  MessageKitPractice
//
//  Created by 서현웅 on 2023/07/31.
//

import Foundation
import UIKit

// MARK: TestData Injection

extension ChatExamViewController {
    func injectTestData() {
        messages.append(Message(text: "안녕하심까",
                                sender: otherUser,
                                messageId: UUID().uuidString,
                                date: Date().addingTimeInterval(-86400)))
        
        messages.append(Message(text: "두번째 텍서터",
                                sender: otherUser,
                                messageId: UUID().uuidString,
                                date: Date().addingTimeInterval(-85000)))
        
        messages.append(Message(image: UIImage(named: "screenshot1")!,
                                sender: currentUser,
                                messageId: UUID().uuidString,
                                date: Date().addingTimeInterval(-80000)))
        
        messages.append(Message(text: "뭐죠이게",
                                sender: otherUser,
                                messageId: UUID().uuidString,
                                date: Date().addingTimeInterval(-75000)))
        
        messages.append(Message(text: "이것도 대화입니까?",
                                sender: otherUser,
                                messageId: UUID().uuidString,
                                date: Date().addingTimeInterval(-40000)))

        messages.append(Message(text: "네 맞습니다",
                                sender: otherUser,
                                messageId: UUID().uuidString,
                                date: Date().addingTimeInterval(-30000)))
        
        messages.append(Message(image: UIImage(named: "screenshot1")!,
                                sender: currentUser,
                                messageId: UUID().uuidString,
                                date: Date().addingTimeInterval(-20000)))
        
        messages.append(Message(image: UIImage(named: "screenshot1")!,
                                sender: otherUser,
                                messageId: UUID().uuidString,
                                date: Date().addingTimeInterval(-10000)))
    }
}
