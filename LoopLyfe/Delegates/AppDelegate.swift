//
//  AppDelegate.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 13/02/2025.
//


import UIKit
import FirebaseCore
import FirebaseMessaging
import GoogleSignIn
import UserNotifications
import FirebaseAuth

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication,didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        IAPManager.shared.fetchProducts()
        
        UNUserNotificationCenter.current().delegate = self
        Messaging.messaging().delegate = self
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, _ in
            print("Notification permission granted: \(granted)")
        }
        application.registerForRemoteNotifications()
        
        Messaging.messaging().token { token, error in
            if let error = error {
                print("Error fetching FCM registration token: \(error)")
            } else if let token = token {
                UserDefaultsManager.shared.deviceToken = token
                print("FCM registration token: \(token)")
            }
        }

        return true
    }

    // Google Sign-In
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }

}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound, .badge])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("User tapped notification: \(response.notification.request.content.userInfo)")
        completionHandler()
    }
}

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Refreshed FCM token: \(fcmToken ?? "")")
    }
}



// MARK: - All Root View Controller
extension AppDelegate {

    func goToHomeViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
              let tabBarVC = storyboard.instantiateViewController(withIdentifier: "TabBarViewController") as! UITabBarController
              let navigationController = UINavigationController(rootViewController: tabBarVC)
              navigationController.isNavigationBarHidden = true
              if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                  sceneDelegate.window?.rootViewController = navigationController
              }
      }
}

// MARK: - Firebase Phone Auth APNs Handling
extension AppDelegate {
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // Required for Firebase Phone Auth
        Auth.auth().setAPNSToken(deviceToken, type: .prod) // use .prod for release builds
        print("APNs token registered for Firebase Auth")
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register for remote notifications:", error.localizedDescription)
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // Forward Firebase Auth's silent push to Firebase itself
        if Auth.auth().canHandleNotification(userInfo) {
            completionHandler(.noData)
            return
        }

        print("Received remote notification:", userInfo)
        completionHandler(.newData)
    }
}
