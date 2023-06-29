//
//  MIDITrackView.swift
//  MIDINA
//
//  Created by Damir Minnegalimov on 21.06.2023.
//

import SwiftUI
import AudioKit
import Keyboard
import Charts


// 0...127 is MIDI standart
let keyboardStartNode: Int = 0
let keyboardEndNode: Int = 127
let keyboardPitchRange = Pitch(intValue: keyboardStartNode) ... Pitch(intValue: keyboardEndNode)
let keyboardLength: Int = keyboardEndNode - keyboardStartNode

let keyboardNodeSize: Int = 20
let keyboardSize: Double = Double(keyboardLength) * Double(keyboardNodeSize)

let beatSize: Double = 30.0


struct MIDITrackView: View {

  @Binding var track: MIDITrack
  
  @ViewBuilder
  func pianoRoll() -> some View {
    VStack {
      HStack{
        Keyboard(
          layout: .verticalPiano(pitchRange: keyboardPitchRange),
          noteOn: { _, _ in },
          noteOff: { _ in }
        )
        .frame(minWidth: 20, idealWidth: 50, maxWidth: 50, minHeight: keyboardSize)
      }
    }
  }
  
  var body: some View {

    ScrollView([.horizontal, .vertical]) {

      // Hack to pin piano roll keyboard to the left
      
      LazyHStack(pinnedViews: [.sectionHeaders]) {
        Section(header: pianoRoll()) {
                        
            Chart(track.notes) { note in
              let _ = print(track.lengthInBeats)
              
                BarMark(
                  xStart: .value("note start", note.startTime),
                  xEnd: .value("note end", note.endTime),
                  // TODO: I don't know how to center it right way
                  y: .value("note number", Double(note.noteNumber) - 0.5),
                  height: MarkDimension(integerLiteral: keyboardNodeSize)
                )
                .clipShape(RoundedRectangle(cornerRadius: 3, style: .continuous))
              
            }
            .chartYAxis {
              AxisMarks(
                values: .automatic(
                  desiredCount: keyboardLength
                )
              ) { value in
                AxisGridLine()
              }
            }
            .chartXAxis {
              AxisMarks(
                values: .automatic(
                  desiredCount: Int(track.lengthInBeats)
                )
              ) { value in
                if value.index % 4 == 0 {
                    AxisGridLine(stroke: StrokeStyle(lineWidth: 1))
                } else {
                    AxisGridLine()
                }
              }
            }
            .chartXScale(domain: 0...1)
            .chartYScale(domain: keyboardStartNode...keyboardEndNode)
            .frame(
              width: beatSize * track.lengthInBeats,
              height: keyboardSize
            )
          
        } // Section
        
      } // HStack
      
    } // ScrollView

  }

}
