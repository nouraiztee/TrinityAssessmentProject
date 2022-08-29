//
//  ContactDetailViewController.swift
//  TrinityAssessmentProject
//
//  Created by NouraizT on 29/08/2022.
//

import UIKit

protocol ContactDetailDelegate: AnyObject {
    func didUpdateContactInfo(contactDetail: ContactsModel)
}

class ContactDetailViewController: UIViewController {

    @IBOutlet weak var conatactAvatar: UIImageView!
    @IBOutlet weak var contactDetailTv: UITableView!
    @IBOutlet weak var userAvatar: UIImageView!
    
    var cellReuseID = "ContactDetailFeieldTableViewCell"
    var contactDetail:  ContactsModel?
    
    weak var contactDetailUpdateDelegate: ContactDetailDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configContactDetailTV()
        userAvatar.layer.cornerRadius = userAvatar.frame.height / 2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configNavBar()
    }

    
    private func configContactDetailTV() {
        contactDetailTv.register(UINib(nibName: "ContactDetailFeieldTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseID)
        contactDetailTv.dataSource = self
        contactDetailTv.delegate = self
    }
    
    private func configNavBar() {
        self.navigationController?.navigationBar.isHidden = false
        
        let navBarSaveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveDetail))
        let navBarCancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelSave))
        
        self.navigationItem.rightBarButtonItem = navBarSaveButton
        self.navigationItem.leftBarButtonItem = navBarCancelButton
        
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor(red: 255/255, green: 140/255, blue: 0/255, alpha: 1)
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor(red: 255/255, green: 140/255, blue: 0/255, alpha: 1)
    }
    
    @objc func saveDetail() {
        self.contactDetail?.firstName  = (contactDetailTv.cellForRow(at: IndexPath(row: 0, section: 0)) as! ContactDetailFeieldTableViewCell).valueTextField.text
        self.contactDetail?.lastName  = (contactDetailTv.cellForRow(at: IndexPath(row: 1, section: 0)) as! ContactDetailFeieldTableViewCell).valueTextField.text
        self.contactDetail?.email  = (contactDetailTv.cellForRow(at: IndexPath(row: 0, section: 1)) as! ContactDetailFeieldTableViewCell).valueTextField.text
        self.contactDetail?.phone  = (contactDetailTv.cellForRow(at: IndexPath(row: 1, section: 1)) as! ContactDetailFeieldTableViewCell).valueTextField.text
        
        self.contactDetailUpdateDelegate?.didUpdateContactInfo(contactDetail: self.contactDetail!)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func cancelSave() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension ContactDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseID, for: indexPath) as! ContactDetailFeieldTableViewCell
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                cell.fieldName.text = "First Name"
                cell.valueTextField.text = contactDetail?.firstName
            }else {
                cell.fieldName.text = "Last Name"
                cell.valueTextField.text = contactDetail?.lastName
            }
        }else {
            if indexPath.row == 0 {
                cell.fieldName.text = "Email"
                cell.valueTextField.text = contactDetail?.email
            }else {
                cell.fieldName.text = "Phone"
                cell.valueTextField.text = contactDetail?.phone
            }
        }
        
        return cell
    }
}

extension ContactDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Main Information"
        }else {
            return "Sub Information"
        }
    }
}
