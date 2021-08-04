//
//  MainCoordinator.swift
//  Azamor
//
//  Created by Junaid Rajah on 2021/08/03.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.setNavigationBarHidden(true, animated: true)
    }

    func start() {
        let vc = ViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func gameStartButton(vc: ViewController) {
        let destinationVC = MainMenuViewController.instantiate()
        destinationVC.coordinator = self
        destinationVC.aB = vc.aB
        destinationVC.gameLogic = vc.gameLogic
        navigationController.popViewController(animated: false)
        navigationController.pushViewController(destinationVC, animated: true)
        UIView.transition(with: self.navigationController.view, duration: 1.0, options: UIView.AnimationOptions.transitionCrossDissolve, animations: nil, completion: nil)
    }
    
//MARK: - Main Menu Segues
    
    func mainToStory(vc: MainMenuViewController) {
        let destinationVC = StoryTabViewController.instantiate()
        destinationVC.coordinator = self
        destinationVC.currentTrack = vc.currentTrack
        destinationVC.aB = vc.aB
        destinationVC.gameLogic = vc.gameLogic
        navigationController.popViewController(animated: false)
        navigationController.pushViewController(destinationVC, animated: true)
        UIView.transition(with: self.navigationController.view, duration: 1.0, options: UIView.AnimationOptions.transitionCrossDissolve, animations: nil, completion: nil)
    }

    func mainToInventory(vc: MainMenuViewController) {
        let destinationVC = InventoryViewController.instantiate()
        destinationVC.coordinator = self
        destinationVC.isFromMain = true
        destinationVC.aB = vc.aB
        destinationVC.gameLogic = vc.gameLogic
        destinationVC.currentTrack = vc.currentTrack
        navigationController.popViewController(animated: false)
        navigationController.pushViewController(destinationVC, animated: true)
        UIView.transition(with: self.navigationController.view, duration: 1.0, options: UIView.AnimationOptions.transitionCrossDissolve, animations: nil, completion: nil)
    }
    
    func mainToChar(vc: MainMenuViewController) {
        let destinationVC = MyCharacterViewController.instantiate()
        destinationVC.coordinator = self
        destinationVC.aB = vc.aB
        destinationVC.gameLogic = vc.gameLogic
        destinationVC.isFromMain = true
        destinationVC.currentTrack = vc.currentTrack
        navigationController.popViewController(animated: false)
        navigationController.pushViewController(destinationVC, animated: true)
        UIView.transition(with: self.navigationController.view, duration: 1.0, options: UIView.AnimationOptions.transitionCrossDissolve, animations: nil, completion: nil)
    }
    
//MARK: - Story Tab Segues
    
    func storyToDice(vc: StoryTabViewController) {
        let destinationVC = DiceViewController.instantiate()
        destinationVC.coordinator = self
        destinationVC.gameLogic = vc.gameLogic
        destinationVC.currentTrack = vc.currentTrack
        destinationVC.aB = vc.aB
        navigationController.popViewController(animated: false)
        navigationController.pushViewController(destinationVC, animated: true)
        UIView.transition(with: self.navigationController.view, duration: 1.0, options: UIView.AnimationOptions.transitionCrossDissolve, animations: nil, completion: nil)
    }
    
    func storyToEncounter(vc: StoryTabViewController) {
        let destinationVC = EncounterViewController.instantiate()
        destinationVC.coordinator = self
        destinationVC.gameLogic = vc.gameLogic
        //destinationVC.currentStoryTabString = gameLogic.nextStoryTabString!
        destinationVC.isPlayerTurn = true
        //destinationVC.storyTabToReturn = gameLogic.getCurrentST().StoryTabID
        destinationVC.currentTrack = vc.currentTrack
        destinationVC.aB = vc.aB
        navigationController.popViewController(animated: false)
        navigationController.pushViewController(destinationVC, animated: true)
        UIView.transition(with: self.navigationController.view, duration: 1.0, options: UIView.AnimationOptions.transitionCrossDissolve, animations: nil, completion: nil)
    }
    
    func storyToInventory(vc: StoryTabViewController) {
        let destinationVC = InventoryViewController.instantiate()
        destinationVC.coordinator = self
        destinationVC.gameLogic = vc.gameLogic
        destinationVC.isFromStory = true
        destinationVC.currentTrack = vc.currentTrack
        destinationVC.aB = vc.aB
        navigationController.popViewController(animated: false)
        navigationController.pushViewController(destinationVC, animated: true)
        UIView.transition(with: self.navigationController.view, duration: 1.0, options: UIView.AnimationOptions.transitionCrossDissolve, animations: nil, completion: nil)
    }
    
    func storyToSelect(vc: StoryTabViewController) {
        let destinationVC = CharacterSelectViewController.instantiate()
        destinationVC.coordinator = self
        destinationVC.gameLogic = vc.gameLogic
        destinationVC.currentTrack = vc.currentTrack
        destinationVC.aB = vc.aB
        navigationController.popViewController(animated: false)
        navigationController.pushViewController(destinationVC, animated: true)
        UIView.transition(with: self.navigationController.view, duration: 1.0, options: UIView.AnimationOptions.transitionCrossDissolve, animations: nil, completion: nil)
    }
    
    func storyToMain(vc: StoryTabViewController) {
        let destinationVC = MainMenuViewController.instantiate()
        destinationVC.coordinator = self
        destinationVC.gameLogic = vc.gameLogic
        destinationVC.currentTrack = vc.currentTrack!
        destinationVC.aB = vc.aB
        navigationController.popViewController(animated: false)
        navigationController.pushViewController(destinationVC, animated: true)
        UIView.transition(with: self.navigationController.view, duration: 1.0, options: UIView.AnimationOptions.transitionCrossDissolve, animations: nil, completion: nil)
    }
    
    func storyToItems(vc: StoryTabViewController) {
        let destinationVC = ItemViewController.instantiate()
        destinationVC.coordinator = self
        destinationVC.gameLogic = vc.gameLogic
        destinationVC.currentTrack = vc.currentTrack!
        destinationVC.aB = vc.aB
        navigationController.popViewController(animated: false)
        navigationController.pushViewController(destinationVC, animated: true)
        UIView.transition(with: self.navigationController.view, duration: 1.0, options: UIView.AnimationOptions.transitionCrossDissolve, animations: nil, completion: nil)
    }
    
//MARK: - Dice View Segue
    
    func diceToStory(vc: DiceViewController) {
        let destinationVC = StoryTabViewController.instantiate()
        destinationVC.coordinator = self
        destinationVC.gameLogic = vc.gameLogic
        destinationVC.currentTrack = vc.currentTrack
        destinationVC.aB = vc.aB
        navigationController.popViewController(animated: false)
        navigationController.pushViewController(destinationVC, animated: true)
        UIView.transition(with: self.navigationController.view, duration: 1.0, options: UIView.AnimationOptions.transitionCrossDissolve, animations: nil, completion: nil)
    }
    
//MARK: - Encounter View Segues
    
    func encounterToInventory(vc: EncounterViewController) {
        let destinationVC = InventoryViewController.instantiate()
        destinationVC.coordinator = self
        destinationVC.gameLogic = vc.gameLogic
        destinationVC.isPlayerTurn = vc.isPlayerTurn!
        //destinationVC.storyTabToReturn = gameLogic.storyTabToReturn!
        destinationVC.isFromEncounter = true
        destinationVC.currentTrack = vc.currentTrack
        destinationVC.aB = vc.aB
        navigationController.popViewController(animated: false)
        navigationController.pushViewController(destinationVC, animated: true)
        UIView.transition(with: self.navigationController.view, duration: 1.0, options: UIView.AnimationOptions.transitionCrossDissolve, animations: nil, completion: nil)
    }
    
    func encounterToStory(vc: EncounterViewController) {
        let destinationVC = StoryTabViewController.instantiate()
        destinationVC.coordinator = self
        destinationVC.gameLogic = vc.gameLogic
        destinationVC.currentTrack = vc.currentTrack
        destinationVC.aB = vc.aB
        navigationController.popViewController(animated: false)
        navigationController.pushViewController(destinationVC, animated: true)
        UIView.transition(with: self.navigationController.view, duration: 1.0, options: UIView.AnimationOptions.transitionCrossDissolve, animations: nil, completion: nil)
    }

//MARK: - Item View Segue
    
    func itemToStory(vc: ItemViewController) {
        let destinationVC = StoryTabViewController.instantiate()
        destinationVC.coordinator = self
        destinationVC.gameLogic = vc.gameLogic
        destinationVC.currentTrack = vc.currentTrack
        destinationVC.aB = vc.aB
        navigationController.popViewController(animated: false)
        navigationController.pushViewController(destinationVC, animated: true)
        UIView.transition(with: self.navigationController.view, duration: 1.0, options: UIView.AnimationOptions.transitionCrossDissolve, animations: nil, completion: nil)
    }
    
    func itemToInventory(vc: ItemViewController) {
        let destinationVC = InventoryViewController.instantiate()
        destinationVC.coordinator = self
        destinationVC.gameLogic = vc.gameLogic
        destinationVC.isFromItem = true
        destinationVC.currentTrack = vc.currentTrack
        destinationVC.aB = vc.aB
        navigationController.popViewController(animated: false)
        navigationController.pushViewController(destinationVC, animated: true)
        UIView.transition(with: self.navigationController.view, duration: 1.0, options: UIView.AnimationOptions.transitionCrossDissolve, animations: nil, completion: nil)
    }
    
//MARK: - Character Select Segue
    
    func selectToStory(vc: CharacterSelectViewController) {
        let destinationVC = StoryTabViewController.instantiate()
        destinationVC.coordinator = self
        destinationVC.gameLogic = vc.gameLogic
        destinationVC.currentTrack = vc.currentTrack
        destinationVC.aB = vc.aB
        navigationController.popViewController(animated: false)
        navigationController.pushViewController(destinationVC, animated: true)
        UIView.transition(with: self.navigationController.view, duration: 1.0, options: UIView.AnimationOptions.transitionCrossDissolve, animations: nil, completion: nil)
    }
    
    func selectToChar(vc: CharacterSelectViewController) {
        let destinationVC = MyCharacterViewController.instantiate()
        destinationVC.coordinator = self
        destinationVC.gameLogic = vc.gameLogic
        destinationVC.currentTrack = vc.currentTrack
        destinationVC.aB = vc.aB
        destinationVC.isFromMain = false
        navigationController.popViewController(animated: false)
        navigationController.pushViewController(destinationVC, animated: true)
        UIView.transition(with: self.navigationController.view, duration: 1.0, options: UIView.AnimationOptions.transitionCrossDissolve, animations: nil, completion: nil)
    }
    
//MARK: - Inventory View Segue
    
    func inventoryToMain(vc: InventoryViewController) {
        let destinationVC = MainMenuViewController.instantiate()
        destinationVC.coordinator = self
        destinationVC.gameLogic = vc.gameLogic
        destinationVC.currentTrack = vc.currentTrack!
        destinationVC.aB = vc.aB
        navigationController.popViewController(animated: false)
        navigationController.pushViewController(destinationVC, animated: true)
        UIView.transition(with: self.navigationController.view, duration: 1.0, options: UIView.AnimationOptions.transitionCrossDissolve, animations: nil, completion: nil)
    }
    
    func inventoryToStory(vc: InventoryViewController) {
        let destinationVC = StoryTabViewController.instantiate()
        destinationVC.coordinator = self
        destinationVC.gameLogic = vc.gameLogic
        destinationVC.currentTrack = vc.currentTrack
        destinationVC.aB = vc.aB
        navigationController.popViewController(animated: false)
        navigationController.pushViewController(destinationVC, animated: true)
        UIView.transition(with: self.navigationController.view, duration: 1.0, options: UIView.AnimationOptions.transitionCrossDissolve, animations: nil, completion: nil)
    }
    
    func inventoryToItem(vc: InventoryViewController) {
        let destinationVC = ItemViewController.instantiate()
        destinationVC.coordinator = self
        destinationVC.gameLogic = vc.gameLogic
        destinationVC.currentTrack = vc.currentTrack
        destinationVC.aB = vc.aB
        navigationController.popViewController(animated: false)
        navigationController.pushViewController(destinationVC, animated: true)
        UIView.transition(with: self.navigationController.view, duration: 1.0, options: UIView.AnimationOptions.transitionCrossDissolve, animations: nil, completion: nil)
    }
    
    func inventoryToEncounter(vc: InventoryViewController) {
        let destinationVC = EncounterViewController.instantiate()
        destinationVC.coordinator = self
        destinationVC.gameLogic = vc.gameLogic
        destinationVC.isReturnedFromInventory = true
        //destinationVC.currentStoryTabString = currentStoryTabString
        destinationVC.isPlayerTurn = vc.isPlayerTurn
        //destinationVC.storyTabToReturn = storyTabToReturn
        destinationVC.currentTrack = vc.currentTrack
        destinationVC.aB = vc.aB
        navigationController.popViewController(animated: false)
        navigationController.pushViewController(destinationVC, animated: true)
        UIView.transition(with: self.navigationController.view, duration: 1.0, options: UIView.AnimationOptions.transitionCrossDissolve, animations: nil, completion: nil)
    }
    
    func inventoryToList(vc: InventoryViewController) {
        let destinationVC = ItemListViewController.instantiate()
        destinationVC.coordinator = self
        destinationVC.gameLogic = vc.gameLogic
        destinationVC.isFromMain = vc.isFromMain
        destinationVC.isFromStory = vc.isFromStory
        destinationVC.isFromItem = vc.isFromItem
        destinationVC.isFromEncounter = vc.isFromEncounter
        destinationVC.indexToChange = vc.indexToChange
        destinationVC.isPlayerTurn = vc.isPlayerTurn
        destinationVC.currentTrack = vc.currentTrack
        destinationVC.aB = vc.aB
        navigationController.popViewController(animated: false)
        navigationController.pushViewController(destinationVC, animated: true)
        UIView.transition(with: self.navigationController.view, duration: 1.0, options: UIView.AnimationOptions.transitionCrossDissolve, animations: nil, completion: nil)
    }
    
//MARK: -  Item List Segue
    func listToInventory(vc: ItemListViewController) {
        let destinationVC = InventoryViewController.instantiate()
        destinationVC.coordinator = self
        destinationVC.gameLogic = vc.gameLogic
        destinationVC.isFromStory = vc.isFromStory
        destinationVC.isFromMain = vc.isFromMain
        destinationVC.isFromItem = vc.isFromItem
        destinationVC.isFromEncounter = vc.isFromEncounter
        destinationVC.isPlayerTurn = vc.isPlayerTurn
        destinationVC.currentTrack = vc.currentTrack
        destinationVC.aB = vc.aB
        navigationController.popViewController(animated: false)
        navigationController.pushViewController(destinationVC, animated: true)
        UIView.transition(with: self.navigationController.view, duration: 1.0, options: UIView.AnimationOptions.transitionCrossDissolve, animations: nil, completion: nil)
    }
    
//MARK: - My Character View Segues
    
    func charToMain(vc: MyCharacterViewController) {
        let destinationVC = MainMenuViewController.instantiate()
        destinationVC.coordinator = self
        destinationVC.gameLogic = vc.gameLogic
        destinationVC.currentTrack = vc.currentTrack!
        destinationVC.aB = vc.aB
        navigationController.popViewController(animated: false)
        navigationController.pushViewController(destinationVC, animated: true)
        UIView.transition(with: self.navigationController.view, duration: 1.0, options: UIView.AnimationOptions.transitionCrossDissolve, animations: nil, completion: nil)
    }
    
    func charToSelect(vc: MyCharacterViewController) {
        let destinationVC = CharacterSelectViewController.instantiate()
        destinationVC.coordinator = self
        destinationVC.gameLogic = vc.gameLogic
        destinationVC.currentTrack = vc.currentTrack
        destinationVC.aB = vc.aB
        navigationController.popViewController(animated: false)
        navigationController.pushViewController(destinationVC, animated: true)
        UIView.transition(with: self.navigationController.view, duration: 1.0, options: UIView.AnimationOptions.transitionCrossDissolve, animations: nil, completion: nil)
    }
}
