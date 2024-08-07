//
//  AccountView.swift
//  daweiba
//
//  Created by 潘建勋 on 2024-07-27.
//

import SwiftUI

#if !os(macOS)
import UIKit
#endif

struct AccountView: View {
            
    @State var acnt: Account
    
    @State var showPassword: Bool = false
    
    var body: some View {
        
        NavigationStack {
            
            Form {
                
                Section(header: Text("Title")) {
                    if showPassword {
                        TextField("Title", text: $acnt.title)
                            .foregroundStyle(.secondary)
                            .autocorrectionDisabled()
                            .onSubmit { acnt.lastUpdated = Date() }
                            #if !os(macOS)
                            .textInputAutocapitalization(.never)
                            .onTapGesture {
                                UIPasteboard.general.string = acnt.password
                            }
                            #endif
                    } else {
                        Text(acnt.title)
                    }
                }
                
                Section(header: Text("Account")) {
                    
                    if showPassword {
                        TextField("Username", text: $acnt.username)
                            .foregroundStyle(.secondary)
                            .autocorrectionDisabled()
                            .onSubmit { acnt.lastUpdated = Date() }
                            #if !os(macOS)
                            .textInputAutocapitalization(.never)
                            #endif
                        
                        TextField("Password", text: $acnt.password)
                            .foregroundStyle(.secondary)
                            .autocorrectionDisabled()
                            .onSubmit { acnt.lastUpdated = Date() }
                            #if !os(macOS)
                            .textInputAutocapitalization(.never)
                            .onTapGesture {
                                UIPasteboard.general.string = acnt.password
                            }
                            #endif
                } else {
                        HStack {
                            Text("Username")
                            Spacer()
                            Text("\(acnt.username)")
                                .foregroundStyle(.secondary)
                                .multilineTextAlignment(.trailing)
#if !os(macOS)
                                .onTapGesture {
                                    UIPasteboard.general.string = acnt.username
                                }
#endif
                        }
                        HStack {
                            Text("Password")
                            Spacer()
                            Text("********")
                                .foregroundStyle(.secondary)
                                .multilineTextAlignment(.trailing)
                        }
                    }
                }
                
                Section(header: Text("Properties")) {
                    
                    if showPassword {
                        TextField("Server", text: $acnt.server)
                            .foregroundStyle(.secondary)
                            .autocorrectionDisabled()
                            .textCase(.lowercase)
                            #if !os(macOS)
                            .textInputAutocapitalization(.never)
                            .keyboardType(.URL)
                            .onTapGesture {
                                UIPasteboard.general.string = acnt.server.lowercased()
                            }
                            #endif
                            .onSubmit {
                                acnt.server = acnt.server.lowercased()
                                acnt.lastUpdated = Date()
                            }
                    } else {
                        HStack {
                            Text("Server")
                            Spacer()
                            Text(acnt.server)
                                .foregroundStyle(.secondary)
                                .multilineTextAlignment(.trailing)
                                .textCase(.lowercase)
                                #if !os(macOS)
                                .onTapGesture {
                                    UIPasteboard.general.string = acnt.server
                                }
                                #endif
                        }
                    }
                    
                    HStack {
                        Text("Last Updated")
                        Spacer()
                        Text("\(acnt.lastUpdated, format: Date.FormatStyle(date: .numeric, time: .standard))")
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.trailing)
                    }
                    #if !os(macOS)
                    .onTapGesture {
                        UIPasteboard.general.string = acnt.lastUpdated.description
                    }
                    #endif
                    infoListView(entries: $acnt.info, lastUpdated: $acnt.lastUpdated, showPassword: $showPassword)
                }
                
                Section(header: Text("Description")) {
                    TextEditor(text: $acnt.descr)
                        .border(Color.gray)
                        .frame(minHeight: 50)
                        .padding()
                }
            }
            
        }
        .navigationTitle(acnt.title)
        .toolbar {
        
            if showPassword {
                Button {
                    acnt.lastUpdated = Date()
                    acnt.info.append(InfoEntry())
                } label: {
                    Label("Add", systemImage: "plus")
                }
            }
            
            Button {
                showPassword.toggle()
            } label: {
                Label("lock", systemImage: showPassword ? "eye" : "lock")
            }
            
            
        }
        
        
    }
    
}


#Preview {
    AccountView(acnt: Account())
}
