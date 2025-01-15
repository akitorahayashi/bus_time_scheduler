//
//  BusScheduleCell.swift
//  bus_time_scheduler
//
//  Created by 林 明虎 on 2025/01/15.
//

import UIKit

class BusScheduleCell: UITableViewCell {
    // MARK: - Properties
    static let identifier = "BusScheduleCell"
    private let titleLabel = UILabel()
    
    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        // Configure titleLabel
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        
        // Layout Constraints
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    // MARK: - Configure Cell
    func configure(with schedule: BusSchedule) {
        titleLabel.text = schedule.arrivalTime
        
        self.contentView.backgroundColor = schedule.isSelected ? UIColor.systemBlue.withAlphaComponent(0.2) : .clear
    }
}
