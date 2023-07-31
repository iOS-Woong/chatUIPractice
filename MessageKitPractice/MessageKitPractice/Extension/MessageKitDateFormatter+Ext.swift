//
//  MessageKitDateFormatter+Ext.swift
//  MessageKitPractice
//
//  Created by 서현웅 on 2023/07/31.
//

import Foundation
import MessageKit

extension MessageKitDateFormatter {
    func formatToKoreanTime(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "a h:mm"
        dateFormatter.locale = Locale(identifier: "KO_kr")
        
        return dateFormatter.string(from: date)
    }
}
