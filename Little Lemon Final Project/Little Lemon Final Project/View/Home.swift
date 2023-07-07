//
//  Home.swift
//  Little Lemon Final Project
//
//  Created by Donald Dang on 7/2/23.
//

import SwiftUI

struct Home: View {
    let persistence = PersistenceController.shared
    
    var body: some View {
        TabView {
            Menu()
                .environment(\.managedObjectContext, persistence.container.viewContext)
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("Menu")
                }
            UserProfile()
                .tabItem {
                    Image(systemName: "square.and.pencil")
                    Text("Profile")
                }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
