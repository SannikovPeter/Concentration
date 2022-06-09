//
//  ConcentrationThemeChooserViewController.swift
//  Concentration
//
//  Created by Пётр Санников on 1.06.22.
//

import UIKit

class ConcentrationThemeChooserViewController: UIViewController {
    
    let themes = [
        "Sports":"⚽️🏀🏈⚾️🏐🎱🏓⛸🏒⛷🥋",
        "Animals":"🐶🐭🐰🦊🐯🐮🐷🐸🐵🦆🦉",
        "Faces":"😀🥹😅😇🤣😍🥸🥳😡🤯😎🥴"
    ]
        
    @IBAction func changeTheme(_ sender: Any) {
        performSegue(withIdentifier: "Choose Theme", sender: sender)
    
    }
    
    private var splitViewDetailConcentrationController: ConcentrationViewController? {
        let navController = splitViewController?.viewControllers.last as? UINavigationController
        return navController?.viewControllers.first as? ConcentrationViewController
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                if let cvc = segue.destination as? ConcentrationViewController {
                    cvc.theme = theme
                }
            }
        }
    }
}
