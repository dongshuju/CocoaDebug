//
//  Example
//  man
//
//  Created by man on 11/11/2018.
//  Copyright © 2018 man. All rights reserved.
//

import UIKit

public class _WindowHelper: NSObject {
    public static let shared = _WindowHelper()
    
    var window: CocoaDebugWindow?
    var displayedList = false
    weak var appMainWindow: UIWindow?
    var vc = CocoaDebugViewController()
    
    private override init() {
        super.init()
    }

    public func enable() {
        self.updateAppKeyWindow()
        self.window = CocoaDebugWindow(frame: UIScreen.main.bounds)
        // This is for making the window not to effect the StatusBarStyle
        self.window?.bounds.size.height = UIScreen.main.bounds.height.nextDown
        if self.window?.rootViewController != self.vc {
            self.window?.rootViewController = self.vc
            self.window?.delegate = self
            self.window?.isHidden = false
            _WHDebugFPSMonitor.sharedInstance()?.startMonitoring()
            _WHDebugMemoryMonitor.sharedInstance()?.startMonitoring()
            _WHDebugCpuMonitor.sharedInstance()?.startMonitoring()
        }
    }

    public func disable() {
        self.sendBackKeyWindow()
        self.window?.rootViewController = nil
        self.window?.delegate = nil
        self.window?.isHidden = true
        self.window = nil
        _WHDebugFPSMonitor.sharedInstance()?.stopMonitoring()
        _WHDebugMemoryMonitor.sharedInstance()?.stopMonitoring()
        _WHDebugCpuMonitor.sharedInstance()?.stopMonitoring()
    }
    
    public func updateAppKeyWindow() {
        self.appMainWindow = UIApplication.shared.keyWindow
    }
    
    public func sendBackKeyWindow() {
        self.appMainWindow?.makeKeyAndVisible()
    }
}
