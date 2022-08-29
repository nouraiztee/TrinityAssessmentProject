//
//  ContactsViewModel.swift
//  TrinityAssessmentProject
//
//  Created by NouraizT on 29/08/2022.
//

import Foundation

protocol ContactsViewModelDelegate {
    func getContactsFromJSON(file fileName: String)
}

protocol ContactsViewControllerDelegate: AnyObject {
    func contactsFetchedSuccessfully(conatcts: [ContactsModel])
    func contactsFetchedFailure(errorMsg: String)
}

class ContactsViewModel: ContactsViewModelDelegate {
    
    var contacts: [ContactsModel]?
    weak var contactsVCDelegate: ContactsViewControllerDelegate?
    
    func getContactsFromJSON(file fileName: String) {
        loadContactsFrom(file: fileName)
    }
    
    private func loadContactsFrom(file fileName: String) {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([ContactsModel].self, from: data)
                self.contacts = jsonData
                
                self.contactsVCDelegate?.contactsFetchedSuccessfully(conatcts: jsonData)
                
            } catch {
                self.contactsVCDelegate?.contactsFetchedFailure(errorMsg: error.localizedDescription)
            }
        }
    }
    
    func numberOfRowsForContactsTV() -> Int {
        if let contacts = self.contacts {
            return contacts.count
        }else {
            return 0
        }
    }
}
