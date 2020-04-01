//
//  ContentView.swift
//  SwiftUI-Battery
//
//  Created by 藤　治仁 on 2020/04/01.
//  Copyright © 2020 F-Works. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var batteryVM = BatteryViewModel()
    
    var body: some View {
        VStack {
            Text("バッテリー残量\(batteryVM.remain)%")
            
            if batteryVM.status == .charging {
                Text("充電中")
            } else if batteryVM.status == .full {
                Text("満充電")
            } else if batteryVM.status == .unplugged {
                Text("バッテリーで動作中")
            } else if batteryVM.status == .unknown {
                Text("状態不明")
            }
        }
        .onAppear() {
            //バッテリー監視を開始する
            self.batteryVM.startMonitor()
        }
        .onDisappear() {
            //バッテリー監視を終了する
            self.batteryVM.stopMonitor()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
