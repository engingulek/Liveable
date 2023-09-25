//
//  ProfileView.swift
//  Liveable
//
//  Created by engin gülek on 24.09.2023.
//

import SwiftUI

struct ProfileView: View {
    @State private var toLoginView: Bool = false
    var body: some View {
            VStack {
                HStack {
                    VStack(alignment: .leading,spacing: 5) {
                        Text("Your Profile")
                            .font(.title)
                            .fontWeight(.semibold)
                        Text("Sign in to plan your trip")
                            .font(.title3)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                }.padding()
                
                Button {
                    toLoginView = true
                } label: {
                    Text("Button")
                        .foregroundColor(.white)
                        .padding()
                        .font(.title3)
                        .frame(width: UIScreen.main.bounds.width / 1.5)
                        .background(Color.pink )
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                
            }.fullScreenCover(isPresented: $toLoginView) {
                LoginView()
            }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
