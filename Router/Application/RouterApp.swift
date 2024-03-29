//
//  RouterApp.swift
//  Router
//
//  Created by Gaea on 2023/02/21.
//
//  MARK: - App 목적
/// 1.  운동 할 때 운동 시간 및 횟수 체크
/// 2.  운동 시 이전 운동 몇키로 몇 세트로 진행했는지 체크
/// 3.  휴식 시간 체크
/// 4.  운동 총 시간 체크
/// 5.  애플 워치 연동해서 폰은 다른 활동을 할 수 있게 한다.

import SwiftUI
import UserNotifications
import AVFoundation
import AudioToolbox

@main
    
struct RouterApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate: AppDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        //  오디오 설정
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, mode: .default, options: [.mixWithOthers])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Error setting audio session category: \(error.localizedDescription)")
        }
        //  알림 설정
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                UNUserNotificationCenter.current().delegate = self
            }
        }
        return true
    }
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let sceneConfiguration = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        sceneConfiguration.delegateClass = SceneDelegate.self
        return sceneConfiguration
    }
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    func sceneWillEnterForeground(_ scene: UIScene) {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, mode: .default, options: [.mixWithOthers])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Error setting audio session category: \(error.localizedDescription)")
        }

    }
    func sceneDidEnterBackground(_ scene: UIScene) {
       
    }
}
