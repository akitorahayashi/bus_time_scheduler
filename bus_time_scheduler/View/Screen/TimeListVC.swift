//
//  ViewController.swift
//  bus_time_scheduler
//
//  Created by 林 明虎 on 2025/01/15.
//

// 競合調査：Yahooの乗換案内
// 何分ぐらい準備にかかるか記録して何分前に通知

import UIKit

class TimeListVC: UIViewController {
    private let presenter = BusSchedulePresenter()
    private var busScheduleTimeTable: BusScheduleTimeTable
    private let scrollToNextBusButton = CardButton()
    
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
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        busScheduleTimeTable.scrollToNearestTime()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        // 中央のタイトル設定
        let appNameLabel = UILabel()
        appNameLabel.text = "Bus Time Scheduler"
        appNameLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        appNameLabel.textAlignment = .center
        appNameLabel.textColor = .accent
        navigationItem.titleView = appNameLabel
        
        view.addSubview(busScheduleTimeTable)
        busScheduleTimeTable.translatesAutoresizingMaskIntoConstraints = false
        
        scrollToNextBusButton.setTitle("Show next bus on top", for: .normal)
        scrollToNextBusButton.addTarget(self, action: #selector(scrollToNearestTimeButtonTapped), for: .touchUpInside)
        scrollToNextBusButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollToNextBusButton)
        
        NSLayoutConstraint.activate([
            busScheduleTimeTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            busScheduleTimeTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            busScheduleTimeTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            busScheduleTimeTable.bottomAnchor.constraint(equalTo: scrollToNextBusButton.topAnchor, constant: -20),
            
            scrollToNextBusButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            scrollToNextBusButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            scrollToNextBusButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            scrollToNextBusButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func scrollToNearestTimeButtonTapped() {
        busScheduleTimeTable.scrollToNearestTime()
    }
}
