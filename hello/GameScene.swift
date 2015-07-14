//
//  GameScene.swift
//  hello
//
//  Created by mq on 7/14/15.
//  Copyright (c) 2015 joe. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var planeTexture = SKTexture(imageNamed: "Spaceship")//可以在Images.xcassets中找到默认飞船图片
    var plane:SKSpriteNode!
    var isTouched = false
    
    var bulletTime:NSTimeInterval = 0.15//子弹发射间隔
    var boneTime:NSTimeInterval = 1
    var lastTime:NSTimeInterval = 0//上次发射的时间点

    
    override func didMoveToView(view: SKView) {

        plane = SKSpriteNode(texture: planeTexture)
        //var plane = SKSpriteNode(imageNamed: "Spaceship")//可以在Assets中找到默认飞船图片
        plane.position = CGPointMake(size.width * 0.5,size.height * 0.5)//self是指当前场景，左下角
        plane.name = "plane"
        self.addChild(plane) //添加精灵到场景中
        
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        let location:CGPoint! = (touches as NSSet).anyObject()?.locationInNode(self)
        var node = self.nodeAtPoint(location)
        if node.name == "plane"{
            //you choose the plane
            isTouched = true// 手指点击到飞机
        }

    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent?) {
        if isTouched {
            var location:CGPoint! = (touches as NSSet).anyObject()?.locationInNode(self)
            self.plane.position = CGPointMake(location.x, location.y)
        }
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent?) {
        isTouched = false
    }
    
    
    func createbone()
    {
        var xstart = random() * size.width
        var bone = SKShapeNode(rectOfSize: CGSizeMake(20, 20))
        bone.position = CGPointMake(xstart, size.height)
        bone.strokeColor = UIColor.clearColor()
        bone.fillColor = UIColor.greenColor()
        addChild(bone)
        bone.runAction(SKAction.sequence([SKAction.moveByX(0, y: -size.height, duration: 3), SKAction.removeFromParent()]))
    }
    
    
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    
    func random(#min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
    
    func sendBullet()
    {
        var bullet = SKShapeNode(rectOfSize: CGSizeMake(10, 10))
        bullet.position = CGPointMake(plane.position.x, plane.position.y + 50)
        bullet.strokeColor = UIColor.clearColor()
        bullet.fillColor = UIColor.yellowColor()
        self.addChild(bullet)
        bullet.runAction(SKAction.sequence([SKAction.moveByX(0, y:size.height, duration: 2), SKAction.removeFromParent()]))
    }
    
    func sendBulletTwo()
    {
        var bullet = SKShapeNode(rectOfSize: CGSizeMake(10, 10))
        bullet.position = CGPointMake(plane.position.x - 10, plane.position.y + 50)
        bullet.strokeColor = UIColor.clearColor()
        bullet.fillColor = UIColor.yellowColor()
        self.addChild(bullet)
        bullet.runAction(SKAction.sequence([SKAction.moveByX(-100, y:size.height, duration: 2), SKAction.removeFromParent()]))
        
        var bullet2 = SKShapeNode(rectOfSize: CGSizeMake(10, 10))
        bullet2.position = CGPointMake(plane.position.x + 10, plane.position.y + 50)
        bullet2.strokeColor = UIColor.clearColor()
        bullet2.fillColor = UIColor.yellowColor()
        self.addChild(bullet2)
        bullet2.runAction(SKAction.sequence([SKAction.moveByX(+100, y:size.height, duration: 2), SKAction.removeFromParent()]))
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        if(currentTime >= lastTime + bulletTime){
            //创建子弹....
            if(random() > 0.5)
            {
                sendBulletTwo()
            }
            else
            {
                sendBullet()
            }
            if (random() > 0.35)
            {
                createbone()
            }
            lastTime = currentTime
        }

    }
}
