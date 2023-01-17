//
//  ContentView.swift
//  UnitUITesting
//
//  Created by Ogabek Matyakubov on 14/01/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = HomeViewModel()
    
    func delete(indexSet: IndexSet) {
        let contact = viewModel.contacts[indexSet.first!]
        viewModel.apiContactDelete(contact: contact, handler: { response in
            if response {
                viewModel.apiContactList()
            }
        })
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    ForEach(viewModel.contacts, id:\.id) { contact in
                        ContactCell(contact: contact)
                    }
                    .onDelete(perform: delete)
                }.listStyle(PlainListStyle())
                
                if viewModel.isLoading {
                    ProgressView()
                }
            }
            .navigationTitle("SwiftUI MVVM")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: Image(systemName: "arrow.triangle.2.circlepath").onTapGesture {
                viewModel.apiContactList()
            })
        }.onAppear {
            viewModel.apiContactList()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
