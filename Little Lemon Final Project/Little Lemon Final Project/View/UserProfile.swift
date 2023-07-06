//
//  UserProfile.swift
//  Little Lemon Final Project
//
//  Created by Donald Dang on 7/2/23.
//

import SwiftUI

struct UserProfile: View {
    @Environment(\.presentationMode) var presentation
    
    
    let storedFirstName = UserDefaults.standard.string(forKey: kFirstName)
    let storedLastName = UserDefaults.standard.string(forKey: kLastName)
    let storedEmail = UserDefaults.standard.string(forKey: kEmail)
    
    var body: some View {
        VStack {
            Image("littleLemon")
                .padding()
            VStack {
                ZStack {
                    Color(hex: "495E57")
                        .edgesIgnoringSafeArea(.all)
                        .frame(height: 200)
                    
                    VStack(alignment: .leading) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Little Lemon")
                                    .foregroundColor(.yellow)
                                    .font(.largeTitle)
                                Text("Chicago")
                                    .foregroundColor(.white)
                                    .font(.title2)
                                Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist")
                                    .foregroundColor(.white)
                                    .font(.body)
                            }
                            
                            Image("food")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                        }
                    }
                    
                }
                Text("Personal Information")
                    .bold()
                    .foregroundColor(.white)
                    .font(.headline)
                
                
            }
            .padding()
            .background(Color(hex: "495E57"))
            Group {
                HStack {
                    VStack {
                        Spacer()
                        Text("First Name")
                            .italic()
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(size: 32))
                            .padding(.leading, 30)
                        Text(storedFirstName ?? "")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(size: 24))
                            .padding(.leading, 30)
                        Spacer()
                        Text("Last Name")
                            .italic()
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(size: 32))
                            .padding(.leading, 30)
                        Text(storedLastName ?? "")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(size: 24))
                            .padding(.leading, 30)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    
                    Image(systemName: "person.fill")
                        .font(.system(size: 150))
                        .padding(.trailing, 20)
                    
                }
                Text("Email")
                    .italic()
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 32))
                    .padding(.leading, 30)
                Text(storedEmail ?? "")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 24))
                    .padding(.leading, 30)
                Spacer()
            }
            Button {
                UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                self.presentation.wrappedValue.dismiss()
            } label: {
                Text("Logout")
                    .foregroundColor(.black)
                    .font(.headline)
                    .padding(.horizontal, 5)
                    .padding(.vertical, 5)
                    .frame(maxWidth: .infinity)
                    .background(Color(hex: "F4CE14"))
                    .cornerRadius(10)
            }
            Spacer()
        }
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}
