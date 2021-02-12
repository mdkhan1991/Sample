//
//  ViewController.swift
//  SampleProject
//
//  Created by King Rakib on 2/12/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(fetchSubArrayCount(array: [1,1,1,2,2,2,3,3,3,4,5,6,7], length: 3, symmetric: true))
        uploadImage(fileName: "image2x", image: UIImage())
    }


    
    
    func fetchSubArrayCount(array: [Int], length: Int, symmetric: Bool) -> Int {
        var arrayLength = stride(from: 0, to: array.count, by: 1).map {
            Array(array[$0..<[$0 + length, array.count].min()!])
        }
        let length1 = arrayLength[0].count
        let length2 = arrayLength[arrayLength.count - 1].count
        if length1 == length2 {
           
           //anil.venkatachalapathy@quest-global.com
        } else {
            arrayLength.removeLast()
        }
        for value in arrayLength {
            if value.allSatisfy({ $0 == value[0] }) {
                print("\(value) is Symmetric")
            } else {
                print("\(value) is Not Symmetric")
            }
        }
      //  print(arrayLength)
        return arrayLength.count
    }
}

func uploadImage(fileName: String, image: UIImage) {
    let url = URL(string: "URL")
    let boundary = UUID().uuidString
    let session = URLSession.shared
    var urlRequest = URLRequest(url: url!)
    urlRequest.httpMethod = "POST"
    urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
    urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
    urlRequest.setValue("xyz1232", forHTTPHeaderField: "Token")

    var data = Data()
    data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
    data.append("Content-Disposition: form-data; name=\"File.zip\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
    data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
    data.append(image.pngData()!)
    data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)

    session.uploadTask(with: urlRequest, from: data, completionHandler: { responseData, response, error in
        if error == nil {
            let jsonData = try? JSONSerialization.jsonObject(with: responseData!, options: .allowFragments)
            if let json = jsonData as? [String: Any] {
                print(json)
            }
        }
    }).resume()
}


/*
 Output:
 Sub-array 1 - "[1, 1]" is "Symmetrical" Sub-array 2 - "[1, 1]" is "Symmetrical" Sub-array 3 - "[1, 2]" is "Asymmetrical" Sub-array 4 - "[2, 2]" is "Symmetrical" Sub-array 5 - "[2, 2]" is "Symmetrical" Sub-array 6 - "[2, 3]" is "Asymmetrical" Sub-array 7 - "[3, 3]" is "Symmetrical" Sub-array 8 - "[3, 3]" is "Symmetrical" Sub-array 9 - "[3, 4]" is "Asymmetrical" Sub-array 10 - "[4, 5]" is "Asymmetrical" Sub-array 11 - "[5, 6]" is "Asymmetrical" Symmetrical sub-array count is 6
 
 
 Sub-array 1 - "[1, 1, 1]" is "Symmetrical" Sub-array 2 - "[1, 1, 2]" is "Asymmetrical" Sub-array 3 - "[1, 2, 2]" is "Asymmetrical" Sub-array 4 - "[2, 2, 2]" is "Symmetrical" Sub-array 5 - "[2, 2, 3]" is "Asymmetrical" Sub-array 6 - "[2, 3, 3]" is "Asymmetrical" Sub-array 7 - "[3, 3, 3]" is "Symmetrical" Sub-array 8 - "[3, 3, 4]" is "Asymmetrical" Sub-array 9 - "[3, 4, 5]" is "Asymmetrical" Sub-array 10 - "[4, 5, 6]" is "Asymmetrical" Symmetrical sub-array count is 3
 
 
 curl --location --request POST 'https://yourlocationtopost/path1/path2' \
 --header 'Content-Type: multipart/form-data' \
 --header 'Accept: application/json' \
 --header 'Token: xyz1232' \
 --form 'icon=@"/Users/icon_512x512.png"' \
 --form 'icon_2x=@"/Users/image2x.png"' \
 --form 'packageDisplayName="File.zip"' \
 --form 'file=@"/Users/afile.zip"'
 
 */

