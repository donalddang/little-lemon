//
//  Onboarding.swift
//  Little Lemon Final Project
//
//  Created by Donald Dang on 7/2/23.
//

import SwiftUI
//Used in a global scope
let kFirstName = "first name key"
let kLastName = "last name key"
let kEmail = "email key"
let kIsLoggedIn = "kIsLoggedIn"

struct Onboarding: View {
    @State var step = 0
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    @State var isLoggedIn = false
    
    private let steps = ["First Name", "Last Name", "Email"]
    
    private func checkIfEmpty() -> Bool {
        if firstName.isEmpty || lastName.isEmpty || email.isEmpty {
            return false
        }
        
        return true
    }
    
    private func nextStep() {
        step += 1
    }
    
    private func progressPercentage() -> CGFloat {
        return CGFloat(step + 1) / CGFloat(steps.count)
    }
    
    private func registerUser() {
        if checkIfEmpty() {
            UserDefaults.standard.set(firstName, forKey: kFirstName)
            UserDefaults.standard.set(lastName, forKey: kLastName)
            UserDefaults.standard.set(email, forKey: kEmail)
            UserDefaults.standard.set(true, forKey: kIsLoggedIn)
            isLoggedIn = true
        }
    }
    
    private func stepText() -> String {
        let currentStep = step + 1
        return "Step \(currentStep) of \(steps.count)"
    }
    var body: some View {
        NavigationView {
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
                    Text("Welcome. Let's Get You Onboarded!")
                        .bold()
                        .foregroundColor(Color(hex: "EDEFEE"))
                        //.background(Color(hex: "EDEFEE"))
                }
                .padding()
                .background(Color(hex: "495E57"))
                Spacer()
                NavigationLink(destination: Home(), isActive: $isLoggedIn) {
                    EmptyView()
                }
                Group {
                    if step == 0 {
                        Text("First Name")
                            .bold()
                        Spacer()
                        TextField("Enter your first name", text: $firstName)
                            .textContentType(.givenName)
                            .keyboardType(.namePhonePad)
                            .autocapitalization(.words)
                    } else if step == 1 {
                        Text("Last Name")
                            .bold()
                        Spacer()
                        TextField("Enter your last name", text: $lastName)
                            .textContentType(.familyName)
                            .keyboardType(.namePhonePad)
                            .autocapitalization(.words)
                    } else if step == 2 {
                        Text("Email")
                            .bold()
                        Spacer()
                        TextField("Enter your email", text: $email)
                            .textContentType(.emailAddress)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                    }
                }
                
                Spacer()
                
                VStack {
                    if step < 2 {
                        Button(action: nextStep) {
                            Text("Next")
                                .foregroundColor(.black)
                                .font(.headline)
                                .padding(.horizontal, 5)
                                .padding(.vertical, 5)
                                .frame(maxWidth: .infinity)
                                .background(Color(hex: "F4CE14"))
                                .cornerRadius(10)
                        }
                        .foregroundColor(.black)
                        .background(Color(hex: "F4CE14"))
                        .cornerRadius(8)
                    } else {
                        Button(action: registerUser) {
                            Text("Register")
                                .foregroundColor(.black)
                                .font(.headline)
                                .padding(.horizontal, 5)
                                .padding(.vertical, 5)
                                .frame(maxWidth: .infinity)
                                .background(Color(hex: "F4CE14"))
                                .cornerRadius(10)
                        }
                        .foregroundColor(.black)
                        .background(Color(hex: "F4CE14"))
                        .cornerRadius(8)
                    }
                }
                .frame(maxWidth: .infinity)
                
                Spacer()
                
                Group {
                    Text(stepText())
                        .font(.headline)
                    
                    
                    ProgressView(value: progressPercentage())
                        .padding(.vertical)
                }
                
                
                Spacer()
            }
            .onAppear {
                if UserDefaults.standard.bool(forKey: kIsLoggedIn) {
                    isLoggedIn = true
                }
            }
        }
    }
    
    
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}
