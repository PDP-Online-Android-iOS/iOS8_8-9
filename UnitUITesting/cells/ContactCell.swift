//
//  ContactCell.swift
//  UnitUITesting
//
//  Created by Ogabek Matyakubov on 17/01/23.
//

import SwiftUI

struct ContactCell: View {
    
    var contact: Contact
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(contact.name.uppercased()).fontWeight(.bold)
            Text(contact.number).padding(.top, 5)
        }
        .padding()
    }
}

struct ContactCell_Previews: PreviewProvider {
    static var previews: some View {
        ContactCell(contact: Contact(id: "", name: "OgabekDev", number: "+998 93 203 73 13"))
    }
}
