//
//  ViewController.swift
//  FirestoreSample
//
//  Created by Tomoyuki Ito on 2018/09/04.
//  Copyright © 2018 Nagisa Inc. All rights reserved.
//

import UIKit
import FirebaseFirestore

class ViewController: UIViewController {

    lazy var db: Firestore = {
        return Firestore.firestore()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        addSnapshotListener()
        setData(name: "ichiro")
    }
    
}

extension ViewController {
    
    private func getDocuments() {
        db.collection("users").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
    }
    
    private func whereFieldGetDocuments() {
        db.collection("users").whereField("isValid", isEqualTo: true).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
    }
    
    private func addSnapshotListener() {
        db.collection("users").addSnapshotListener { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
    }
    
    private func whereFieldAddSnapshotListener() {
        db.collection("users").whereField("isValid", isEqualTo: true).addSnapshotListener() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
    }
    
    private func setData(name: String) {
        db.collection("users").document().setData(["name": name]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
}
