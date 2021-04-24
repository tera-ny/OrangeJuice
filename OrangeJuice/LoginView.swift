//
//  LoginView.swift
//  OrangeJuice
//
//  Created by Haruta Yamada on 2021/04/23.
//

import SwiftUI

enum AuthMethod {
    case login
    case register
}

struct LoginView: View {
    @State var isSecurePassword: Bool = true
    @State var password: String = ""
    @State var email: String = ""
    @State var method: AuthMethod = .login
    @ObservedObject var viewModel = LoginViewModel()
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                Image("Icon")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                VStack {
                    Text("Orange Juiceのサービスを利用するには")
                    Text(secondaryText)
                }
                    .multilineTextAlignment(.center)
                    .font(.system(size: 14))
                VStack(spacing: 10) {
                    if let error = viewModel.error {
                        Text(error)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.leading)
                            .font(.system(size: 12))
                            .animation(.easeInOut)
                    }
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    ZStack {
                        if isSecurePassword {
                            SecureField("Password", text: $password)
                        } else {
                            TextField("Password", text: $password)
                        }
                    }
                        .disableAutocorrection(true)
                        .keyboardType(.alphabet)
                        .frame(height: 24)
                    HStack {
                        Spacer()
                        Button(action: {
                            isSecurePassword.toggle()
                        }, label: {
                            Text(isSecurePassword ? "パスワードを表示する" : "パスワードを非表示にする")
                                .font(.system(size: 12))
                        })
                            .padding(.top, 5)
                            .padding(.bottom, 10)
                    }
                    Button(action: {
                        viewModel.request(email: email, password: password, method: method)
                    }, label: {
                        Text(buttonLabel)
                            .bold()
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .foregroundColor(.orange)
                            .border(Color.orange, width: 4)
                    })
                    Button(action: toggleEvent, label: {
                        Text(toggleButtonLabel)
                            .font(.system(size: 14))
                            .underline()
                    })
                    .padding(.top, 10)
                }
                .frame(maxWidth: 300)
            }
            .frame(maxWidth: .infinity)
            if viewModel.isProcessing {
                Color(.displayP3, white: 0.3, opacity: 0.8).ignoresSafeArea()
                VStack {
                    ActivityIndicator(isAnimating: .constant(true), style: .large, color: .white)
                    Text("\(loadingLabelKeyword)...")
                        .foregroundColor(.white)
                }
            }
        }
    }
    
    private var secondaryText: String {
        switch method {
        case .login:
            return "ログインする必要があります"
        case .register:
            return "アカウントを作成する必要があります"
        }
    }
    
    private var buttonLabel: String {
        switch method {
        case .login:
            return "Login"
        case .register:
            return "アカウント登録"
        }
    }
    
    private var toggleButtonLabel: String {
        switch method {
        case .login:
            return "初めての方はこちら"
        case .register:
            return "既にアカウント作成している方はこちら"
        }
    }
    
    private var loadingLabelKeyword: String {
        switch method {
        case .login:
            return "ログイン"
        case .register:
            return "ユーザー作成"
        }
    }
    
    private func toggleEvent() {
        password = ""
        email = ""
        switch method {
        case .login:
            self.method = .register
        case .register:
            self.method = .login
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
