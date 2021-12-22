//
//  Observer.swift
//  Messenger
//
//  Created by Migel Lestev on 07.12.2021.
//

import Firebase
import FirebaseStorage
import UIKit

// protocol to observer
protocol FireObserverProtocol {
    func observingCurrentUserName(completion: @escaping (String?) -> ())
    func createAccount(data: Data, email: String, password: String, name: String, completion: @escaping (String) -> Void)
    func signIn(email: String, password: String, completion: @escaping (String) -> Void)
    func fetchUser(completion: @escaping (User) -> Void)
    func signOut()
    
    // chat ....
    func sendMessage(user: User, data: String)
    func observingDataUsers(id: String, sender: Sender, neededId: String, completion: @escaping (Message?) -> Void)
}

class FireObserver: FireObserverProtocol {
    
    weak var messageView: MessengerViewController?
    
    fileprivate func convertToString(dateFormat: String = "h:mm") -> String {
        let dateNow = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: dateNow)
    }
    
    //MARK: Function for observing ....
    
    // get user avatar
    func getImageUser(currentUserId: String, data: Data, completion: @escaping (Result<URL, Error>) -> Void) {
        let storageReference = Storage.storage().reference().child("avatars").child(currentUserId)
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        storageReference.putData(data, metadata: metadata) { metadata, error in
            guard let _ = metadata else {
                completion(.failure(error!))
                return
            }
            storageReference.downloadURL { url, error in
                guard let url = url else {
                    completion(.failure(error!))
                    return
                }
                completion(.success(url))
                
            }
            
        }
    }
    
    // get current username
    func observingCurrentUserName(completion: @escaping (String?) -> ()) {
        guard let id = Auth.auth().currentUser?.uid else { return }
        let reference = Database.database().reference().child("users")
        reference.child(id).observeSingleEvent(of: .value) { snapshot in
            guard let dictionary = snapshot.value as? [String : Any] else { return }
            completion(dictionary["name"] as? String)
        }
    }
    
    // login users
    func signIn(email: String, password: String, completion: @escaping (String) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            guard error == nil else {
                completion("Data entered incorrectly")
                return
            }
            completion("")
        }
    }
    
    // searching all users
    func fetchUser(completion: @escaping (User) -> Void)  {

        Database.database().reference().child("users").observe(.childAdded, with: { snapshot in
            if let dictionary = snapshot.value as? [String : AnyObject] {
                
                var user = User(dictionary: dictionary)
                user.id = snapshot.key
                
                let storageRefForObserve = Storage.storage().reference().child("avatars")
                let storageReference = Storage.storage().reference(forURL: (dictionary["avatar"] as? String)!)
                let megaByte = Int64(1 * 1024 * 1024)

                storageRefForObserve.listAll { (result, error) in
                    if error != nil {
                        self.messageView?.imageNotInternet.isHidden = false
                        return
                    }

                    DispatchQueue.main.async {
                        for item in result.items {
                            if item.name == user.id {
                                storageReference.getData(maxSize: megaByte, completion: { data, error in
                                    guard let data = data else { return }
                                    let image = UIImage(data: data)
                                    user.avatar = image
                                    completion(user)
                                    self.messageView?.imageNotInternet.isHidden = true
                                })
                            }
                        }
                    }
                }
            }
        }, withCancel: nil)
    }
    
    // sign out
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            return
        }
    }
    
    //creating new users
    func createAccount(data: Data, email: String, password: String, name: String, completion: @escaping (String) -> Void) {

        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            guard error == nil else {
                completion("Please not use auto fill")
                return
            }
            
            // upload image
            self.getImageUser(currentUserId: authResult?.user.uid ?? "", data: data) { (result) in
                switch result {
                case .success(let url):
                    
                    let reference = Database.database().reference(fromURL: "https://messenger-b7f5f-default-rtdb.firebaseio.com/")
                    reference.child("users").child(authResult?.user.uid ?? "").updateChildValues(["name" : name, "email" : email, "avatar" : url.absoluteString])
                    completion("")
                    
                case .failure(let error):
                    completion("\(error)")
                }
            }
            
        }
    }
    
    //MARK: chat ....
    
    func sendMessage(user: User, data: String) {
        var data = data
        // ref for messages
        let fromId = Auth.auth().currentUser?.uid
        let reference = Database.database().reference().child("users").child(fromId ?? "")
        let values = ["data" : data, "date" : convertToString(), "toId" : user.id ?? "", "fromId" : fromId ?? "", "timeForSort" : convertToString(dateFormat: "yyyy-MM-dd'T'HH:mm:ssZ")] as [String : Any]
        reference.child("chats").child(user.id ?? "").childByAutoId().updateChildValues(values)
        data = ""
    }
    
//    func observingAllMessages(user: User, sender: Sender) {
//        guard let id = Auth.auth().currentUser?.uid else { return }
//        observingDataUsers(id: user.id ?? "", sender: sender, neededId: id)
//        observingDataUsers(id: id, sender: sender, neededId: user.id ?? "") // current sender
//    }
//
    func observingDataUsers(id: String, sender: Sender, neededId: String, completion: @escaping (Message?) -> Void) {

        let reference = Database.database().reference().child("users").child(id).child("chats")
        reference.observe(.childAdded) { snapshot in
            let toId = snapshot.key
            
            if toId == neededId {
                reference.child(toId).observe(.childAdded) { snapshot in
                    let messageId = snapshot.key

                    reference.child(toId).child(messageId).observeSingleEvent(of: .value) { snapshot in
                        
                        if let dictionary = snapshot.value as? [String : AnyObject] {
                            let message = Message(timeForSort: dictionary["timeForSort"] as? String ?? "", sender: sender,
                                                  messageId: "",
                                                  sentDate: Date(),
                                                  kind: .text(dictionary["data"] as? String ?? ""),
                                                  toId: dictionary["toId"] as? String ?? "",
                                                  fromId: dictionary["fromId"] as? String ?? "",
                                                  date: dictionary["date"] as? String ?? "")
                            DispatchQueue.main.async {
                                completion(message)
                            }
                        }
                    }
                }
            }
        }
    }
    
}
