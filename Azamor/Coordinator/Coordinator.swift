//
//  Coordinator.swift
//  Azamor
//
//  Created by Junaid Rajah on 2021/08/03.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
