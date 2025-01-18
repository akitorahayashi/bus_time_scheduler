//
//  BusScheduleCell.swift
//  bus_time_scheduler
//
//  Created by 林 明虎 on 2025/01/15.
//

import UIKit

final class BusScheduleCell: UITableViewCell {
    static let identifier = "BusScheduleCell"
    
    private let dateLabel = UILabel()
    private let titleLabel = UILabel()
    private let nextLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        dateLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        dateLabel.textAlignment = .center
        dateLabel.textColor = .gray.withAlphaComponent(0.9)
        
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .gray.withAlphaComponent(0.9)
        
        nextLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        nextLabel.textAlignment = .center
        nextLabel.textColor = .red.withAlphaComponent(0.8)
        nextLabel.text = "NEXT"
        nextLabel.isHidden = true
        
        let labelStackView = UIStackView(arrangedSubviews: [dateLabel, titleLabel, nextLabel])
        labelStackView.axis = .vertical
        labelStackView.spacing = 4
        labelStackView.alignment = .center
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(labelStackView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: 80),
            contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            
            labelStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            labelStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            labelStackView.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -40),
            labelStackView.heightAnchor.constraint(lessThanOrEqualTo: contentView.heightAnchor, constant: -20)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with busSchedule: BusSchedule, isNextBus: Bool) {
        let arrivalTime = busSchedule.arrivalTime
        titleLabel.text = arrivalTime.formatted()
        
        // 到着年月日を取得
        let displayDate = calculateDisplayDate(for: arrivalTime, currentDate: BSDateUtilities.currentDate())
        dateLabel.text = displayDate
        
        // 次のバスのスケジュールならNEXTのラベルを表示する
        nextLabel.isHidden = !isNextBus
        
        let animator = UIViewPropertyAnimator(duration: 0.3, dampingRatio: 1)
        animator.addAnimations {
            self.contentView.backgroundColor = busSchedule.isSelected ? UIColor.accent.withAlphaComponent(0.2) : .clear
        }
        animator.startAnimation()
    }

    private func calculateDisplayDate(for arrivalTime: BSFixedTime, currentDate: Date) -> String {
        let calendar = Calendar.current
        let currentTime = BSFixedTime(from: currentDate)
        
        // 到着時間が現在の時刻より前の場合、翌日を返す
        if arrivalTime < currentTime {
            guard let nextDay = calendar.date(byAdding: .day, value: 1, to: currentDate) else {
                return ""
            }
            return BSDateFormatter.shared.formattedDate(from: nextDay, format: .fullDate)
        }
        
        // 現在の日付を返す
        return BSDateFormatter.shared.formattedDate(from: currentDate, format: .fullDate)
    }
}
