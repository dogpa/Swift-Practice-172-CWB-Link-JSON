//
//  ContentView.swift
//  Swift Practice 172 CWB Link JSON
//
//  Created by Dogpa's MBAir M1 on 2022/8/31.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = ConvertViewModel()
    var body: some View {
        Text("Hello, world!")
            .padding()
            .onAppear {
                vm.decodeJSON()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
