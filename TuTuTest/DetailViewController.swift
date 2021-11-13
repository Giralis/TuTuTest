//
//  DetailViewController.swift
//  TuTuTest
//
//  Created by Владимир Тимофеев on 13.11.2021.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var signatureCountLabel: UILabel!
    
    var petition = Petition(title: "", body: "", signatureCount: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = petition.title
        bodyLabel.text = petition.body
        signatureCountLabel.text = "Signatures: \(String(petition.signatureCount))"
    }
    
}
