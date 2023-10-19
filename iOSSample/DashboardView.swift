//
//  DashboardView.swift
//  iOSSample
//
//  Created by Chandra Hasan on 17/10/23.
//
import SwiftUI


struct DashBoardView: View {
    @State var aed_amount : String = ""
    @State var rec_amount : String = ""
    @State private var selectedStrength = "INR"
    @State private var isLoggedIn = true
    @State var location: String = ""
        let strengths = ["INR", "USD"]
    var body: some View {
        Spacer()
        VStack(alignment: .center) {
            HStack {
                Button("AED") {
                    
                }.padding()
                    .border(Color.black)
                TextField("Enter Amount", text: $aed_amount)
                    .keyboardType(.numberPad)
                    .padding()
                    .border(Color.black)
                    .onChange(of: aed_amount) { newValue in
                        self.aedtoOther()
                    }
            }
            HStack {
                Form {
                    Section {
                        Picker("", selection: $selectedStrength) {
                            ForEach(strengths, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(.menu)
                        .onChange(of: selectedStrength) { newValue in
                            self.aedtoOther()
                        }
                    }
                }.frame(width: 150,height: 100,alignment: .leading)
                TextField("Enter Amount in "+selectedStrength, text: $rec_amount)
                    .padding()
                    .border(Color.black)
                    .keyboardType(.numberPad)
                    .onChange(of: rec_amount) { newValue in
                        
                    }
            }
            Button("Logout") {
                UserDefaults.standard.setValue(false, forKey: "isLogin")
                if let window = UIApplication.shared.windows.first {
                    window.rootViewController = UIHostingController(rootView: ContentView().preferredColorScheme(.light))
                    window.makeKeyAndVisible()
                }
            }
        }
        .padding(.all, 10.0)
        Spacer()
    }
    func aedtoOther(){
        if(selectedStrength == "INR") {
            let aed_inr = 22.66
            if(aed_amount.count > 0){
                let ent_currency: Double = Double(aed_amount)!
                let final_amt = ent_currency * aed_inr
                rec_amount = "\(final_amt)"
            } else {
                rec_amount = ""
            }
        } else if(selectedStrength == "USD") {
            let aed_usd = 0.27
            if(aed_amount.count > 0){
                let ent_currency: Double = Double(aed_amount)!
                let final_amt = ent_currency * aed_usd
                rec_amount = "\(final_amt)"
            } else {
                rec_amount = ""
            }
        }
    }
    
    func othersToAed() {
        if(selectedStrength == "INR") {
            let aed = 0.044
            if(rec_amount.count > 0){
                let rec_currency: Double = Double(rec_amount)!
                let final_amt = rec_currency * aed
                aed_amount = "\(final_amt)"
            } else {
                aed_amount = ""
            }
        } else if(selectedStrength == "USD") {
            let aed = 3.67
            if(rec_amount.count > 0){
                let rec_currency: Double = Double(rec_amount)!
                let final_amt = rec_currency * aed
                aed_amount = "\(final_amt)"
            } else {
                aed_amount = ""
            }
        }
    }
}
