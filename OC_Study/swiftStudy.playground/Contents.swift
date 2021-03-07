import UIKit

var str = "Hello, playground"
// 可选值类型 ？ 强制解包 ！ 解包为nil的对象会崩溃
var myString:String? = "xYZ"
if myString != nil {
    print("myString为\(myString!)")
//   不加！打印 myString为Optional("xxx")
//   加上 ！ myString为xxx
}else{
    print("myString为nil")
}
// 字符类型
var charect:Character = "A"
// 遍历字符串中的字符
for ch in myString! {
    print(ch)
}
// 遍历 0-5（包含5）
for i in 0...5 {
    print(i)
}
// 遍历0-5 不包含5
for i in 0..<5 {
    print(i)
}
// 循环
repeat {
    print("先走一次再判断条件")
}while 2<0

var string = "您好"
myString!+=string
print(myString!)

//var myArray = [Int]()
var myArray = [Int](repeating: 0, count: 3)
myArray = [10,20,30]
myArray.append(40)

var myDic = [Int:String]()
myDic[1] = "123"
// 遍历字典
for (key,value) in myDic {
    print("字典key为\(key),value为\(value)")
}

func myFuncation(number:Int) -> (String) {
    var str = ""
    str = "\(number)"
    return str
}

let maxInt = {(number1:Int,number2:Int) -> Int in
    return number1>number2 ? number1 :number2
}
// 可选链
if let str = myString {
    print("如果myString不为nil，打印\(str)")
}else{
    print("myString为nil，不能输出")
}















