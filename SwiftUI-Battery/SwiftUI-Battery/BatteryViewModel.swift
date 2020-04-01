//
//  BatteryViewModel.swift
//  SwiftUI-Battery
//
//  Created by 藤　治仁 on 2020/04/01.
//  Copyright © 2020 F-Works. All rights reserved.
//

import UIKit

class BatteryViewModel: ObservableObject {
    ///バッテリー状態
    @Published var status: UIDevice.BatteryState = .unknown
    ///バッテリー残量
    @Published var remain = ""
    
    /// バッテリー状態監視開始
    func startMonitor() {
        //バッテリーレベル変化通知を受け取れるようにする
        NotificationCenter.default.addObserver(self, selector: #selector(batteryLevelChanged(notification:)), name: UIDevice.batteryLevelDidChangeNotification, object: nil)
        //バッテリー状態編か通知を受け取れるようにする
        NotificationCenter.default.addObserver(self, selector: #selector(batteryStateChanged(notification:)), name: UIDevice.batteryStateDidChangeNotification, object: nil)
        //バッテリー監視を開始する
        UIDevice.current.isBatteryMonitoringEnabled = true
        //変化通知登録しただけなので初回は更新する必要がある
        remain = String(format: "%0.1f", UIDevice.current.batteryLevel * 100)
        status = UIDevice.current.batteryState
    }
    
    /// バッテリー状態監視終了
    func stopMonitor() {
        //バッテリー監視を終了する
        UIDevice.current.isBatteryMonitoringEnabled = false
        //通知を受け取りしないように削除する
        NotificationCenter.default.removeObserver(self, name: UIDevice.batteryLevelDidChangeNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIDevice.batteryStateDidChangeNotification, object: nil)
    }
    
    @objc func batteryLevelChanged(notification: Notification) {
        remain = String(format: "%0.1f", UIDevice.current.batteryLevel * 100)
    }
    
    @objc func batteryStateChanged(notification: Notification) {
        status = UIDevice.current.batteryState
    }
}

