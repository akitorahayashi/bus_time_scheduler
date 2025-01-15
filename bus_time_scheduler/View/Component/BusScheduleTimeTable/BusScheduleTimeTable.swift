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
        tableView.transform = CGAffineTransform(scaleX: 1, y: -1)
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
        let currentDate = kDebugMode
        // 今日の16時。年月日はその日に合わせる。
        ? Calendar.current.date(bySettingHour: 16, minute: 0, second: 0, of: Date())!
        // 現在時刻
        : Date()
        let currentTimeString = DateFormatter.localizedString(from: currentDate, dateStyle: .none, timeStyle: .short)
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
            // これがあることでチカチカ光る現象を防げる。別でハイライトの処理はある。
            cell.selectionStyle = .none
            // tableViewを反転させた影響で、Cellも反転させることでUIを整える
            cell.transform = CGAffineTransform(scaleX: 1, y: -1)
        } else {
            assertionFailure()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                     
        let currentSelectedIndex = presenter.currentSelectedIndex
        presenter.toggleSelection(at: indexPath.row)
        if let currentSelectedIndex {
            tableView.reloadRows(at: [.init(row: currentSelectedIndex, section: 0)], with: .automatic)
        }
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
