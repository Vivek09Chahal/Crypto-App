//
//  settingView.swift
//  Crypto App
//
//  Created by Vivek Chahal on 4/2/25.
//

import SwiftUI

struct profileView: View {
    
    @Environment(\.dismiss) var dismiss
    let resumeLink: String = "https://www.linkedin.com/in/vivekchahal09/overlay/1743580329330/single-media-viewer/?profileId=ACoAADwb71oBvOa-pakE5sMIzpzflsPeeiQqAY8"
    
    var body: some View {
        NavigationStack{
            VStack{
                resumeSection()
                Spacer()
            }
            .navigationTitle("Setting")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    XMarkButton()
                }
            }
        }
    }
}

struct profileView_Previews: PreviewProvider {
    static var previews: some View {
        profileView()
    }
}

extension profileView{
    
    private func XMarkButton() -> some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark")
        }
    }
    
    private func developedBy() -> some View {
        Section {
            //
        } header: {
            Text("Developed By Vivek")
        }
    }
    
    private func resumeSection() -> some View {
        VStack{
            HStack{
                Image("personal")
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 100, height: 100)
                    .padding()
                
                VStack(alignment: .leading){
                    Text("Vivek")
                    Text("B.Tech in CSE")
                    Text("3rd Year Student")
                }
            }
            
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 300, height: 50)
                .foregroundColor(.white)
                .overlay(
                    Link("Resume", destination: URL(string: resumeLink)!)
                        .font(.title2.bold())
                        .foregroundColor(.blue)
                )
            
            
        }
    }
}
