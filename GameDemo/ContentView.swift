//
//  ContentView.swift
//  GameDemo
//
//  Created by Anmay Gupta on 1/13/22.
//

import SwiftUI

struct ContentView: View {
    // Properties
    
    let colors: [Color] = [Color("Color1"), Color("Color2")]
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Text("Asteroid")
                        .font(.custom("Chalkduster", size: 32))
                        .foregroundColor(.red)
                        .offset(y: -300)
                    HStack {
                        Image("meteor-brown-big")
                            .resizable()
                            .frame(width: 64, height: 64)
                            .offset(x: 30, y: -170)
                        
                        Image("meteor-brown-big")
                            .resizable()
                            .frame(width: 64, height: 64)
                            .offset(x: 100, y: -100)
                        
                        Image("meteor-brown-big")
                            .resizable()
                            .frame(width: 64, height: 64)
                            .offset(x: -120, y: -50)
                    } // HStack
                    Image("ufo")
                        .resizable()
                        .frame(width: 64, height: 64)
                        .offset(y: 100)
                    
                    NavigationLink(
                        destination: Text("Destination"),
                        label: {
                            Text("Start Game")
                                .font(.custom("Chalkduster", size: 30))
                                .foregroundColor(.red)
                                .offset(y: 150)
                        }
                    )
                } // Stack
            } // ZStack
            .frame(width: 750, height: 1200, alignment: .center)
            .background(LinearGradient(gradient: Gradient(colors: colors), startPoint: .bottom, endPoint: .top))
        } // Navigation View
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
