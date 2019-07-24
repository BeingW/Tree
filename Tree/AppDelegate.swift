//
//  AppDelegate.swift
//  Tree
//
//  Created by Jae Ki Lee on 5/22/19.
//  Copyright © 2019 Jae Ki Lee. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //1.프로그램을 실행한다.
        //2.DB에 User Table이 있는지 확인하고, 있다면 DB의 data로 User 객체를 만든다.
        let userDAO = UserDAO()
        
        if userDAO.checkOutUserTableExeist() {
            User.shared = userDAO.fetchData()
        }
        
        window = UIWindow()
        
        window?.rootViewController = MainTabBarController()
        
        return true 
    }

    //활성화에서 비활성화로 앱이 진행될때 메시지가 보내진다. 핸드폰 전화나, 메시지가 올때, 게임 푸시는 기능은 이곳에서 처리.
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    //앱이 예기치 못하게 종료 될때 이곳에 메시지를 보낸다. 백그라운드 작업일 경우 이곳을 이용. 유저 데이터 중간저장등.(생각: 앱이 진행되는 작업들을 stack 으로 쌓아 두었다가 이쪽에서 저장하도록.?)
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    //앱이 백그라운드에서 포어그라운드로 옮겨질 때, 홈버튼을 클릭해서 다른 곳으로 갔다가 되돌아 올때.
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    //데스크가 정지되어 있던 상태에서 재시작 될때. 게임으로 치면 paused 상태였다가 되돌아 올때.
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    //어플리케이션을 닫을 때. 메시지가 보내지는 곳.
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

