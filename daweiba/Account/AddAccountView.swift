//
//  AddAccountView.swift
//  daweiba
//
//  Created by 潘建勋 on 2024-08-02.
//

import Foundation
import SwiftUI
import SwiftData

#if !os(macOS)
import UIKit
#endif

struct AddAccountView: View {
        
    @Environment(\.modelContext) private var modelContext
    
    @State var acnt: Account
        
    var body: some View {
        
        AccountView(acnt: acnt)
            .onAppear{
                modelContext.insert(acnt)
            }
        
    }
    
}
