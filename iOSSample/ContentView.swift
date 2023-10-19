//
//  ContentView.swift
//  iOSSample
//
//  Created by Chandra Hasan on 17/10/23.
//

import SwiftUI

struct ContentView: View {
   
    var body: some View {
        Spacer()
        NavigationView {
            VStack(alignment: .center) {
                Label("Introduction", image: "")
                Label("A currency exchange is a licensed business that allows customers to exchange one currency for another. Currency exchange of physical money (coins and paper bills) is usually done over the counter at a teller station, which can be found in various places such as airports, banks, hotels, and resorts.",image: "")
                NavigationLink("LOGIN", destination: LoginView())
            }
        }
        .padding()
        Spacer()
    }
}
