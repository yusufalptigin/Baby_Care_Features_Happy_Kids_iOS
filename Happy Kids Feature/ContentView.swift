//
//  ContentView.swift
//  Happy Kids Feature
//
//  Created by Yusuf Alp Tigin Gün on 6.02.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {        
        NavigationView{
            NavigationLink(destination: Baby_Care()){ Text("Bebek Bakımı") }
        }.navigationViewStyle(.stack)
    }
}


