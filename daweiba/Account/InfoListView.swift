//
//  InfoListView.swift
//  daweiba
//
//  Created by 潘建勋 on 2024-07-28.
//

import Foundation
import SwiftUI
#if !os(macOS)
import UIKit
#endif

struct infoListView: View {
    
    @Binding var entries: [InfoEntry]
    
    @Binding var lastUpdated: Date
    
    @Binding var showPassword: Bool
    
    var body: some View {
        if showPassword {
            List {
                ForEach($entries, id: \.self.id) { iEntry in
                    HStack {
                        TextField("Key", text: iEntry.key)
                            .onSubmit { lastUpdated = Date() }
                            .autocorrectionDisabled()
                        Spacer()
                        TextField("Value", text: iEntry.value)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.trailing)
                            .onSubmit { lastUpdated = Date() }
                            .autocorrectionDisabled()
                            #if !os(macOS)
                            .textInputAutocapitalization(.never)
                            #endif
                    }
                    .id(iEntry.id)
                    #if !os(macOS)
                    .onTapGesture {
                        UIPasteboard.general.string = iEntry.value.wrappedValue
                    }
                    #endif
                }
                .onDelete(perform: self.deleteInfo)
            }
        } else {
            HStack {
                Text("***")
                Spacer()
                Text("*****")
                    .foregroundStyle(.secondary)
            }
        }
    }
    
    private func deleteInfo(offsets: IndexSet) {
        if showPassword {
            lastUpdated = Date()
            withAnimation {
                entries.remove(atOffsets: offsets)
            }
        }
    }
    
}
