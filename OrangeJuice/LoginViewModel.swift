//
//  LoginViewModel.swift
//  OrangeJuice
//
//  Created by Haruta Yamada on 2021/04/23.
//

import Foundation
import Combine
import FirebaseAuth

class LoginViewModel: ObservableObject {
    @Published var isProcessing: Bool = false
    @Published var error: String? = nil
    private let auth = Auth.auth()
    func request(email: String, password: String, method: AuthMethod) {
        isProcessing = true
        switch method {
        case .login:
            auth.signIn(withEmail: email, password: password)
                { [weak self] (result, error) in
                    self?.resultHandler(result: result, error:error)
                }
        case .register:
            auth.createUser(withEmail: email, password: password)
                { [weak self] (result, error) in
                    self?.resultHandler(result: result, error:error)
                }
        }
    }
    func resultHandler(result: AuthDataResult?, error: Error?) {
        isProcessing = false
        guard let error = error as NSError?, let errorCode = error.userInfo["FIRAuthErrorUserInfoNameKey"] as? String else { return }
        self.error = errorText(code: errorCode)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.error = nil
        }
    }
    
    func errorText(code: String) -> String {
        switch code {
        case "FIRAuthErrorCodeOperationNotAllowed":
            //Todo
            return "予期せぬエラーが発生しました時間を空けて再度お試しください"
        case "FIRAuthErrorCodeUserDisabled":
            return "ユーザーが存在しない、もしくは無効化されています"
        case "FIRAuthErrorCodeWrongPassword":
            return "パスワードが一致しません"
        case "FIRAuthErrorCodeInvalidEmail":
            return "不正なメールアドレスです"
        case "FIRAuthErrorCodeEmailAlreadyInUse":
            return "既にこのメールアドレスは使用されています"
        case "FIRAuthErrorCodeWeakPassword":
            return "パスワードが脆弱です"
        default:
            return "予期せぬエラーが発生しました時間を空けて再度お試しください"
        }
    }
}
