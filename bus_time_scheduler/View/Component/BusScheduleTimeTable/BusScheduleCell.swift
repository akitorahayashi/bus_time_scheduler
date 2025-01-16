//
//  BusScheduleCell.swift
//  bus_time_scheduler
//
//  Created by 林 明虎 on 2025/01/15.
//

import UIKit

class BusScheduleCell: UITableViewCell {
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
        nextLabel.textColor = .red
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
    
    func configure(with schedule: BusSchedule, isNextBus: Bool) {
        
        titleLabel.text = schedule.arrivalTime
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        
        guard let arrivalTime = timeFormatter.date(from: schedule.arrivalTime) else {
            return
        }
        
        let currentDate = Date()
        let calendar = Calendar.current
        
        guard let arrivalDate = calendar.date(bySettingHour: calendar.component(.hour, from: arrivalTime),
                                              minute: calendar.component(.minute, from: arrivalTime),
                                              second: 0,
                                              of: currentDate) else {
            return
        }
        
        let displayDate: String
        
        if arrivalDate < currentDate {
            guard let nextDay = calendar.date(byAdding: .day, value: 1, to: currentDate) else {
                return
            }
            timeFormatter.dateFormat = "yyyy/MM/dd"
            displayDate = timeFormatter.string(from: nextDay)
        } else {
            timeFormatter.dateFormat = "yyyy/MM/dd"
            displayDate = timeFormatter.string(from: currentDate)
        }
        
        dateLabel.text = displayDate
        
        // 次のバスのスケジュールならNEXTのラベルを表示する
        if isNextBus {
            nextLabel.isHidden = false
        } else {
            nextLabel.isHidden = true
        }
        
        let animator = UIViewPropertyAnimator(duration: 0.3, dampingRatio: 1)
        animator.addAnimations {
            self.contentView.backgroundColor = schedule.isSelected ? UIColor.accent.withAlphaComponent(0.2) : .clear
        }
        animator.startAnimation()
    }
}
