//
//  UIControl+Extension.swift
//  MJExtensions
//
//  Created by chenminjie on 2020/11/16.
//

import Foundation

//var allUIControlBlockTargetsKey = 100
//
//extension TypeWrapperProtocol where WrappedType: UIControl {
//
//    public mutating func removeAllTargets() {
//        wrappedValue.allTargets.map { (object) -> Int in
//            wrappedValue.removeTarget(object, action: nil, for: UIControl.Event.allEvents)
//            return 0
//        }
//        self.allUIControlBlockTargets.removeAll()
//    }
//    
//    public func setTarget(_ target: Any, action:Selector, controlEvents: UIControl.Event) {
//        
//        var targets = wrappedValue.allTargets
//        for currentTarget in targets {
//            if let actions = wrappedValue.actions(forTarget: currentTarget, forControlEvent: controlEvents) {
//                for currentAction in actions {
//                    wrappedValue.removeTarget(currentTarget, action: Selector(currentAction), for: controlEvents)
//                }
//            }
//        }
//        wrappedValue.addTarget(target, action: action, for: controlEvents)
//    }
//    
//    /// 添加事件
//    public func addEvent(for controlEvents: UIControl.Event, completion: @escaping ((_ sender: Any?)-> Void)) {
//        
//        let target = MJUIControlBlockTarget.init(with: completion, controlEvents: controlEvents)
//        wrappedValue.addTarget(target, action: Selector("invoke:"), for: controlEvents)
//        var targets = self.allUIControlBlockTargets
//        targets.append(target)
//    }
//    
//    public func setEvent(for controlEvents: UIControl.Event, completion: @escaping ((_ sender: Any?)-> Void)) {
//        
//        self.removeAllBlocksForControlEvents(.allEvents)
//        self.addEvent(for: controlEvents, completion: completion)
//    }
//   
//    public func removeAllBlocksForControlEvents(_ controlEvents: UIControl.Event) {
//        var targets = self.allUIControlBlockTargets
//        var removes: [MJUIControlBlockTarget] = []
//        for target in targets {
//            if let _events = target.events {
//                var newEvent = _events + controlEvents
//                if
//                UIControlEvents newEvent = _events
//                           if (newEvent) {
//                               [self removeTarget:target action:@selector(invoke:) forControlEvents:target.events];
//                               target.events = newEvent;
//                               [self addTarget:target action:@selector(invoke:) forControlEvents:target.events];
//                           } else {
//                               [self removeTarget:target action:@selector(invoke:) forControlEvents:target.events];
//                               [removes addObject:target];
//                           }
//            }
//        }
//
//        [targets removeObjectsInArray:removes];
//    }
//
//    
//    var allUIControlBlockTargets: [MJUIControlBlockTarget] {
//        set {
//            objc_setAssociatedObject(wrappedValue, &allUIControlBlockTargetsKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//        }
//        
//        get {
//            if let rs = objc_getAssociatedObject(wrappedValue, &allUIControlBlockTargetsKey) as? [MJUIControlBlockTarget] {
//                return rs
//            }
//            var targets: [MJUIControlBlockTarget] = []
//            objc_setAssociatedObject(wrappedValue, &allUIControlBlockTargetsKey, targets, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//            return targets
//        }
//    }
//}
//
//public class MJUIControlBlockTarget: NSObject {
//    
//    var completion:((_ sender: Any?)-> Void)?
//    var events: UIControl.Event?
//   
//    public init(with completion:((_ sender: Any?)-> Void)?, controlEvents: UIControl.Event?) {
//        self.completion = completion
//        self.events = controlEvents
//    }
//
//    @objc public func invoke(sender: Any?) {
//        if let _completion = completion {
//            _completion(sender)
//        }
//    }
//}
