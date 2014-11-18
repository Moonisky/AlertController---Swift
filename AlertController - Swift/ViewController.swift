//
//  ViewController.swift
//  AlertController - Swift
//
//  Created by Semper Idem on 14-11-19.
//  Copyright (c) 2014年 星夜暮晨. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBAction func Btn_UIAlertView_DefaultStyle(sender: UIButton) {
        //常规对话框，最简单的UIAlertView使用方法
        var alertView = UIAlertView()
        
        alertView.delegate = self
        alertView.title = "常规对话框"
        alertView.message = "常规对话框风格"
        alertView.addButtonWithTitle("取消")
        alertView.addButtonWithTitle("确定")
        
        alertView.show()
        
        //只有一个按钮的swift初始化
//        var alertView = UIAlertView(title: "常规对话框", message: "常规对话框风格", delegate: self, cancelButtonTitle: "取消")
//        alertView.show()
    }
    
    @IBAction func Btn_UIAlertView_PlainTextStyle(sender: UIButton) {
        //文本对话框，带有一个文本框
        var alertView = UIAlertView()
        
        alertView.delegate = self
        alertView.title = "文本对话框"
        alertView.message = "请输入文字："
        alertView.addButtonWithTitle("取消")
        alertView.addButtonWithTitle("确定")
        alertView.alertViewStyle = UIAlertViewStyle.PlainTextInput
        
        alertView.show()
    }
    
    @IBAction func Btn_UIAlertView_SecureTextStyle(sender: UIButton) {
        //密码对话框，带有一个拥有密码安全保护机制的密码文本框
        var alertView = UIAlertView()
        
        alertView.delegate = self
        alertView.title = "密码对话框"
        alertView.message = "请输入密码："
        alertView.addButtonWithTitle("取消")
        alertView.addButtonWithTitle("确定")
        alertView.alertViewStyle = UIAlertViewStyle.SecureTextInput
        
        alertView.show()
    }
    
    @IBAction func Btn_UIAlertView_LoginAndPasswordStyle(sender: UIButton) {
        //登录对话框，仿照登录框的效果制作，拥有两个文本框，其中一个是密码文本框
        var alertView = UIAlertView()
        
        alertView.delegate = self
        alertView.title = "登录对话框"
        alertView.message = "请输入用户名和密码："
        alertView.addButtonWithTitle("取消")
        alertView.addButtonWithTitle("登录")
        alertView.alertViewStyle = UIAlertViewStyle.LoginAndPasswordInput
        
        alertView.show()
    }
    
    @IBAction func Btn_UIAlertController_BasicAlertStyle(sender: UIButton) {
        //基本对话框，使用iOS 8新建的UIAlertController类，同UIAlertView的常规对话框相同
        var alertController = UIAlertController(title: "基本对话框", message: "带有基本按钮的对话框", preferredStyle: UIAlertControllerStyle.Alert)
        
        var cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
        var okAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.Default, handler: nil)
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    @IBAction func Btn_UIAlertController_DestructiveActions(sender: UIButton) {
        //重置对话框，带有一个醒目的“毁坏”样式的按钮
        var alertController = UIAlertController(title: "重置对话框", message: "带有“毁坏”样式按钮的对话框", preferredStyle: UIAlertControllerStyle.Alert)
        
        var resetAction = UIAlertAction(title: "重置", style: UIAlertActionStyle.Destructive, handler: nil)
        var cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
        
        alertController.addAction(resetAction)
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    @IBAction func Btn_UIAlertController_LoginAndPasswordStyle(sender: UIButton) {
        //登录对话框，必须要输入3个字符以上才能激活“登录”按钮，会调用alertTextFieldDidChange:函数
        var alertController = UIAlertController(title: "登录对话框", message: "请输入用户名或密码：", preferredStyle: UIAlertControllerStyle.Alert)
        
        alertController.addTextFieldWithConfigurationHandler { (textField: UITextField!) -> Void in
            textField.placeholder = "用户名"
            NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("alertTextFieldDidChange:"), name: UITextFieldTextDidChangeNotification, object: textField)
        }
        
        alertController.addTextFieldWithConfigurationHandler { (textField: UITextField!) -> Void in
            textField.placeholder = "密码"
            textField.secureTextEntry = true
        }
        
        var cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel) { (action: UIAlertAction!) -> Void in
            NSNotificationCenter.defaultCenter().removeObserver(self, name: UITextFieldTextDidChangeNotification, object: nil)
        }
        
        var loginAction = UIAlertAction(title: "登录", style: UIAlertActionStyle.Default) { (action: UIAlertAction!) -> Void in
            NSNotificationCenter.defaultCenter().removeObserver(self, name: UITextFieldTextDidChangeNotification, object: nil)
        }
        
        loginAction.enabled = false
        
        alertController.addAction(cancelAction)
        alertController.addAction(loginAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func alertTextFieldDidChange(notification: NSNotification){
        var alertController = self.presentedViewController as UIAlertController?
        
        if alertController != nil {
            var login = alertController!.textFields?.first as UITextField
            var loginAction = alertController!.actions.last as UIAlertAction
            loginAction.enabled = countElements(login.text) > 2
        }
    }
    
    @IBAction func Btn_UIAlertController_ActionSheet(sender: UIButton) {
        //上拉菜单，使用UIPopoverPresentationController来防止iPad上运行时异常
        var alertController = UIAlertController(title: "保存或删除数据", message: "注意：删除操作无法恢复！", preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        var cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
        var deleteAction = UIAlertAction(title: "删除", style: UIAlertActionStyle.Destructive, handler: nil)
        var archiveAction = UIAlertAction(title: "保存", style: UIAlertActionStyle.Default, handler: nil)
        
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        alertController.addAction(archiveAction)
        
        var popover = alertController.popoverPresentationController
        if popover != nil {
            popover?.sourceView = sender
            popover?.sourceRect = sender.bounds
            popover?.permittedArrowDirections = UIPopoverArrowDirection.Any
        }
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

