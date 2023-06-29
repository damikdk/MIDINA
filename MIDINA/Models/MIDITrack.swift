//
//  MIDITrack.swift
//  MIDINA
//
//  Created by Damir Minnegalimov on 29.06.2023.
//

import Foundation
import Observation

// Since AudioKit classes and MIDI itself is overkill, I want much simplier data structures

@Observable
struct MIDITrack: Identifiable {
  var id = UUID()

  var notes: [MIDINote] = []
  var duration: Double = 0
  var name: String = "No name"
  var lengthInBeats: Double = 0
}
