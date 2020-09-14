//
//  ViewController.swift
//  RNDM
//
//  Created by Ścibor Budkowski on 09/09/2020.
//  Copyright © 2020 Ścibor Budkowski. All rights reserved.
//

import UIKit
import Firebase

class MainVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet private weak var segmentedControl: CustomSegmentedControl!
    @IBOutlet private weak var tableView: UITableView!
    
    private var thoughts = [Thought]()
    private var thoughtsCollectionRef: CollectionReference!
    private var thoughtsListener: ListenerRegistration!
    private var selectedCategory = ThoughtCategory.funny.rawValue
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableView.automaticDimension
        
        thoughtsCollectionRef = Firestore.firestore().collection(THOUGHTS_REF)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setListener()
    }
    
    func setListener() {
        thoughtsListener = thoughtsCollectionRef.whereField(CATEGORY, isEqualTo: selectedCategory).addSnapshotListener { (snapshot, error) in
            if let error = error {
                print("Error fetching docs: \(error)")
            } else {
                self.thoughts.removeAll()
                guard let snap = snapshot else { return }
                for document in snap.documents {
                    let data = document.data()
                    let username = data[USERNAME] as? String ?? "Anonymous"
                    let timestamp = data[TIMESTAMP] as? Date ?? Date()
                    let thoughtTxt = data[THOUGHT_TXT] as? String ?? ""
                    let numLikes = data[NUM_LIKES] as? Int ?? 0
                    let numComments = data[NUM_COMMENTS] as? Int ?? 0
                    let documentId = document.documentID
                    
                    let newThought = Thought(username: username, timestamp: timestamp, thoughtTxt: thoughtTxt, numLikes: numLikes, numComments: numComments, documentId: documentId)
                    self.thoughts.append(newThought)
                }
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func categoryCHANGED(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            selectedCategory = ThoughtCategory.funny.rawValue
        case 1:
            selectedCategory = ThoughtCategory.serious.rawValue
        case 2:
            selectedCategory = ThoughtCategory.crazy.rawValue
        default:
            selectedCategory = ThoughtCategory.popular.rawValue
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        thoughtsListener.remove()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return thoughts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "thoughtCell", for: indexPath) as? ThoughtCell {
            cell.configureCell(thought: thoughts[indexPath.row])
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

