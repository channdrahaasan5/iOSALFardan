//
//  LoginView.swift
//  iOSSample
//
//  Created by Chandra Hasan on 18/10/23.
//

import SwiftUI

struct LoginView: View {
    @State var userName : String = ""
    @State var password : String = ""
    @State var showLoginView: Bool = false
    @State var isLogin: Bool = false
    @State var isEnteredUserValide: Bool = false
    private var isAssetValid: Bool {
        !userName.isEmpty && !password.isEmpty
    }
    var body: some View {
        Spacer()
        VStack(alignment: .center) {
            Label("LOGIN", image: "")
            TextField("Enter your MailID", text: $userName)
                .padding()
                .border(Color.black)
            SecureField("Enter Password", text: $password)
                .padding()
                .border(Color.black)
                .keyboardType(.numberPad)
            NavigationLink("Registration", destination: RegistrationView())
            Button {
                if(isUserValide()) {
                    UserDefaults.standard.setValue(true, forKey: "isLogin")
                    if let window = UIApplication.shared.windows.first {
                        window.rootViewController = UIHostingController(rootView: DashBoardView().preferredColorScheme(.light))
                        window.makeKeyAndVisible()
                    }
                } else {
                    self.isEnteredUserValide = true
                }
            } label: {
                Text("SUBMIT")
            }
            .padding()
            .border(Color.black)
            .frame(width: 200, height: 50, alignment: .center)
            .disabled(!isAssetValid)
            .alert("Please enter valide details/ Register new user", isPresented: $isEnteredUserValide) {
                Button("OK"){}
            }
        }
        .navigationBarBackButtonHidden()
        .padding()
        Spacer()
    }
    
    func isUserValide()->Bool {
        return UserDataClass.shared.isUserValide(email_id: userName, password: password)
    }
    func clearLoginFlag() {
        UserDefaults.standard.setValue(false, forKey: "isLogin")
    }
}
