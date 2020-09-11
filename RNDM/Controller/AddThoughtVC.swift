//
//  AddThoughtVC.swift
//  RNDM
//
//  Created by Ścibor Budkowski on 11/09/2020.
//  Copyright © 2020 Ścibor Budkowski. All rights reserved.
//

import UIKit
import Firebase

class AddThoughtVC: UIViewController, UITextViewDelegate {

    @IBOutlet weak var categorySegment: CustomSegmentedControl!
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var thoughtsTxt: UITextView!
    @IBOutlet weak var postBtn: RoundButton!
    
    private var selectedCategory = ThoughtCategory.funny.rawValue
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        thoughtsTxt.layer.cornerRadius = 5
        thoughtsTxt.text = "My random thoughts..."
        thoughtsTxt.textColor = UIColor.lightGray
        thoughtsTxt.delegate = self
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        textView.textColor = UIColor.darkGray
    }
    
    @IBAction func postPressed(_ sender: Any) {
        guard let username = usernameTxt.text else { return }
        Firestore.firestore().collection(THOUGHTS_REF).addDocument(data: [
            CATEGORY : self.selectedCategory,
            NUM_COMMENTS : 0,
            NUM_LIKES : 0,
            THOUGHT_TXT : thoughtsTxt.text!,
            TIMESTAMP : FieldValue.serverTimestamp(),
            USERNAME : username
        ]) { (error) in
            if let error = error {
                print("Error adding document: \(error)")
            } else {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @IBAction func categoryChanged(_ sender: Any) {
        switch categorySegment.selectedSegmentIndex {
        case 0:
            selectedCategory = ThoughtCategory.funny.rawValue
        case 1:
            selectedCategory = ThoughtCategory.serious.rawValue
        default:
            selectedCategory = ThoughtCategory.crazy.rawValue
        }
    }
}
