//
//  SceneDelegate.swift
//  MessageKitPractice
//
//  Created by 서현웅 on 2023/07/30.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let vc = ViewController()
        let navigationVC = UINavigationController(rootViewController: vc)
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navigationVC
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
    }
}
