//
//  ViewController.swift
//  LocalizationDemo
//
//  Created by Piyush Sinroja on 12/03/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        lbl.text = "mylanguage".localizableString(isDeviceSettingLanguage: false)
    }

    @IBAction func changeLanguageAction(_ sender: Any) {
        StorageService.shared.preferedLanguage = LanguageCode.ru.rawValue
        setRootVC()
    }
    
    func setRootVC() {
        // Done to reinstantiate the storyboards instantly
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        UIApplication.shared.keyWindow?.rootViewController = storyboard.instantiateInitialViewController()
    }
}

extension String {
    func localizableString(isDeviceSettingLanguage: Bool) -> String {
        if isDeviceSettingLanguage {
            return NSLocalizedString(self, comment: "")
        } else {
            let languageCode = PreferredLanguage.language
            guard let path = Bundle.main.path(forResource: languageCode, ofType: "lproj"), let bundle = Bundle(path: path) else { return "" }
            return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
        }
    }

}
enum LanguageCode: String {
    case eng = "en"
    case fr = "fr"
    case ja = "ja"
    case ru = "ru"
}
struct PreferredLanguage {
    ///
    static var language: String {
        if let language = StorageService.shared.preferedLanguage {
            switch language {
                case LanguageCode.eng.rawValue:
                    return LanguageCode.eng.rawValue
                case LanguageCode.fr.rawValue:
                    return LanguageCode.fr.rawValue
                case LanguageCode.ja.rawValue:
                    return LanguageCode.ja.rawValue
                case LanguageCode.ru.rawValue:
                    return LanguageCode.ru.rawValue
                default:
                    return LanguageCode.eng.rawValue
            }
        }
        return LanguageCode.eng.rawValue
    }
}


class StorageService {

    // MARK: - Variables

    /// sharing class Preference
    static let shared = StorageService()

    ///  interface for interacting with the defaults system
    let userdefault = UserDefaults.standard

    ///
    var preferedLanguage: String? {
        get {
            return userdefault.value(forKey: UserDefaults.DefaultKeys.language) as? String
        }
        set {
            if let stadium = newValue {
                userdefault.set(stadium, forKey: UserDefaults.DefaultKeys.language)
            } else {
                userdefault.removeObject(forKey: UserDefaults.DefaultKeys.language)
            }
            userdefault.synchronize()
        }
    }
}

// MARK: - UserDefaults Extension
extension UserDefaults {
    // MARK: - DefaultKeys Name
    struct DefaultKeys {
        ///
        static let language = "language"
    }
}
