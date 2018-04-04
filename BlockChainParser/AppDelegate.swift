//
//  AppDelegate.swift
//  BlockChainParser
//
//  Created by Лаки on 04.04.2018.
//  Copyright © 2018 Лаки. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let netManager = NetworkManager()

    public struct SendRequest: RequestBuilder {
        public var path: String {
            return "/ru/ticker"
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        netManager.request(requestBuilder:SendRequest(), onSuccess: { (usd) in
            let usdCurve =  CurveResponse.init(dictionary: usd)
            print(usdCurve.buy)

        }) { (error) in
            assertionFailure()
        }
        return true
    }
}

