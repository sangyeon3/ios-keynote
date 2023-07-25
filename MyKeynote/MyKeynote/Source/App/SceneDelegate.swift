//
//  SceneDelegate.swift
//  MyKeynote
//
//  Created by 변상연 on 2023/07/17.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        
        let slideManager = SlideManager(factory: SlideFactory())
        window?.rootViewController = KeynoteViewController(slideManager: slideManager)
        window?.makeKeyAndVisible()
    }

}

