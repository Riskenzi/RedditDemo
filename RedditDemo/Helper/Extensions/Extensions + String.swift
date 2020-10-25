//
//  Extensions + String.swift
//  RedditDemo
//
//  Created by Valerii Melnykov on 25.10.2020.
//

import Foundation

extension String {
    func timeAgoWillDisplay(_ timestamp : Int?) -> String? {
        let time : TimeInterval = TimeInterval(timestamp ?? 0)
        let convertedDate = Date(timeIntervalSince1970: time)
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.maximumUnitCount = 1
        formatter.allowedUnits = [.year, .month, .day, .hour, .minute, .second]
        
        guard let timeString = formatter.string(from: convertedDate, to: Date()) else {
            return nil
        }
        
        let formatString = NSLocalizedString("%@ ago", comment: "")
        return String(format: formatString, timeString)
    }
}
