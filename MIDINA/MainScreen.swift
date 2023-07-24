//
//  MainScreen.swift
//  MIDINA
//
//  Created by Damir Minnegalimov on 03.07.2023.
//

import SwiftUI
import SwiftData
import AudioKit

struct MainScreen: View {

  @State var allFiles: [MIDIFile] = []

  var body: some View {
    NavigationView {
      List(allFiles) { midiFile in
        
        NavigationLink {
          EditorView(midiFile: midiFile, currentTrack: midiFile.tracks[0])
        } label: {
          Text(midiFile.name)
            .padding(.vertical)
        }
        
      }
    }
    .onAppear {
      let filePaths = Bundle.main.urls(forResourcesWithExtension: "mid", subdirectory: "")
      let midiFiles = filePaths?.compactMap { filePath in
        
        let audioKitMidiFile = AudioKit.MIDIFile(url: filePath)
        let midifile = MIDIFile(from: audioKitMidiFile)
          
        allFiles.append(midifile)
 
        return midifile
      }
      
    } // onAppear
    
  } // body
  
}
