//
//  ReadWriteValueWrapper.swift
//  ThreadSafe
//
//  Created by jiasong on 2024/5/30.
//

import Foundation

@propertyWrapper public final class ReadWriteValueWrapper<Value> {
    
    public let projectedValue: ReadWriteValueProjected<Value>
    
    public var wrappedValue: Value {
        get {
            return self.projectedValue.readWrite.value
        }
        set {
            self.projectedValue.readWrite.value = newValue
        }
    }
    
    public init(wrappedValue: Value, task: ReadWriteTask = .init(label: "com.cloudlessmoon.thread-safe.read-write-value-wrapper")) {
        self.projectedValue = ReadWriteValueProjected(value: wrappedValue, task: task)
    }
    
}

public final class ReadWriteValueProjected<Value> {
    
    public var task: ReadWriteTask {
        get {
            return self.readWrite.task
        }
        set {
            self.readWrite.task = newValue
        }
    }
    
    fileprivate var readWrite: ReadWriteValue<Value>
    
    fileprivate init(value: Value, task: ReadWriteTask) {
        self.readWrite = ReadWriteValue(value, task: task)
    }
    
}

extension ReadWriteValueWrapper: CustomStringConvertible {
    
    public var description: String {
        return String(describing: self.projectedValue.readWrite)
    }
    
}
