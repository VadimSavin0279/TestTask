//
//  ViewController.swift
//  TaskTestFood
//
//  Created by 123 on 03.04.2023.
//

import UIKit

protocol MenuDisplayLogic: AnyObject {
  func displayData(viewModel: Menu.Model.ViewModel.ViewModelData)
}

class MenuViewController: UIViewController, MenuDisplayLogic {
    
    var interactor: MenuBusinessLogic?
    var router: (NSObjectProtocol & MenuRoutingLogic)?
    
    @IBOutlet private var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: "\(CustomCellForFood.self)", bundle: nil), forCellReuseIdentifier: CustomCellForFood.description())
            tableView.rowHeight = UITableView.automaticDimension
        }
    }
    private var collectionViewForStock: UICollectionView!
    private var collectionViewForCategory: UICollectionView!
    private var headerView: UIView?
    private var menuViewModel = MenuViewModel(arrayOfCategories: [], arrayOfMovies: [], arrayForCountFilmsInCategories: [])
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        renderMainScreen()
        setupButtonForCity()
        interactor?.makeRequest(request: .contentRequest)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupCollectionViewForSale()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupCollectionViewForCategories()
    }
    
    func displayData(viewModel: Menu.Model.ViewModel.ViewModelData) {
        switch viewModel {
        case .some:
            break
        case .displayCategory(let indexPath):
            setupCategory(indexPath: indexPath)
        case .displayContent(let arrayOfCategories,
                             let arrayOfMovies,
                             let arrayForCountFilmsInCategories):
            setupData(arrayOfCategories: arrayOfCategories,
                      arrayOfMovies: arrayOfMovies,
                      arrayForCountFilmsInCategories: arrayForCountFilmsInCategories)
        }
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController        = self
        let interactor            = MenuInteractor()
        let presenter             = MenuPresenter()
        let router                = MenuRouter()
        viewController.interactor = interactor
        viewController.router     = router
        interactor.presenter      = presenter
        presenter.viewController  = viewController
        router.viewController     = viewController
    }
    
    private func setupData(arrayOfCategories: [String],
                           arrayOfMovies: [Content.Docs],
                           arrayForCountFilmsInCategories: [Int]) {
        menuViewModel.arrayOfMovies = arrayOfMovies
        menuViewModel.arrayOfCategories = arrayOfCategories
        menuViewModel.arrayForCountFilmsInCategories = arrayForCountFilmsInCategories
        
        tableView.reloadData()
        collectionViewForCategory?.reloadData()
    }
    
    private func setupCategory(indexPath: IndexPath) {
        var row = 0
        if indexPath.section != 0 {
            row = menuViewModel.arrayForCountFilmsInCategories[indexPath.section - 1]
        }
        tableView.scrollToRow(at: IndexPath(row: row, section: 0), at: .middle, animated: true)
    }
    
    private func renderMainScreen() {
        view.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        tableView.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        
        navigationController?.navigationBar.tintColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
    }
    
    private func setupButtonForCity() {
        let button = UIButton(configuration: .borderless())
        button.setTitle("Москва", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.configuration?.imagePadding = 8
        button.semanticContentAttribute = .forceRightToLeft
        button.setImage(UIImage(named: "arrow"), for: .normal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    private func setupCollectionViewForSale() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 300, height: 112)
        
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 112), collectionViewLayout: layout)
        collectionViewForStock = collectionView
        collectionView.register(UINib(nibName: "\(CustomCellForStock.self)", bundle: nil), forCellWithReuseIdentifier: CustomCellForStock.description())
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        
        tableView.tableHeaderView = collectionView
    }
    
    private func setupCollectionViewForCategories() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 88, height: 32)
        
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 32), collectionViewLayout: layout)
        collectionView.register(UINib(nibName: "\(CustomCellForCategory.self)", bundle: nil), forCellWithReuseIdentifier: CustomCellForCategory.description())
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 8)
        collectionView.backgroundColor = .clear
        
        collectionViewForCategory = collectionView
    }
}

extension MenuViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case collectionViewForStock:
            return 2
        case collectionViewForCategory:
            return 1
        default:
            return 2
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        switch collectionView {
        case collectionViewForStock:
            return 1
        case collectionViewForCategory:
            return menuViewModel.arrayOfCategories.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case collectionViewForStock:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCellForStock.description(), for: indexPath)
            return cell
        case collectionViewForCategory:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCellForCategory.description(), for: indexPath) as? CustomCellForCategory else {
                return UICollectionViewCell()
            }
            cell.configureCell(with: menuViewModel.arrayOfCategories[indexPath.section])
            if menuViewModel.selectedCell == indexPath {
                cell.setupSelectedCell()
            }
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case collectionViewForCategory:
            interactor?.makeRequest(request: .newCategoryRequest(indexPath))
        default:
            break
        }
    }
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        menuViewModel.arrayOfMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomCellForFood.description()) as? CustomCellForFood else {
            return UITableViewCell()
        }
        prepare(cell: cell, with: indexPath)
        return cell
    }
    
    private func prepare(cell: CustomCellForFood, with indexPath: IndexPath) {
        cell.configureCell(with: menuViewModel.arrayOfMovies[indexPath.row])
        if indexPath.row == 0 {
            cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            cell.layer.cornerRadius = 30
            cell.clipsToBounds = true
        } else {
            cell.layer.cornerRadius = 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 55))
        view.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        view.addSubview(collectionViewForCategory)
        headerView = view
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension MenuViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        showOrHideShadowForSection(offset: tableView.contentOffset.y)
    }
    
    func scrollViewDidEndScrolling(scrollView: UIScrollView) {
        defineCategory()
    }
    
    private func defineCategory() {
        if let array = tableView.indexPathsForVisibleRows, !array.isEmpty {
            let indexPathOfCenterCell = array[array.count / 2]
            for index in 0..<menuViewModel.arrayForCountFilmsInCategories.count {
                if indexPathOfCenterCell.row < menuViewModel.arrayForCountFilmsInCategories[index] {
                    if menuViewModel.selectedCell.section != index {
                        menuViewModel.selectedCell.section = index
                        collectionViewForCategory?.scrollToItem(at: IndexPath(row: 0, section: index), at: .centeredHorizontally, animated: true)
                        collectionViewForCategory?.reloadData()
                    }
                    break
                }
            }
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollViewDidEndScrolling(scrollView: scrollView)
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            scrollViewDidEndScrolling(scrollView: scrollView)
        }
    }
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        scrollViewDidEndScrolling(scrollView: scrollView)
    }
    
    private func showOrHideShadowForSection(offset: CGFloat) {
        if offset > 136 {
            UIView.animate(withDuration: 0.1, delay: 0) { [self] in
                headerView?.layer.shadowOpacity = 1
                headerView?.layer.shadowColor = UIColor(red: 0.646, green: 0.646, blue: 0.646, alpha: 0.5).cgColor
                headerView?.layer.shadowRadius = 14
                headerView?.layer.shadowOffset = CGSize(width: 0, height: 3)
            }
            navigationController?.navigationBar.barTintColor = UIColor(red: 0.953, green: 0.961, blue: 0.976, alpha: 1)
            headerView?.backgroundColor = UIColor(red: 0.953, green: 0.961, blue: 0.976, alpha: 1)
            
        } else {
            UIView.animate(withDuration: 0.1, delay: 0) { [self] in
                headerView?.layer.shadowRadius = 0
                headerView?.layer.shadowOffset = CGSize(width: 0, height: 0)
            }
            navigationController?.navigationBar.barTintColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
            headerView?.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        }
    }
}
