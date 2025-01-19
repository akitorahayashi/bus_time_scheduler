//
//  BusScheduleTimeTable.swift
//  bus_time_scheduler
//
//  Created by 林 明虎 on 2025/01/15.
//

import UIKit
import WidgetKit

final class BusScheduleTimeTable: UIView, UITableViewDataSource, UITableViewDelegate {
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
        if let nearestIndex = presenter.nearestScheduleIndex(currentTime: BSDateUtilities.currentDate()) {
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
            // Check if this is the next bus
            let isNextBus: Bool = presenter.nearestScheduleIndex(currentTime: BSDateUtilities.currentDate()) == indexPath.row
            print(schedule.isSelected)
            cell.configure(with: schedule, isNextBus: isNextBus)
            cell.selectionStyle = .none
        } else {
            assertionFailure()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 選択されたインデックスを取得
        let currentSelectedIndex = presenter.currentSelectedIndex
        
        // Presenterで選択状態を更新
        presenter.toggleSelection(at: indexPath.row)
        
        // 保存するデータを取得
        let updatedBusSchedules = presenter.busSchedules
        let selectedIndex = presenter.currentSelectedIndex
        
        // AppGroupsに保存
        let userDefaults = UserDefaults(suiteName: UserDefaultsKeys.suitName.rawValue)
        // busSchedulesを保存
        if let encodedSchedules = try? JSONEncoder().encode(updatedBusSchedules) {
            userDefaults?.set(encodedSchedules, forKey: UserDefaultsKeys.busSchedulesKey.rawValue)
        }
        
        // selectedIndex が nil の場合は削除、それ以外の場合は保存
        if let selectedIndex = selectedIndex {
            userDefaults?.set(selectedIndex, forKey: UserDefaultsKeys.selectedIndexKey.rawValue)
        } else {
            userDefaults?.removeObject(forKey: UserDefaultsKeys.selectedIndexKey.rawValue)
        }
        
        // NextBusWidgetを再描画
        WidgetCenter.shared.reloadTimelines(ofKind: "NextBusWidget")
        
        // テーブルビューを更新
        if let currentSelectedIndex {
            tableView.reloadRows(at: [.init(row: currentSelectedIndex, section: 0)], with: .automatic)
        }
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }

    
    // MARK: - Reload Data Method
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}
