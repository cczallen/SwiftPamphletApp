//
//  ActiveDeveloperListView.swift
//  PresentSwiftUI
//
//  Created by Ming Dai on 2021/11/11.
//

import SwiftUI

struct ActiveDeveloperListView: View {
    @EnvironmentObject var appVM: AppVM
    @StateObject var vm: IssueVM
    var body: some View {
        
        List {
            
            ForEach(vm.cIADs) { ad in
                Section {
                    ForEach(ad.users) { u in
//                        NavigationLink("\(u.id) \((u.des != nil) ? "(\(u.des!))" : "")", destination: UserView(vm: .init(userName: u.id)))
                        NavigationLink(destination: UserView(vm: .init(userName: u.id))) {
                            if let badgeCount = appVM.devsNotis[u.id] ?? 0 {
                                Text("\(u.id) \((u.des != nil) ? "(\(u.des!))" : "")")
                                    .badge(badgeCount)
                            } else {
                                Text("\(u.id) \((u.des != nil) ? "(\(u.des!))" : "")")
                            }
                        }
                    }
                } header: {
                    Text(ad.name).font(.title)
                }

            }
        }
        .alert(vm.errMsg, isPresented: $vm.errHint, actions: {})
        .navigationTitle("开发者动态 \(appVM.alertMsg)")
        .onAppear {
            vm.doing(.ciads)
        }
        
    }
}

