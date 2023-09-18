//
//  MainViewController.swift
//  FormallyAPI
//
//  Created by imac-2437 on 2023/8/16.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        Task {
            let requset = WeatherRequest(Authorization: "CWB-C1F1124A-2966-4D8B-9E96-BCDECED47A0E",
                                         locationName: "臺中市")
            do {
                let result: WeatherResponse = try await requestData(method: .get, path: .hour36, parameters: requset)
            } catch {
                print(error)
            }
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
