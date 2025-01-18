//
//  ViewController.swift
//  bus_time_scheduler
//
//  Created by 林 明虎 on 2025/01/15.
//

// 競合調査：Yahooの乗換案内
// 何分ぐらい準備にかかるか記録して何分前に通知

import UIKit

final class TimeListVC: UIViewController {
    private let presenter = BusSchedulePresenter()
    private var busScheduleTimeTable: BusScheduleTimeTable
    private let scrollToNextBusButton = CardButton()
    private let fetchButton = UIButton()
    private let settingsButton = UIButton()
    
    init() {
        self.busScheduleTimeTable = BusScheduleTimeTable(presenter: presenter)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup UI
        do {
            view.backgroundColor = .systemBackground
            
            view.addSubview(busScheduleTimeTable)
            busScheduleTimeTable.translatesAutoresizingMaskIntoConstraints = false
            
            scrollToNextBusButton.setTitle("Show next bus on top", for: .normal)
            scrollToNextBusButton.addTarget(
                self, action: #selector(scrollToNearestTimeButtonTapped),
                for: .touchUpInside)
            scrollToNextBusButton.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(scrollToNextBusButton)
            
            NSLayoutConstraint.activate([
                busScheduleTimeTable.topAnchor.constraint(
                    equalTo: view.safeAreaLayoutGuide.topAnchor),
                busScheduleTimeTable.leadingAnchor.constraint(
                    equalTo: view.leadingAnchor),
                busScheduleTimeTable.trailingAnchor.constraint(
                    equalTo: view.trailingAnchor),
                busScheduleTimeTable.bottomAnchor.constraint(
                    equalTo: scrollToNextBusButton.topAnchor, constant: -20),
                
                scrollToNextBusButton.leadingAnchor.constraint(
                    equalTo: view.leadingAnchor, constant: 20),
                scrollToNextBusButton.trailingAnchor.constraint(
                    equalTo: view.trailingAnchor, constant: -20),
                scrollToNextBusButton.bottomAnchor.constraint(
                    equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
                scrollToNextBusButton.heightAnchor.constraint(equalToConstant: 50),
            ])
        }
        
        setupNavigationBar()
        // 1分ごとにテーブルを再読み込みするタイマーを設定
        Timer.scheduledTimer(timeInterval: 60.0, target: self, selector: #selector(reloadBusSchedule), userInfo: nil, repeats: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        busScheduleTimeTable.scrollToNearestTime()
        
        
    }
    
 
    private func setupNavigationBar() {
        // 中央のタイトル設定
        let appNameLabel = UILabel()
        appNameLabel.text = "Bus Time Scheduler"
        appNameLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        appNameLabel.textAlignment = .center
        appNameLabel.textColor = .accent
        navigationItem.titleView = appNameLabel
        
        let fetchBarButtonItem = UIBarButtonItem(
            image: .init(systemName: "arrow.triangle.2.circlepath"),
            primaryAction: .init(handler: { [weak self] _ in
                self?.fetchButtonTapped()
            }))
        
        fetchBarButtonItem.tintColor = .accent
        
        navigationItem.leftBarButtonItem = fetchBarButtonItem
        
        let settingBarButtonItem = UIBarButtonItem(
            image: .init(systemName: "gearshape"),
            primaryAction: .init(handler: { [weak self] _ in
                self?.settingsButtonTapped()
            }))
        settingBarButtonItem.tintColor = .accent
        
        navigationItem.rightBarButtonItem = settingBarButtonItem
    }
    
    @objc private func scrollToNearestTimeButtonTapped() {
        busScheduleTimeTable.scrollToNearestTime()
    }
    
    @objc private func fetchButtonTapped() {
        // ここでFetchの処理を実装
        print("Fetching new bus schedule data...")
    }
    
    @objc private func settingsButtonTapped() {
        let settingsVC = SettingVC()
        navigationController?.pushViewController(settingsVC, animated: true)
    }
    
    @objc private func reloadBusSchedule() {
        // バスのスケジュールを再読み込み
        busScheduleTimeTable.reloadData()
    }
}
