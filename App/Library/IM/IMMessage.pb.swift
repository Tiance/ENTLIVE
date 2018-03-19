// DO NOT EDIT.
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: App/Library/IM/IMMessage.proto
//
// For information on using the generated types, please see the documenation:
//   https://github.com/apple/swift-protobuf/

import Foundation
import SwiftProtobuf

// If the compiler emits an error on this type, it is because this file
// was generated by a version of the `protoc` Swift plug-in that is
// incompatible with the version of SwiftProtobuf to which you are linking.
// Please ensure that your are building against the same version of the API
// that was used to generate this file.
fileprivate struct _GeneratedWithProtocGenSwiftVersion: SwiftProtobuf.ProtobufAPIVersionCheck {
  struct _2: SwiftProtobuf.ProtobufAPIVersion_2 {}
  typealias Version = _2
}

struct IMMessage {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var cmdType: Int32 = 0

  /// Unique ID number for this person.
  var cmd: Int32 = 0

  var unknownFields = SwiftProtobuf.UnknownStorage()

  enum CMD: SwiftProtobuf.Enum {
    typealias RawValue = Int
    case gift // = 0
    case UNRECOGNIZED(Int)

    init() {
      self = .gift
    }

    init?(rawValue: Int) {
      switch rawValue {
      case 0: self = .gift
      default: self = .UNRECOGNIZED(rawValue)
      }
    }

    var rawValue: Int {
      switch self {
      case .gift: return 0
      case .UNRECOGNIZED(let i): return i
      }
    }

  }

  enum CMDTYPE: SwiftProtobuf.Enum {
    typealias RawValue = Int
    case giftSend // = 0
    case UNRECOGNIZED(Int)

    init() {
      self = .giftSend
    }

    init?(rawValue: Int) {
      switch rawValue {
      case 0: self = .giftSend
      default: self = .UNRECOGNIZED(rawValue)
      }
    }

    var rawValue: Int {
      switch self {
      case .giftSend: return 0
      case .UNRECOGNIZED(let i): return i
      }
    }

  }

  init() {}
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

extension IMMessage: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = "IMMessage"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "cmdType"),
    2: .same(proto: "cmd"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularInt32Field(value: &self.cmdType)
      case 2: try decoder.decodeSingularInt32Field(value: &self.cmd)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.cmdType != 0 {
      try visitor.visitSingularInt32Field(value: self.cmdType, fieldNumber: 1)
    }
    if self.cmd != 0 {
      try visitor.visitSingularInt32Field(value: self.cmd, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  func _protobuf_generated_isEqualTo(other: IMMessage) -> Bool {
    if self.cmdType != other.cmdType {return false}
    if self.cmd != other.cmd {return false}
    if unknownFields != other.unknownFields {return false}
    return true
  }
}

extension IMMessage.CMD: SwiftProtobuf._ProtoNameProviding {
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    0: .same(proto: "GIFT"),
  ]
}

extension IMMessage.CMDTYPE: SwiftProtobuf._ProtoNameProviding {
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    0: .same(proto: "GIFT_SEND"),
  ]
}
