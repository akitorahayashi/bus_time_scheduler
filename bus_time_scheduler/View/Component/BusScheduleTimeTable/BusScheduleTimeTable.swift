//
//  BusScheduleTimeTable.swift
//  bus_time_scheduler
//
//  Created by 林 明虎 on 2025/01/15.
//

import UIKit

class BusScheduleTimeTable: UIView, UITableViewDataSource, UITableViewDelegate {
    private let presenter: BusSchedulePresenter
    private let tableView = UITableView()
    
    init(presenter: BusSchedulePresenter) {
        self.presenter = presenter
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 80
        tableView.register(BusScheduleCell.self, forCellReuseIdentifier: BusScheduleCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func scrollToNearestTime() {
        let currentTimeString = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .short)
        if let nearestIndex = presenter.nearestScheduleIndex(currentTime: currentTimeString) {
            DispatchQueue.main.async {
                self.tableView.scrollToRow(at: IndexPath(row: nearestIndex, section: 0), at: .top, animated: true)
            }
        }
    }
    
    // MARK: - UITableViewDataSource & UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfSchedules
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BusScheduleCell.identifier, for: indexPath) as! BusScheduleCell
        if let schedule = presenter.busSchedule(at: indexPath.row) {
            cell.configure(with: schedule)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.toggleSelection(at: indexPath.row)
        tableView.reloadData()
    }
}
