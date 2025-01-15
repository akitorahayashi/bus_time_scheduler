//
//  BusScheduleTimeTable.swift
//  bus_time_scheduler
//
//  Created by 林 明虎 on 2025/01/15.
//

import UIKit

class BusScheduleTimeTable: UIView, UITableViewDataSource, UITableViewDelegate {
    // MARK: - Properties
    private var busSchedules: [BusSchedule]
    var selectedIndex: Int?
    
    // MARK: - Component
    private let tableView = UITableView()

    // MARK: - Initializer
    init(busSchedules: [BusSchedule]) {
        self.busSchedules = busSchedules
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        addSubview(tableView)
        
        // Setup TableView
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(BusScheduleCell.self, forCellReuseIdentifier: BusScheduleCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 80
        
        // Layout Constraints
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    // MARK: - Helper Methods
    func scrollToNearestTime() {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let currentTimeString = dateFormatter.string(from: currentDate)
        
        if let nearestIndex = busSchedules.firstIndex(where: { $0.arrivalTime >= currentTimeString }) {
            DispatchQueue.main.async {
                self.tableView.scrollToRow(at: IndexPath(row: nearestIndex, section: 0), at: .top, animated: true)
            }
        }
    }
    
    // MARK: - TableView DataSource & Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return busSchedules.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BusScheduleCell.identifier, for: indexPath) as? BusScheduleCell else {
            return UITableViewCell()
        }
        let schedule = busSchedules[indexPath.row]
        cell.configure(with: schedule)  // configureに渡してbackgroundColorを設定
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 同じセルが選択された場合は選択を解除
        if selectedIndex == indexPath.row {
            // 現在選択されたセルを解除
            busSchedules[indexPath.row].isSelected = false
            selectedIndex = nil
        } else {
            // 以前選択されていたセルを解除（もしあれば）
            if let previousIndex = selectedIndex {
                busSchedules[previousIndex].isSelected = false
            }
            
            // 新しく選択されたセルを選択
            busSchedules[indexPath.row].isSelected = true
            selectedIndex = indexPath.row
        }
        
        // テーブルビューを更新して背景色を反映させる
        tableView.reloadData()
    }
}
