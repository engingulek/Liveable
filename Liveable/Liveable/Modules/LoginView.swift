//
//  LoginView.swift
//  Liveable
//
//  Created by engin gülek on 25.09.2023.
//

import SwiftUI

struct LoginView: View {
    @State var phoneNumber : String = ""
    @State var email : String = ""
    @State var selectType : Bool = true
    @State var buttonState : Bool = false
    @State var logType:Bool = true
    @Environment(\.dismiss) var dismiss
   
    var body: some View {
        VStack {
            header
            if logType {
                byEmail
            }else{
                byPhoneNumber
            }
         
           
            Text("or")
            HStack {
                Image(systemName: logType ? "envelope" : "apps.iphone")
                Text(logType ? "by email"  : "by Phone")
                    .fontWeight(.semibold)
            }
            .padding()
            .frame(width: UIScreen.main.bounds.width / 1.2)
            .border(.gray,width: 2)
            .cornerRadius(5)
            .onTapGesture {
                logType.toggle()
            }
            
            
            Spacer()
        }
    
    }
}
// MARK: IU Companent(s)
extension LoginView {
    private var header : some View {
        VStack {
            HStack {
                Image(systemName: "multiply")
                    .font(.title)
                    .onTapGesture {
                        dismiss()
                    }
                Spacer()
            }.padding()
            Text("Log in or Sign up to Liveable")
                .font(.title2)
                .fontWeight(.semibold)
        }
        .padding(.vertical)
    }
    
    private var byPhoneNumber : some View {
        VStack {
            VStack(spacing:0) {
                /// phone code
                HStack {
                    VStack(spacing:5){
                        Text("Country/Region")
                            .font(.callout)
                            .foregroundColor(.gray)
                            .fontWeight(.regular)
                        Text("Türkiye(+80)")
                            .font(.title3)
                    }
                    Spacer()
                    Image(systemName: "chevron.down")
                }.padding()
                    .border(selectType ? .black :  .gray,width: 2)
                    .cornerRadius(5)
                    .onTapGesture {
                        withAnimation {
                            selectType = true
                        }
                        
                    }
                /// phone number
                HStack {
                    VStack(spacing:5){
                        HStack {
                            Text("Phone Number")
                                .font(.callout)
                                .foregroundColor(.gray)
                                .fontWeight(.regular)
                            Spacer()
                        }
                        TextField("", text: $phoneNumber)
                            .font(.title3)
                    }
                    Spacer()
                    Image(systemName: "checkmark")
                }
                .padding()
                .border(!selectType ? .black : .gray,width: 2)
                .cornerRadius(5)
                .onTapGesture {
                    withAnimation {
                        selectType = false
                    }
                }
                
            }.padding()
            
            Button {
                // action
            } label: {
                Text("Button")
                    .padding()
                    .font(.title3)
                    .frame(width: UIScreen.main.bounds.width / 1.5)
                    .background(buttonState ?Color.pink : Color.pink.opacity(0.5))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    
                    
            }
            .disabled(buttonState)
            .foregroundColor(.white)
        }
    }
    
    private var byEmail : some View {
        VStack {
            VStack(spacing:0){
                        HStack {
                            Text("E-mail")
                                .font(.callout)
                                .foregroundColor(.gray)
                                .fontWeight(.regular)
                            Spacer()
                        }
                        TextField("", text: $email)
                            .font(.title3)
                    }
                    .padding(10)
                .border( .gray,width: 2)
                .cornerRadius(5)
                .padding()
            
            Button {
                // action
            } label: {
                Text("Button")
                    .padding()
                    .font(.title3)
                    .frame(width: UIScreen.main.bounds.width / 1.5)
                    .background(Color.pink )
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            .foregroundColor(.white)
        }
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
