import AudioKit
import SwiftUI
import Observation

struct EditorView: View {
  
  @State var midiFile: MIDIFile
  @State var currentTrack: MIDITrack

  var body: some View {

    NavigationSplitView() {
      Text(midiFile.name)
                  
      List(midiFile.tracks) { track in
         
        Button {
          currentTrack = track
        } label: {
            Text(track.name)
            .frame(maxWidth: .infinity, minHeight: 70)
        }
        .buttonStyle(.borderless)
        
      }
      .listStyle(.plain)

    } detail: {
      MIDITrackView(track: $currentTrack)
    }
    
  }
    
}

