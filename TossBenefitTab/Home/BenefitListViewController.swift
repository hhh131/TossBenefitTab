//
//  BenefitListViewController.swift
//  TossBenefitTab
//
//  Created by 신희권 on 2023/03/27.
//

import UIKit
import Combine

class BenefitListViewController: UIViewController {
    //사용자는 포인트를 볼 수 있다.
    // 사용자는 오늘의 혜택을 볼 수 있따.
    // 나머지 혜택 리스트
    // 사용자는 포인트 셀을 눌렀을 때 포인트 상세뷰로 넘어간다.
    //사용자는 혜택 관련 셀을 눌렀을 때 혜택 상세뷰로 넘어간다.
    
    
    @IBOutlet var collectionView: UICollectionView!
    
    typealias Item = AnyHashable
    enum Section: Int {
        case today
        case other
    }
    
    let viewModel: BenefitListViewModel = BenefitListViewModel()
    
    var datasource: UICollectionViewDiffableDataSource<Section, Item>!
    
    var subscription = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        setupUI()
        bind()
        viewModel.fetchItmes()
    }
    
    private func setupUI(){
        navigationItem.title = "혜택"
    }
    
    private func configureCollectionView(){
        datasource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            guard let section = Section(rawValue: indexPath.section) else { return nil }
           let cell = self.configureCell(for: section, item: item, collectionView: collectionView, indexPath: indexPath)
           return cell
        
        })

        var snapshot = NSDiffableDataSourceSnapshot<Section,Item>()
     snapshot.appendSections([.today,.other])
       snapshot.appendItems([], toSection: .today)
        snapshot.appendItems([], toSection: .other)
        datasource.apply(snapshot)
//
//
      collectionView.collectionViewLayout = layout()
       collectionView.delegate = self
    }
    
    private func bind() {
        viewModel.$todaySectionItems
            .receive(on: RunLoop.main)
            .sink{ items in
                self.applySnapshot(items: items, section: .today)
            }.store(in: &subscription)
        viewModel.$otherSectionItems
            .receive(on: RunLoop.main)
            .sink{ items in
                self.applySnapshot(items: items, section: .other)
            }.store(in: &subscription)
        
        viewModel.benefitDidTapped
            .receive(on: RunLoop.main)
            .sink{ benefit in
                let sb = UIStoryboard(name: "ButtonBenefit", bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: "ButtonBenefitViewController") as! ButtonBenefitViewController
                vc.viewModel = ButtonBenefitViewModel(benefit: benefit)
                self.navigationController?.pushViewController(vc, animated: true)
            }.store(in: &subscription)
        viewModel.MypointDidTapped
            .receive(on: RunLoop.main)
            .sink{ point in
                let sb = UIStoryboard(name: "MyPoint", bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: "MyPointViewController") as! MyPointViewController
                vc.viewModel = MyPointViewModel(point: point)
                self.navigationController?.pushViewController(vc, animated: true)
            }.store(in: &subscription)
    }
    
    private func applySnapshot(items: [Item], section: Section) {
        var snapshot = datasource.snapshot()
        snapshot.appendItems(items,toSection: section)
        datasource.apply(snapshot)
        
    }
    
    private func configureCell(for section: Section, item: Item, collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell? {
        switch section {
         case .today:
            if let point = item as? MyPoint {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyPointCell", for: indexPath) as! MyPointCell
                cell.configure(item: point)
                return cell
            } else if let benefit = item as? Benefit {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TodayBenefitCell", for: indexPath) as! TodayBenefitCell
                cell.configure(item: benefit)
                return cell
            } else {
                return nil
            }
         case .other:
            if let benefit = item as? Benefit {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BenefitCell", for: indexPath) as! BenefitCell
                cell.configure(item: benefit)
                return cell
            } else {
                return nil
            }
        }
    }
    private func layout() -> UICollectionViewCompositionalLayout {
        let spacing: CGFloat = 10
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(80))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(60))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(10)
        
        let section  = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 16, bottom: 0, trailing: 16)
        section.interGroupSpacing = spacing
        
        return UICollectionViewCompositionalLayout(section: section)
    }
}

extension BenefitListViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = datasource.itemIdentifier(for: indexPath)
       
        
        if let benefit = item as? Benefit {
            viewModel.benefitDidTapped.send(benefit)
        }else if let point = item as? MyPoint{
            viewModel.MypointDidTapped.send(point)
        }else {
            //no-op
        }
    }
}
