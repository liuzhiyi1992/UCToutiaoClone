<h1 align="center">
ZYLocationManager  
<h5 align="center", style="color, #666">
ZYLocationManager make requesting location information base on MKMapKit any time conveniently.    
<br>
让你在任何时候非常方便地请求地图位置信息。  
</h5>
</h1>
<p align="center">


</p>
<br>
<br>


#**Summary：**  
ZYLocationManager工作基于单例，但它支持多个发起者多个请求同时处理，同时反馈，失败重试。

<br>
<br>

#**Usage：**  
```- (void)getLocationCoordinate:(id)sponsor complete:(LocationCompleteBlock)completeBlock;```  
```- (void)getCity:(id)sponsor complete:(CityCompleteBlock)completeBlock;```  
<br>
使用ZYLocationManager单例对象发起地图定位信息请求，一般传入发起者controller引用：
```objc
__weak __typeof(self) weakSelf = self;
[[ZYLocationManager shareManager] getLocationCoordinate:weakSelf complete:^(CLLocationCoordinate2D location, NSError *error) {
    //do something
}];
```  

利用block携带的参数信息:
```objc
__weak __typeof(self) weakSelf = self;
[[ZYLocationManager shareManager] getLocationCoordinate:weakSelf complete:^(CLLocationCoordinate2D location, NSError *error) {
    if (nil == error) {
        //do something
    } else {
        //verify authority
        authorityBlock(error, weakSelf);
    }
}];
```
若有error信息，把它交给authorityBlock，内部会做两种处理:  
1.error原因为无权限，弹出AlertView询问用户是否跳转应用权限设置页做更改操作(需要在发起者遵守UIAlertViewDelegate，并实现响应的代理方法)  
2.error为其他原因(信号不好，请求错误等)，触发自动重试，默认为1秒，直至发起者的生命周期结束  



