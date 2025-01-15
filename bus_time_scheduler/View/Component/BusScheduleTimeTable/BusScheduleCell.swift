//
//  BusScheduleCell.swift
//  bus_time_scheduler
//
//  Created by 林 明虎 on 2025/01/15.
//

import UIKit

class BusScheduleCell: UITableViewCell {
    static let identifier = "BusScheduleCell"
    
    override var isSelected: Bool {
        didSet {
            print("isSelected", isSelected)
        }
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with schedule: BusSchedule) {
        titleLabel.text = schedule.arrivalTime
        
        let animates = true
        
        if animates {
            let animator = UIViewPropertyAnimator(duration: 0.3, dampingRatio: 1)
            animator.addAnimations {
                self.contentView.backgroundColor = schedule.isSelected ? UIColor.accent.withAlphaComponent(0.2) : .clear
            }
            animator.startAnimation()
        } else {
            self.contentView.backgroundColor = schedule.isSelected ? UIColor.accent.withAlphaComponent(0.2) : .clear
        }
    }
}
