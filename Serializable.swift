/*

Converts A class to a dictionary, used for serializing dictionaries to JSON

Supported objects:
- Serializable derived classes (sub classes)
- Arrays of Serializable
- NSData
- String, Numeric, and all other NSJSONSerialization supported objects

*/

import Foundation

public class Serializable: NSObject {
  
  /**
  Converts the class to a dictionary.
  
  - returns: The class as an NSDictionary.
  */
  
  public func toDictionary() -> NSDictionary {
    let propertiesDictionary = NSMutableDictionary()
    //let mirror = reflect(self)
    let mirror = Mirror(reflecting: self)
    
    for c in mirror.children {
      
      let propName = c.label
      let childMirror = c.value
      
      if let propValue: AnyObject = self.unwrap(childMirror) as? AnyObject {
        if let serializablePropValue = propValue as? Serializable {
          propertiesDictionary.setValue(serializablePropValue.toDictionary(), forKey: propName!)
        }
        else if let arrayPropValue = propValue as? [Serializable] {
          var subArray = [NSDictionary]()
          for item in arrayPropValue {
            subArray.append(item.toDictionary())
          }
          
          propertiesDictionary.setValue(subArray, forKey: propName!)
        }
        else if propValue is Int {
          propertiesDictionary.setValue(propValue as! Int, forKey: propName!)
        }
        else if propValue is Double || propValue is Float {
          propertiesDictionary.setValue(propValue , forKey: propName!)
        }
        else if let dataPropValue = propValue as? NSData {
          propertiesDictionary.setValue(dataPropValue.base64EncodedStringWithOptions(.Encoding64CharacterLineLength), forKey: propName!)
        }
        else if let datePropValue = propValue as? NSDate {
          propertiesDictionary.setValue(datePropValue.timeIntervalSince1970, forKey: propName!)
        }
        else if let boolPropValue = propValue as? Bool {
          propertiesDictionary.setValue(boolPropValue, forKey: propName!)
        }
        else {
          propertiesDictionary.setValue(propValue, forKey: propName!)
        }
      }
      
      if let propValue: EPetSex = self.unwrap(childMirror) as? EPetSex {
        propertiesDictionary.setValue(propValue.rawValue, forKey: propName!)
      }
      else if let propValue: EPetEnergyLevel = self.unwrap(childMirror) as? EPetEnergyLevel {
        propertiesDictionary.setValue(propValue.rawValue, forKey: propName!)
      }
      else if let propValue: EPetType = self.unwrap(childMirror) as? EPetType {
        propertiesDictionary.setValue(propValue.rawValue, forKey: propName!)
      }
      else if let propValue: EPetSize = self.unwrap(childMirror) as? EPetSize {
        propertiesDictionary.setValue(propValue.rawValue, forKey: propName!)
      }
    }
    
    return propertiesDictionary
  }
  
  /**
   * Converts the class to JSON.
   *
   * returns: The class as JSON, wrapped in NSData.
   */
  public func toJson(prettyPrinted : Bool = false) -> NSData? {
    let dictionary = self.toDictionary()
    
    if NSJSONSerialization.isValidJSONObject(dictionary) {
      let json = try? NSJSONSerialization.dataWithJSONObject(dictionary, options: (prettyPrinted ? .PrettyPrinted : NSJSONWritingOptions()))
      return json
    }
    
    return nil
  }
  
  /**
  Converts the class to a JSON string.
  
  - returns: The class as a JSON string.
  */
  public func toJsonString(prettyPrinted : Bool = false) -> String? {
    if let jsonData = self.toJson(prettyPrinted) {
      return NSString(data: jsonData, encoding: NSUTF8StringEncoding) as String?
    }
    
    return nil
  }
}

extension Serializable {
  
  /**
  Unwraps 'any' object. See http://stackoverflow.com/questions/27989094/how-to-unwrap-an-optional-value-from-any-type
  
  - returns: The unwrapped object.
  */
  private func unwrap(any: Any) -> Any? {
    let mi = Mirror(reflecting: any)
    
    if mi.descendant("Some") == nil { //#FIXME: JDDV Test this method with the API.
      return any
    }
    
    if mi.children.count == 0 {
      return nil
    }
    
    let (_, some) = mi.children.first!
    
    return some
  }
}