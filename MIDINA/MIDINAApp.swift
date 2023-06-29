//
//  MIDINAApp.swift
//  MIDINA
//
//  Created by Damir Minnegalimov on 20.12.2022.
//

import SwiftUI
import AudioKit

let demoMIDIURL = Bundle.main.url(forResource: "toto-africa", withExtension: "mid")
let demoMidiFile = AudioKit.MIDIFile(url: demoMIDIURL!)

@main
struct MIDINAApp: App {

  var body: some Scene {
      WindowGroup {
        let midiFile = MIDIFile(from: demoMidiFile)
        
        EditorView(
          midiFile: midiFile,
          currentTrack: midiFile.tracks.first!
        )
      }
  }
  
}
