//
//  Diary - DiaryMainViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class DiaryMainViewController: UIViewController {
    private let diaryTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(DiaryTableViewCell.self, forCellReuseIdentifier: DiaryTableViewCell.identifier)
        
        return tableView
    }()

    private var diarylist: [Diary]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        diaryTableView.delegate = self
        diaryTableView.dataSource = self
        
        self.view.backgroundColor = .systemBackground
        self.navigationItem.title = "일기장"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddDiaryButton))
        
        addSubViews()
        diaryTableViewConstraints()
        
        do {
            try decodeDiary()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @objc private func didTapAddDiaryButton() {
        let detailDiaryViewController = DetailDiaryViewController()
        self.navigationController?.pushViewController(detailDiaryViewController, animated: true)
    }
    
    private func decodeDiary() throws {
        let decoder = JSONDecoder()
        
        guard let dataAsset = NSDataAsset(name: "sample") else {
            throw DecodeError.assetNotFound
        }
        
        guard let decodedData = try? decoder.decode([Diary].self, from: dataAsset.data) else {
            throw DecodeError.failed
        }
        
        diarylist = decodedData
    }
}

extension DiaryMainViewController {
    private func addSubViews() {
        view.addSubview(diaryTableView)
    }
    
    private func diaryTableViewConstraints() {
        diaryTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            diaryTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            diaryTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            diaryTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            diaryTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension DiaryMainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let diarylist else {
            return .zero
        }
        
        return diarylist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DiaryTableViewCell.identifier, for: indexPath) as? DiaryTableViewCell else {
            return UITableViewCell()
        }
        
        guard let diarylist else {
            return UITableViewCell()
        }
        
        cell.fetchData(diarylist[indexPath.row])
        
        return cell
    }
}
