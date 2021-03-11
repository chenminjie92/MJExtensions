//
//  UIScrollView+Extension.swift
//  MJExtensions
//
//  Created by chenminjie on 2020/11/13.
//

import UIKit
import MJRefresh

extension TypeWrapperProtocol where WrappedType: UIScrollView {
    
    /// 设置下啦加载
    /// - Parameters:
    ///   - scrollView: 滚动试图
    ///   - completion: 下拉完成回掉
    public func setRefreshHead(completion: @escaping (() -> Void)) {
        let header: MJRefreshNormalHeader = MJRefreshNormalHeader.init {
            completion()
        }
        // 设置自动切换透明度(在导航栏下面自动隐藏)
        header.isAutomaticallyChangeAlpha = true
        // 隐藏时间
        header.lastUpdatedTimeLabel?.isHidden = true
        header.setTitle("下拉刷新", for: .idle)
        header.setTitle("松开刷新", for: .pulling)
        header.setTitle("正在刷新", for: .refreshing)
        header.stateLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        // 设置header
        wrappedValue.mj_header = header;
    }
    
    /// 设置上加载更多
    /// - Parameters:
    ///   - scrollView: 滚动视图
    ///   - completion: 回调
    public func setRefreshFoot(completion: @escaping (() -> Void)) {
        let footer: MJRefreshBackNormalFooter = MJRefreshBackNormalFooter.init {
           completion()
        }

        footer.setTitle("加载更多", for: .idle)
        footer.setTitle("", for: .noMoreData)
        footer.setTitle("加载中...", for: .refreshing)
        footer.stateLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        // 设置header
        wrappedValue.mj_footer = footer;
    }
    
    /// 开始刷新
    public func beginRefresh() {
        if wrappedValue.mj_header != nil, wrappedValue.mj_header?.isRefreshing == false {
            wrappedValue.mj_header?.beginRefreshing()
        }
    }
    /// 关闭刷新
    public func endRefresh() {
        if wrappedValue.mj_header != nil, wrappedValue.mj_header?.isRefreshing == true {
            wrappedValue.mj_header?.endRefreshing()
        }
        if wrappedValue.mj_footer != nil, wrappedValue.mj_footer?.isRefreshing == true {
            wrappedValue.mj_footer?.endRefreshing()
        }
    }
    
    /// 提示没有更多的数据
    public func endRefreshFootNoMoreData() {
        wrappedValue.mj_footer?.endRefreshingWithNoMoreData()
    }
    
    /// 重置没有更多的数据
    public func resetRefreshFootNoMoreData() {
        wrappedValue.mj_footer?.resetNoMoreData()
    }

}
