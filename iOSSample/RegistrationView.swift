//
//  RegistrationView.swift
//  iOSSample
//
//  Created by Chandra Hasan on 17/10/23.
//

import SwiftUI

struct RegistrationView: View {
        @State var userName : String = ""
        @State var emailID : String = ""
        @State var password : String = ""
        @State var re_password : String = ""
        @State var showLoginView: Bool = false
        @State var isEnteredUserValide: Bool = false
        @State var isEnteredEmailValide: Bool = false
        @State var isRegSuccess: Bool = false
        private var isAssetValid: Bool {
            !userName.isEmpty && !emailID.isEmpty && !password.isEmpty && !re_password.isEmpty
        }

        var body: some View {
                Spacer()
                VStack(alignment: .center) {
                    TextField("Enter your Name", text: $userName)
                        .padding()
                        .border(Color.black)
                    TextField("Enter your Mail ID", text: $emailID)
                        .padding()
                        .border(Color.black)
                    SecureField("Enter Password", text: $password)
                        .padding()
                        .border(Color.black)
                        .keyboardType(.numberPad)
                    SecureField("Re-Enter Password", text: $re_password)
                        .padding()
                        .border(Color.black)
                        .keyboardType(.numberPad)
                    Button("Submit") {
                        if(!emailID.isValidEmail()) {
                            self.isEnteredEmailValide = true
                            return
                        }
                        if(self.isDataStored)() {
                            self.isRegSuccess = true
                        }
                    }
                    .padding()
                    .border(Color.black)
                    .frame(width: 200, height: 50, alignment: .center)
                    .disabled(!isAssetValid)
                    .alert("User is already availble", isPresented: $isEnteredUserValide) {
                        Button("OK"){}
                    }
                    .alert("Please enter valide EmailID", isPresented: $isEnteredEmailValide) {
                        Button("OK"){}
                    }
                    .alert("Successfully Registered", isPresented: $isRegSuccess) {
                        Button("OK"){
                            
                        }
                    }
                }
                .padding()
                Spacer()
        }
        
        func isUserValide()->Bool {
            return UserDataClass.shared.isUserValide(email_id: userName, password: password)
        }
        func passwordCompare()->Bool {
            if(password == re_password) {
            
                return true
            }
            return false
        }
    func isDataStored()->Bool {
        let userData = NSMutableDictionary()
        userData.setValue(emailID, forKey: "mailID")
        userData.setValue(userName, forKey: "name")
        userData.setValue(password, forKey: "password")
        return UserDataClass.shared.registeruser(user: userData)
    }

    }
extension String {
    func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
}
