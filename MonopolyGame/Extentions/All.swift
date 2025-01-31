 

import UIKit
import SpriteKit

private var kAssociationKeyMaxLength: Int = 0


extension UITextField{
    @IBInspectable var placeholderColor: UIColor {
        get {
            return self.attributedPlaceholder?.attribute(.foregroundColor, at: 0, effectiveRange: nil) as? UIColor ?? .lightText
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: [.foregroundColor: newValue])
        }
    }
    
    @IBInspectable var maxLength: Int {
           get {
               if let length = objc_getAssociatedObject(self, &kAssociationKeyMaxLength) as? Int {
                   return length
               } else {
                   return Int.max
               }
           }
           set {
               objc_setAssociatedObject(self, &kAssociationKeyMaxLength, newValue, .OBJC_ASSOCIATION_RETAIN)
               self.addTarget(self, action: #selector(checkMaxLength), for: .editingChanged)
           }
       }
 
       func isInputMethod() -> Bool {
           if let positionRange = self.markedTextRange {
               if let _ = self.position(from: positionRange.start, offset: 0) {
                   return true
               }
           }
           return false
       }


    @objc func checkMaxLength(textField: UITextField) {

           guard !self.isInputMethod(), let prospectiveText = self.text,
               prospectiveText.count > maxLength
           else {
               return
           }

           let selection = selectedTextRange
           let maxCharIndex = prospectiveText.index(prospectiveText.startIndex, offsetBy: maxLength)
           text =  prospectiveText[..<maxCharIndex].description
           selectedTextRange = selection
       }
}


extension UITableView {

    func scrollToBottom(isAnimated:Bool = true){

        DispatchQueue.main.async {
            let indexPath = IndexPath(
                row: self.numberOfRows(inSection:  self.numberOfSections-1) - 1,
                section: self.numberOfSections - 1)
            if self.hasRowAtIndexPath(indexPath: indexPath) {
                self.scrollToRow(at: indexPath, at: .bottom, animated: isAnimated)
            }
        }
    }

    func scrollToTop(isAnimated:Bool = true) {

        DispatchQueue.main.async {
            let indexPath = IndexPath(row: 0, section: 0)
            if self.hasRowAtIndexPath(indexPath: indexPath) {
                self.scrollToRow(at: indexPath, at: .top, animated: isAnimated)
           }
        }
    }

    func hasRowAtIndexPath(indexPath: IndexPath) -> Bool {
        return indexPath.section < self.numberOfSections && indexPath.row < self.numberOfRows(inSection: indexPath.section)
    }
}



extension UITableView {
    
    func registerCells(_ cells : [UITableViewCell.Type]) {
        for cell in cells {
            self.register(UINib(nibName: String(describing: cell), bundle: Bundle.main), forCellReuseIdentifier: String(describing: cell))
        }
    }
}
extension UICollectionView {
    
    func registerCells(_ cells : [UICollectionViewCell.Type]) {
        for cell in cells {
            self.register(UINib(nibName: String(describing: cell), bundle: Bundle.main), forCellWithReuseIdentifier: String(describing: cell))
        }
    }
}


extension SKScene {
    
    func getTappedNode(_ touches: Set<UITouch> , scene:SKScene,name :String) -> (SKSpriteNode?,String?,Bool) {
        
        let tappedNodes = scene.nodes(at: touches.first!.location(in: scene))

        var sKSpriteNode : SKSpriteNode?  = nil
        
        for node in tappedNodes{

            if let tappedCard = node as? SKSpriteNode {
                if tappedCard.name == name {
                    sKSpriteNode = tappedCard
                    break
                }
            }
        }
        
            if let  sKSpriteNode = sKSpriteNode {
                return (sKSpriteNode, sKSpriteNode.name!,true)
            }else {
                return (nil, nil,false)
            }
            
    }
     
}


extension SKSpriteNode {

    func aspectFillToSize(fillSize: CGSize) {

        if texture != nil {
            self.size = texture!.size()

            let verticalRatio = fillSize.height / self.texture!.size().height
            let horizontalRatio = fillSize.width /  self.texture!.size().width

            let scaleRatio = horizontalRatio > verticalRatio ? horizontalRatio : verticalRatio

            self.setScale(scaleRatio)
        }
    }

}


extension UIViewController {
    
    func getTappedNode(_ touches: Set<UITouch> , scene:SKScene,name :String) -> (SKSpriteNode?,String?,Bool) {
        
        let tappedNodes = scene.nodes(at: touches.first!.location(in: scene))

        var sKSpriteNode : SKSpriteNode?  = nil
        
        for node in tappedNodes{

            if let tappedCard = node as? SKSpriteNode {
                if tappedCard.name == name {
                    sKSpriteNode = tappedCard
                    break
                }
            }
        }
        
            if let  sKSpriteNode = sKSpriteNode {
                return (sKSpriteNode, sKSpriteNode.name!,true)
            }else {
                return (nil, nil,false)
            }
            
    }
     
}

extension String {
    
    func getColor() -> UIColor {
        var cString:String = self.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func toInt() -> Int {
        if let n = Int(self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)) {
            return n
        } else {
            return 0
        }
    }
}


func disableTouch(view:UIView) {
    view.isUserInteractionEnabled = false
}

func enableTouch(view:UIView) {
    view.isUserInteractionEnabled = true
}



extension UIView {
    
   
    @IBInspectable var cornerRadius: CGFloat {
        get{return self.cornerRadius}
        set{self.layer.cornerRadius = newValue}
    }
    
    func addCornerRadius(_ radius: CGFloat = 4) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
    
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: -2, height: 3)
        layer.shadowRadius = 3
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
         let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
         let mask = CAShapeLayer()
         mask.path = path.cgPath
         layer.mask = mask
     }
   
    
}
 



extension UIImage {
    var averageColor: UIColor? {
        guard let inputImage = CIImage(image: self) else { return nil }
        let extentVector = CIVector(x: inputImage.extent.origin.x, y: inputImage.extent.origin.y, z: inputImage.extent.size.width, w: inputImage.extent.size.height)

        guard let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector]) else { return nil }
        guard let outputImage = filter.outputImage else { return nil }

        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [.workingColorSpace: kCFNull])
        context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: nil)

        return UIColor(red: CGFloat(bitmap[0]) / 255, green: CGFloat(bitmap[1]) / 255, blue: CGFloat(bitmap[2]) / 255, alpha: CGFloat(bitmap[3]) / 255)
    }
}
