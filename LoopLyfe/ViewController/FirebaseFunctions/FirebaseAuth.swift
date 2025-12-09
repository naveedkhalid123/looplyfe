//
//  FirebaseAuth.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 05/03/2025.
//


import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

final class FirebaseAuth {
    static let shared = FirebaseAuth()
    
    private init() {}
    
    
    // utliity shared fucntion
    private let functions = Utility.shared
    
    func signIn(email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
    
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error as NSError? {
                let errorCode = AuthErrorCode.Code(rawValue: error.code)
            
                switch errorCode {
                case .wrongPassword:
                    print("Wrong password.")
                    completion(.failure(NSError(domain: "", code: error.code,
                                                userInfo: [NSLocalizedDescriptionKey: "Incorrect password. Please try again."])))
                    
                case .invalidEmail:
                    print("Invalid email format.")
                    completion(.failure(NSError(domain: "", code: error.code,
                                                userInfo: [NSLocalizedDescriptionKey: "Invalid email address. Please check and try again."])))
                    
                case .userNotFound:
                    print("No user found with this email.")
                    completion(.failure(NSError(domain: "", code: error.code,
                                                userInfo: [NSLocalizedDescriptionKey: "No account found with this email. Please sign up first."])))
                    
                default:
                    print("Firebase Auth Error:", error.localizedDescription)
                    completion(.failure(NSError(domain: "", code: error.code,
                                                userInfo: [NSLocalizedDescriptionKey: error.localizedDescription])))
                }
                return
            }

            
            guard let authResult = authResult else {
                print("No user found")
                let noUserError = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No user found."])
                completion(.failure(noUserError))
                return
            }
            
            if authResult.user.isEmailVerified {
                completion(.success(authResult))
                
            } else {
                print("Email is not verified. Please check your email.")
                let noUserError = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Email is not verified. Please check your email."])
                completion(.failure(noUserError))
            }
        }
    }
    
        func createUser(email: String, password: String, completion: @escaping (String?, Error?) -> Void) {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    completion(nil, error)
                    return
                }
    
                guard let user = authResult?.user else {
                    print("User creation failed")
                    completion(nil, nil)
                    return
                }
    
                user.sendEmailVerification { error in
                    if let error = error {
                        print("Error sending verification email: \(error.localizedDescription)")
                        completion(nil, error)
                    } else {
                        self.functions.showToast(message: "User created successfully. Verification email sent.")
                        completion(user.uid, nil)
                    }
                }
            }
        }
    
    
    
    
    func resetPassword(email: String, completion: @escaping (Bool, Error?) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                print("Error sending password reset email: \(error.localizedDescription)")
                completion(false, error)
                return
            }
            
            //self.functions.showToast(message: "Password reset email sent successfully. Check your inbox.")
            completion(true, nil)
        }
    }
    
    func verifyPhoneNumber(phoneNumber: String,completion: @escaping (String?, Error?) -> Void) {
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
            if let error = error {
                print("Error verifying phone number: \(error.localizedDescription)")
                completion(nil, error)
                return
            }
            
            guard let verificationID = verificationID else {
                print("Failed to retrieve verification ID")
                completion(nil, nil)
                return
            }
            UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
            
            completion(verificationID, nil)
        }
    }
    
    
    func createPhoneAuthCredential(verificationID: String, verificationCode: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID,verificationCode: verificationCode)
        
        Auth.auth().signIn(with: credential) { authResult, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let authResult = authResult {
                completion(.success(authResult))
            }
        }
    }

    
   
    func loginWithPhone(verificationID: String, verificationCode: String, completion: @escaping (Bool, Error?) -> Void) {
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: verificationCode)
        
        Auth.auth().signIn(with: credential) { authResult, error in
            if let error = error {
                print("Error signing in with phone credential: \(error.localizedDescription)")
                completion(false, error)
                return
            }
            
            guard let user = authResult?.user else {
                print("No user found after phone login.")
                completion(false, nil)
                return
            }
            
            print("User signed in with phone number: \(user.phoneNumber ?? "Unknown phone number")")
            completion(true, nil)
        }
    }
    
    
    func createCategory(userID: String, categoryName: String, selectedImages: [UIImage], completion: @escaping (Bool, Error?) -> Void) {
        let databaseRef = Database.database().reference().child("category")
        let storageRef = Storage.storage().reference().child("categories/\(categoryName)")
        
        // Fetch existing categories to determine the next unique ID
        databaseRef.observeSingleEvent(of: .value) { snapshot in
            var nextID = 0
            
            // Check if there are existing categories and determine the next ID
            if let categories = snapshot.value as? [String: Any] {
                let ids = categories.keys.compactMap { Int($0) }
                nextID = (ids.max() ?? -1) + 1
            }
            
            let newCategoryRef = databaseRef.child("\(nextID)")
            
            // Check if category with the same name already exists
            let duplicateCategory = snapshot.children.allObjects.contains { snap in
                if let snap = snap as? DataSnapshot,
                   let data = snap.value as? [String: Any],
                   let existingName = data["categoryName"] as? String {
                    return existingName == categoryName
                }
                return false
            }
            
            if duplicateCategory {
                self.functions.showToast(message: "Category name already exists.")
                completion(false, nil)
                return
            }
            
            self.functions.showToastActivity()
            var imageURLs: [String] = []
            let dispatchGroup = DispatchGroup()
            
            // Upload images
            for (index, image) in selectedImages.enumerated() {
                dispatchGroup.enter()
                
                guard let imageData = image.jpegData(compressionQuality: 0.8) else {
                    print("Error converting image to data.")
                    self.functions.hideToastActivity()
                    dispatchGroup.leave()
                    continue
                }
                
                let imageRef = storageRef.child("image\(index + 1).jpg")
                imageRef.putData(imageData, metadata: nil) { _, error in
                    if let error = error {
                        print("Error uploading image: \(error.localizedDescription)")
                        dispatchGroup.leave()
                        return
                    }
                    
                    imageRef.downloadURL { url, error in
                        if let error = error {
                            self.functions.hideToastActivity()
                            print("Error getting download URL: \(error.localizedDescription)")
                        } else if let url = url {
                            imageURLs.append(url.absoluteString)
                        }
                        dispatchGroup.leave()
                    }
                }
            }
            
            dispatchGroup.notify(queue: .main) {
                // After all images are uploaded, save the category data
                if imageURLs.count == selectedImages.count {
                    let categoryData: [String: Any] = [
                        "userId": userID,
                        "categoryName": categoryName,
                        "image1": imageURLs.count > 0 ? imageURLs[0] : "",
                        "image2": imageURLs.count > 1 ? imageURLs[1] : "",
                        "image3": imageURLs.count > 2 ? imageURLs[2] : "",
                        "image4": imageURLs.count > 3 ? imageURLs[3] : ""
                    ]
                    
                    newCategoryRef.setValue(categoryData) { error, _ in
                        if let error = error {
                            self.functions.hideToastActivity()
                            print("Error saving category data: \(error.localizedDescription)")
                            completion(false, error)
                            return
                        }
                        
                        self.functions.showToast(message: "Category data saved successfully.")
                        self.functions.hideToastActivity()
                        completion(true, nil)
                    }
                } else {
                    self.functions.hideToastActivity()
                    self.functions.showToast(message: "Error: Not all images were uploaded.")
                    completion(false, nil)
                }
            }
        }
    }
    
    func deleteCategory(at id: Int, completion: @escaping (Bool, Error?) -> Void) {
        let categoryRef = Database.database().reference().child("category").child("\(id)")

        categoryRef.removeValue { error, _ in
            if let error = error {
                print("Error deleting category: \(error.localizedDescription)")
                self.functions.showToast(message: "Failed to delete category.")
                completion(false, error)
            } else {
                print("Category deleted successfully.")
                self.functions.showToast(message: "Category deleted successfully.")
                completion(true, nil)
            }
        }
    }

}
