//
//  ViewController.swift
//  TrinityAssessmentProject
//
//  Created by NouraizT on 29/08/2022.
//

import UIKit



class ContactsViewController: UIViewController {

    @IBOutlet weak var contactsTV: UITableView!
    
    var cellReuseID = "ContactTableViewCell"
    var contactsViewModel = ContactsViewModel()
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configTableView()
        configRefreshControl()
        
        self.contactsViewModel.getContactsFromJSON(file: "ContactsData")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configNavBar()
    }

    private func configTableView() {
        let nib = UINib(nibName: "ContactTableViewCell", bundle: nil)
        contactsTV.register(nib, forCellReuseIdentifier: cellReuseID)
        
        contactsTV.delegate = self
        contactsTV.dataSource = self
    }
    
    private func configRefreshControl() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        contactsTV.addSubview(refreshControl)
    }
    
    private func configNavBar() {
        self.navigationController?.isNavigationBarHidden = false
        
        let navBarAddButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(self.addContact))
        let navBarSearchButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(self.searchContact))
        
        self.navigationItem.rightBarButtonItem = navBarAddButton
        self.navigationItem.leftBarButtonItem = navBarSearchButton
        
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor(red: 255/255, green: 140/255, blue: 0/255, alpha: 1)
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor(red: 255/255, green: 140/255, blue: 0/255, alpha: 1)
    }
    
    @objc func addContact() {
        
    }
    
    @objc func searchContact() {
        
    }
    
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        
        self.contactsViewModel.getContactsFromJSON(file: "ContactsData")
        
        self.contactsTV.reloadData()
        
        refreshControl.endRefreshing()
    }
}

extension ContactsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contactsViewModel.numberOfRowsForContactsTV()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseID, for: indexPath) as! ContactTableViewCell
        cell.contactName.text = (contactsViewModel.contacts?[indexPath.row].firstName ?? "") + " " + (contactsViewModel.contacts?[indexPath.row].lastName ?? "")
        cell.contactAvatar.layer.cornerRadius = cell.contactAvatar.frame.height / 2
        
        return cell
    }
}

extension ContactsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        64
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let contact = contactsViewModel.contacts?[indexPath.row] {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ContactDetailViewController") as! ContactDetailViewController
            vc.contactDetail = contact
            vc.contactDetailUpdateDelegate  = self
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension ContactsViewController: ContactsViewControllerDelegate {
    func contactsFetchedSuccessfully(conatcts: [ContactsModel]) {
        self.contactsTV.reloadData()
    }
    
    func contactsFetchedFailure(errorMsg: String) {
        
    }
}

extension ContactsViewController: ContactDetailDelegate {
    func didUpdateContactInfo(contactDetail: ContactsModel) {
        if let contacts = self.contactsViewModel.contacts  {
            for contact in contacts {
                if contact.firstName == contactDetail.firstName {
                    if let index = self.contactsViewModel.contacts?.firstIndex(where: {$0.firstName == contact.firstName}) {
                        self.contactsViewModel.contacts?[index] = contactDetail
                        
                        self.contactsTV.reloadData()
                    }
                    
                }
            }
        }
    }
}

