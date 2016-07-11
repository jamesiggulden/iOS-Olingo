//
//  ErrorTypes.swift
//  iOS-Olingo
//
//  Created by Greg Napier on 30/06/2016.
//  Copyright © 2016 EnergySys. All rights reserved.
//

import Foundation

public enum IllegalArgumentException:ErrorType {
  case NilOrEmptyString
  case ContainsWildCard
  case ContainsWhiteSpace
  case InvalidFormat
  case BeginsWithWhiteSpace
}

public enum ClassInitialisationException: ErrorType {
  case InitialisationFailed
}

public enum HttpError:ErrorType {
  case HttpRequestFailed
  case InvalidHttpResponse
  case ErrorCodeReturned (errorCode:Int)
}

public enum ODataDeserializerException:ErrorType {
  case InvalidFormat
}

public enum EdmPrimitiveTypeException:ErrorType{
  case LiteralNilNotAllowed
  case LiteralHasIllegalContent
}
