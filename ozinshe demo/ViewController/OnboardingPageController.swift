//
//  OnboardingPageController.swift
//  ozinshe demo
//
//  Created by Мади Темешев on 26.01.2026.
//
import UIKit
import SnapKit
import AdvancedPageControl

class OnboardingPageController: UIPageViewController{
   
    
    private let models: [OnboardingModel] = [
        OnboardingModel(title: "ÖZINŞE-ге қош келдің!", subtitle: "Фильмдер, телехикаялар, ситкомдар, анимациялық жобалар, телебағдарламалар мен реалити-шоулар, аниме және тағы басқалары", image: "onboarding1", isLast: false),
        OnboardingModel(title: "ÖZINŞE-ге қош келдің!", subtitle:"""
                        Кез келген құрылғыдан қара 
                        Сүйікті фильміңді  қосымша төлемсіз телефоннан, планшеттен, ноутбуктан қара
                        """, image: "onboarding2", isLast: false),
        OnboardingModel(title: "ÖZINŞE-ге қош келдің!", subtitle: "Тіркелу оңай. Қазір тіркел де қалаған фильміңе қол жеткіз", image: "onboarding3", isLast: true)
        
    ]
    
    private var pages: [UIViewController] = []
    
    lazy var pageControl: AdvancedPageControlView = {
            let pageControl = AdvancedPageControlView()
            
            pageControl.drawer = ExtendedDotDrawer(
                numberOfPages: pages.count,
                height: 6,
                width: 6,
                space: 4,
                raduis: 3,
                indicatorColor: UIColor(red: 0.7, green: 0.46, blue: 0.97, alpha: 1),
                dotsColor: UIColor(red: 0.82, green: 0.84, blue: 0.86, alpha: 1),
                borderWidth: 0
            )
            
            return pageControl
    }()
    
   
   
    init(){
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        self.delegate = self
        setupPages()
        setupUI()
        //setupScrollViewDelegate()
        if let firstVC = pages.first {
            setViewControllers([firstVC], direction: .forward, animated: true)
        }

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    private func setupUI(){
        view.addSubview(pageControl)
        
        pageControl.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.height.equalTo(6)
            make.width.equalTo(40)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(118)
        }
    }
    
    private func setupPages(){
        for model in models{
            let vc = OnboardingVC()
            vc.configure(model: model)
            vc.onSkip = { [weak self] in
                self?.finishScroll()
            }
            pages.append(vc)
        }
    }
    
    private func finishScroll(){
        guard let lastVC = pages.last else { return }
        setViewControllers([lastVC], direction: .forward, animated: true)
        
        pageControl.setPage(pages.count - 1)
        
    }
    
    private func setupScrollViewDelegate(){
        for view in self.view.subviews {
            if let scrollView = view as? UIScrollView {
                scrollView.delegate = self
            }
        }
    }
   
    
    
}

extension OnboardingPageController: UIPageViewControllerDataSource{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index > 0 else {return nil}
        return pages[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index < pages.count - 1 else {return nil}
        return pages[index + 1]
    }
    
    
}

extension OnboardingPageController: UIPageViewControllerDelegate{
    func  pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed, let visibleVC = pageViewController.viewControllers?.first, let index = pages.firstIndex(of: visibleVC) {
            pageControl.setPage(index)
        }
    }
}

extension OnboardingPageController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.x
        let width = scrollView.frame.width
        let index = Int(round(offset/width))
        
        pageControl.setPage(index)
        
    }
}
