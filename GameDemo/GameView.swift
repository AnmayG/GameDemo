//
//  GameView.swift
//  GameDemo
//
//  Created by Anmay Gupta on 1/13/22.
//

import SwiftUI
import SpriteKit

struct GameView: View {
    // Properties
    var body: some View {
        SpriteView(scene: GameScene(size: CGSize(width: 750, height: 1335)))
            .ignoresSafeArea()
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
