//
//  ViewModel.swift
//  UnitUITesting
//
//  Created by Ogabek Matyakubov on 17/01/23.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    @Published var contacts = [Contact]()
    @Published var isLoading = false
    
    @Published var tempContact: Contact!
    
    func apiContactList() {
        isLoading = true
        AFHttp.get(url: AFHttp.API_CONTACT_LIST, params: AFHttp.paramsEmpty(), handler: { response in
            self.isLoading = false
            switch response.result {
            case .success:
                let contacts = try! JSONDecoder().decode([Contact].self, from: response.data!)
                self.contacts = contacts
                self.tempContact = contacts.last
            case .failure(let error):
                print(error)
            }
        })
    }
    
    func apiContactDelete(contact: Contact, handler: @escaping (Bool) -> Void) {
        isLoading = true
        AFHttp.del(url: AFHttp.API_CONTACT_DELETE + contact.id, params: AFHttp.paramsEmpty(), handler: { response in
            self.isLoading = false
            switch response.result {
            case .success(let data):
                print(data)
                let contacts = try! JSONDecoder().decode(Contact.self, from: response.data!)
                handler(true)
            case .failure(let error):
                print(error)
                handler(false)
            }
        })
    }
    
}
