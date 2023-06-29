//
//  MIDINote.swift
//  MIDINA
//
//  Created by Damir Minnegalimov on 29.06.2023.
//

import Foundation
import Observation

// Since AudioKit classes and MIDI itself is overkill, I want much simplier data structures

@Observable
struct MIDINote: Identifiable {
  var id = UUID()

  var startTime: Double = 0
  var endTime: Double = 0
  
  // Like C5 or D2, but Int between 0 and 127
  var noteNumber: Int = 0
  
  static func == (lhs: MIDINote, rhs: MIDINote) -> Bool {
    return lhs.startTime == rhs.startTime
    && lhs.endTime == rhs.endTime
    && lhs.noteNumber == rhs.noteNumber
  }
}
