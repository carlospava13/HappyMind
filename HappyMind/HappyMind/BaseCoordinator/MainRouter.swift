//
//  MainRouter.swift
//  HappyMind
//
//  Created by Carlos Pava on 1/10/20.
//  Copyright © 2020 Carlos Pava. All rights reserved.
//

import UIKit

final class MainRouter: NSObject, RouterType {
    // MARK: - Properties
    private var completions: [UIViewController: () -> Void]

    public var rootViewController: UIViewController? {
        return navigationController.viewControllers.first
    }

    public var hasRootController: Bool {
        return rootViewController != nil
    }

    public let navigationController: UINavigationController
    private var transition: UIViewControllerAnimatedTransitioning?

    // MARK: - Initializer
    public init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
        completions = [:]
        super.init()
        self.navigationController.delegate = self
    }

    // MARK: - RouterType
    func present(_ module: Presentable) {
        present(module, animated: true)
    }

    func present(_ module: Presentable, animated: Bool) {
        makePresent(with: module.toPresent(), animated: animated)
    }
    
    func present(_ viewController: UIViewController, animated: Bool) {
        viewController.modalTransitionStyle = .crossDissolve
        viewController.modalPresentationStyle = .overCurrentContext
        makePresent(with: viewController, animated: true)
    }

    private func makePresent(
        with controller: UIViewController,
        animated: Bool) {
        controller.modalPresentationStyle = .fullScreen
        let presentingViewController: UIViewController

        if let presentedViewController = navigationController.presentedViewController {
            presentingViewController = presentedViewController
        } else {
            presentingViewController = navigationController
        }

        presentingViewController.present(
            controller,
            animated: animated,
            completion: nil)
    }

    func push(
        _ module: Presentable,
        transition: UIViewControllerAnimatedTransitioning? = nil,
        animated: Bool,
        completion: (() -> Void)?) {
        self.transition = transition
        let controller = module.toPresent()

        guard controller is UINavigationController == false else {
            assertionFailure("Deprecated push UINavigationController.")
            return
        }

        if let completion = completion {
            completions[controller] = completion
        }

        makePush(
            with: module.toPresent(),
            animated: animated)
    }

    private func makePush(
        with controller: UIViewController,
        animated: Bool) {
        navigationController.pushViewController(
            controller,
            animated: animated)
    }

    func popModule() {
        popModule(transition: nil, animated: true)
    }

    func popModule(
        transition: UIViewControllerAnimatedTransitioning?,
        animated: Bool) {
        self.transition = transition
        if let controller = navigationController.popViewController(animated: animated) {
            runCompletion(for: controller)
        }
    }

    func dismissModule(animated: Bool = true, completion: (() -> Void)? = nil) {
        navigationController.dismiss(animated: animated, completion: completion)
    }

    func setRootModule(_ module: Presentable) {
        setRootModule(module, hideBar: false)
    }

    func setRootModule(
        _ module: Presentable,
        hideBar: Bool, animated: Bool = false) {
        completions.forEach { $0.value() }
        navigationController.setViewControllers([module.toPresent()], animated: animated)
        navigationController.isNavigationBarHidden = hideBar
    }

    func popToRootModule(animated: Bool) {
        if let controllers = navigationController.popToRootViewController(animated: animated) {
            controllers.forEach { controller in
                self.runCompletion(for: controller)
            }
        }
    }

    func hideNavigationBar() {
        navigationController.isNavigationBarHidden = true
    }

    func showNavigationBar() {
        navigationController.isNavigationBarHidden = false
    }

    // MARK: - Presentable
    func toPresent() -> UIViewController {
        return navigationController
    }

    // MARK: - Private methods
    fileprivate func runCompletion(for controller: UIViewController) {
        guard let completion = completions[controller] else { return }
        completion()
        completions.removeValue(forKey: controller)
    }
}

// MARK: - UINavigationControllerDelegate
extension MainRouter: UINavigationControllerDelegate {
    func navigationController(
        _ navigationController: UINavigationController,
        animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return transition
    }

    func navigationController(
        _ navigationController: UINavigationController,
        didShow viewController: UIViewController,
        animated: Bool) {
        guard let poppedViewController = navigationController.transitionCoordinator?.viewController(forKey: .from),
            !navigationController.viewControllers.contains(poppedViewController) else {
                return
        }

        runCompletion(for: poppedViewController)
    }
}
