//
//  MIDIFile.swift
//  MIDINA
//
//  Created by Damir Minnegalimov on 29.06.2023.
//

import Foundation
import Observation
import AudioKit

// Since AudioKit classes and MIDI itself is overkill, I want much simplier data structures

@Observable
struct MIDIFile: Identifiable {
  var id = UUID()

  var name: String = "No name"
  var tracks: [MIDITrack] = []
  
  init(from midiFile: AudioKit.MIDIFile) {
    self.name = midiFile.filename
    
//    print("---------------------")
//    print("New import file, \(midiFile.filename)")

    for (index, track) in midiFile.tracks.enumerated() {
      var newTrack = MIDITrack()
      newTrack.lengthInBeats = track.length
      
//      print("track.length, \(track.length)")

      if let newName = track.name {
        newTrack.name = newName
      }
      
      let noteMap = MIDIFileTrackNoteMap(midiFile: midiFile, trackNumber: index)

      newTrack.notes = noteMap.noteList.map { midiNoteDuration in
        var newNote = MIDINote()
        
        newNote.startTime = midiNoteDuration.noteStartTime
        newNote.endTime = midiNoteDuration.noteEndTime
        newNote.noteNumber = midiNoteDuration.noteNumber
        
        return newNote
      }
      
//      print("newTrack.notes.count, \(newTrack.notes.count)")
      
      if newTrack.notes.count > 0 {
        tracks.append(newTrack)
      }
    }
  }

}
