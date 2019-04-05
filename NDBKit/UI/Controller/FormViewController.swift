//
//  FormViewController.swift
//  NDBKit
//
//  Created by Tung CHENG on 2019/4/4.
//  Copyright © 2019 Tung CHENG. All rights reserved.
//

import UIKit

public class FormViewController: UIViewController {
    @IBOutlet weak var headerView: FormHeaderView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var containerView: FormContainerView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var buttonTag: UIButton!
    @IBOutlet weak var buttonDone: IBButton!
    
    @IBOutlet weak var showHideCollection: NSLayoutConstraint!
    
    public weak var delegate: FormViewControllerDelegate?
    
    public var presentationStyle: PresentationStyle = .modal {
        didSet {
            configure(with: presentationStyle)
        }
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(TagCollectionCell.self, forCellWithReuseIdentifier: "Tag")
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification), name: .entityTextFieldDidBeginEditing, object: nil)
        
        title = "Add New"
        navigationController?.navigationBar.tintColor = NutrientUI.tintColor
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel, target: self, action: #selector(dismissForm))
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .search, target: self, action: #selector(presentSearchSheet))
    }
    
    fileprivate func configure(with presentationStyle: PresentationStyle) {
        switch presentationStyle {
        case .modal:
            break
        case .detail:
            break
        case .search:
            break
        }
    }
    
    @objc fileprivate func presentSearchSheet() {
        let search = SearchViewController()
        search.delegate = self
        let nc = UINavigationController(rootViewController: search)
        present(nc, animated: true)
    }
    
    @objc fileprivate func dismissForm() {
        navigationController?.dismiss(animated: true)
    }
    
    @objc fileprivate func handleNotification(_ note: Notification) {
        guard let textField = note.object as? UITextField else { return }
        guard let entity = Entity(rawValue: textField.tag - 100) else { return }
        self.entity = entity
        self.isTagsHidden = true
        pickerView.selectRow(entity.rawValue, inComponent: 0, animated: true)
    }
    
    @IBAction func toggleCollectionDisplay(_ sender: UIButton) {
        textField(for: self.entity)?.resignFirstResponder()
        isTagsHidden.toggle()
        if !isTagsHidden {
            guard let tag = sender.title(for: [.normal]) else { return }
            guard let item = tags.firstIndex(of: tag) else { return }
            let index = IndexPath(item: item, section: 0)
            collectionView.scrollToItem(at: index, at: .top, animated: false)
        }
    }
    
    @IBAction func doneWithForm(_ sender: UIButton) {
        let foodName = textField(for: .name)?.text
        delegate?.handleForm(foodName: foodName, report: { entity in
            let number = NSNumber(value: 0)
            guard let text = self.textField(for: entity)?.text else {
                return number
            }
            let value = self.numberFormatter.number(from: text)
            return value ?? number
        })
    }
    
    fileprivate var entity: Entity = .name {
        didSet {
            guard let textField = textField(for: entity) else { return }
            guard !textField.isFirstResponder else { return }
            textField.becomeFirstResponder()
        }
    }
    
    fileprivate func textField(for entity: Entity) -> UITextField! {
        return view.viewWithTag(entity.tag) as? UITextField
    }

    fileprivate var entities: [Entity] {
        return Entity.allCases
    }
    
    fileprivate var tags: [String] {
        return [
            "🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🍈", "🍒", "🍑",
            "🥭", "🍍", "🥥", "🥝", "🍅", "🍆", "🥑", "🥦", "🥬", "🥒", "🌶",
            "🌽", "🥕", "🥔", "🍠", "🧀", "🥚", "🥛", "🍞", "🥗", "🥓", "🥩",
            "🍗", "🥪", "🥞", "🥫", "🍝", "🍜", "🍛", "🍣", "🍱", "🥟", "🍙",
            "🍚", "🍫", "🍪", "🍔", "🍟", "🍦", "🌮", "🥙", "🥯", "🥐", "🌭"]
    }
    
    fileprivate var isTagsHidden: Bool = true {
        didSet {
            showHideCollection.constant = isTagsHidden ? 8 : 300
            UIViewPropertyAnimator(duration: 0.2, dampingRatio: 1, animations: view.layoutIfNeeded).startAnimation()
        }
    }
    
    fileprivate lazy var numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    public enum PresentationStyle {
        case detail
        case search
        case modal
    }
}

extension FormViewController: NutrientsViewControllerDelegate {
    
    public func nutrient(controller: NutrientsViewController, send nutrients: [String: String]) {
        labelName.text = controller.foodName
        textField(for: .name)?.text = controller.foodName
        textField(for: .energy)?.text = nutrients[.energy]
        textField(for: .fat)?.text = nutrients[.totalFat]
        textField(for: .protien)?.text = nutrients[.protein]
        textField(for: .carbs)?.text = nutrients[.carbohydrate]
    }
}

extension FormViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let tag = tags[indexPath.row]
        buttonTag.setTitle(tag, for: [.normal])
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Tag", for: indexPath) as! TagCollectionCell
        let tag = tags[indexPath.item]
        cell.configure(for: tag)
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
}

extension FormViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return entities.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let title = entities[row].description
        guard let dequeued = view as? EntityPickerCell else {
            let cell = EntityPickerCell()
            cell.title = title
            return cell
        }
        dequeued.title = title
        return dequeued
    }
    
    public func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 25
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let entity = Entity(rawValue: row) {
            self.entity = entity
            self.isTagsHidden = true
        }
    }
}

extension FormViewController: UITextFieldDelegate {
    public func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        self.entity = .name
        self.isTagsHidden = true
        pickerView.selectRow(0, inComponent: 0, animated: true)
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        labelName.text = text
        return true
    }
}

public enum Entity: Int, CaseIterable {
    case name, size, energy, fat, protien, carbs
    
    var tag: Int {
        return rawValue + 100
    }
}

extension Entity: CustomStringConvertible {
    public var description: String {
        switch self {
        case .name: return "Food Name"
        case .size: return "Serving size"
        case .energy: return "Energy"
        case .fat: return "Total Fat"
        case .protien: return "Protein"
        case .carbs: return "Carbohydrate"
        }
    }
}
