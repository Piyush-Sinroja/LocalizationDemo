//
//  ViewController.swift
//  LocalizationDemo
//
//  Created by Piyush Sinroja on 12/03/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        lbl.text = String.LocalizableTable1("mylanguage", isDeviceSettingLanguage: true)
        lblDescription.text = String.LocalizableTable2("FromTable2", isDeviceSettingLanguage: false)
    }

    @IBAction func changeLanguageAction(_ sender: Any) {
        StorageService.shared.preferedLanguage = LanguageCode.fr.rawValue
        setRootVC()
    }
    
    func setRootVC() {
        // Done to reinstantiate the storyboards instantly
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        UIApplication.shared.keyWindow?.rootViewController = storyboard.instantiateInitialViewController()
    }
}

extension String {
    static func LocalizableTable1(_ key: String, isDeviceSettingLanguage: Bool) -> String {
        return localized(isDeviceSettingLanguage: isDeviceSettingLanguage, key: key, table: "LocalizableTable1", bundle: .main)
    }

    static func LocalizableTable2(_ key: String, isDeviceSettingLanguage: Bool) -> String {
        return localized(isDeviceSettingLanguage: isDeviceSettingLanguage, key: key, table: "LocalizableTable2", bundle: .main)
    }

    private static func localized(isDeviceSettingLanguage: Bool, key: String, table: String, bundle: Bundle) -> String {
        if isDeviceSettingLanguage {
            return bundle.localizedString(forKey: key, value: nil, table: table)
        } else {
            let languageCode = PreferredLanguage.language
            guard let path = Bundle.main.path(forResource: languageCode, ofType: "lproj"),
                  let myBundle = Bundle(path: path) else {
                return ""
            }
            return myBundle.localizedString(forKey: key, value: nil, table: table)
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
