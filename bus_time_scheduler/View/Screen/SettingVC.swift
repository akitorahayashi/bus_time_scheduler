//
//  SettingVC.swift
//  bus_time_scheduler
//
//  Created by 林 明虎 on 2025/01/16.
//

import UIKit

final class SettingVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    private let pickerView = UIPickerView()
    private let toggleSwitch = UISwitch()
    private let label = UILabel()
    
    // 5分間隔で5分から120分までのオプションを格納した配列
    private let timeIntervals = Array(stride(from: 5, to: 121, by: 5))

    override func loadView() {
        super.loadView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        // Backボタンの色を設定
        navigationController?.navigationBar.tintColor = .accent
        
        // 通知の実行をするToggleに対するラベルの設定
        label.text = "通知を実行"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16)
        
        // トグルスイッチの位置とアクションを設定
        toggleSwitch.onTintColor = .accent
        toggleSwitch.addTarget(self, action: #selector(toggleSwitchChanged), for: .valueChanged)
        
        // ピッカービューの設定
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.isUserInteractionEnabled = toggleSwitch.isOn
        pickerView.backgroundColor = toggleSwitch.isOn ? .systemBackground : .gray.withAlphaComponent(0.5)
        
        // 角丸を設定
        pickerView.layer.cornerRadius = 15
        pickerView.layer.masksToBounds = true

        // UIStackViewに追加
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(toggleSwitch)
        stackView.addArrangedSubview(pickerView)
        
        // ViewにStackViewを追加
        view.addSubview(stackView)

        // Auto Layout制約を使って中央に配置
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 300),
            pickerView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    // MARK: - UISwitch Action
    @objc private func toggleSwitchChanged() {
        // トグルスイッチがオンならピッカービューを有効に、オフなら無効にする
        let isOn = toggleSwitch.isOn
        
        // アニメーションを追加して状態変更
        UIView.animate(withDuration: 0.3, animations: {
            self.pickerView.backgroundColor = isOn ? .systemBackground : .gray.withAlphaComponent(0.5)
            self.pickerView.isUserInteractionEnabled = isOn // ユーザーインタラクションの有効化/無効化
        })
    }
    
    // MARK: - UIPickerViewDataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 // 時間のインターバルは1列だけ
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return timeIntervals.count // 時間のインターバルの数
    }
    
    // MARK: - UIPickerViewDelegate
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let minutes = timeIntervals[row]
        return "\(minutes) 分前"
    }
    
    // 選択された時間（分数）を取得する関数
    func getSelectedTime() -> Int {
        let selectedRow = pickerView.selectedRow(inComponent: 0)
        return timeIntervals[selectedRow]
    }
}
