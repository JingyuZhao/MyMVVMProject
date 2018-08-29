//
//  DrawView.m
//  MyMVVMProject
//
//  Created by winbei on 2018/8/27.
//  Copyright © 2018年 HelloWorld_1986. All rights reserved.
//

#import "DrawView.h"

@implementation DrawView
- (instancetype)init{
    if (self = [super init]) {
        NSLog(@"%@", NSStringFromClass([self class]));
        NSLog(@"%@", NSStringFromClass([super class]));
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        NSLog(@"%@", NSStringFromClass([super class]));
        NSLog(@"%@", NSStringFromClass([self class]));
    }
    return self;
}
- (void)drawRect:(CGRect)rect {
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
//    [self drawRectWithContext:context];
//    [self drawRectByUIKitWith:context];
//    [self drawEllipse:context];
//    [self drawArc:context];
//    [self drawCurve:context];
//    [self drawText:context];
//    [self drawImage:context];
//    [self drawLineGradient:context];
//    [self drawRadialGradient:context];
//    [self drawRectWithLinearGradientFill:context];
    [self drawRectWithLinearGradientFill:context];
    
}
-(void)drawLine1{
    //1.获取上下文对象
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //2.创建路径对象
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, 20, 50);//移动到指定位置（设置路径起点）
    CGPathAddLineToPoint(path, nil, 20, 100);//绘制直线（从起始位置开始）
    CGPathAddLineToPoint(path, nil, 300, 100);//绘制另外一条直线（从上一直线终点开始绘制
    
    
    //3.将路径添加到图形上下文
    CGContextAddPath(context, path);
    
    //4.设置图形上下文的状态属性
    CGContextSetRGBStrokeColor(context, 1.0, 0, 1.0, 1.0);//设置笔触颜色
    CGContextSetRGBFillColor(context, 0, 1.0, 0, 1);//设置填充色
    CGContextSetLineWidth(context, 2.0);//设置线条宽度
    CGContextSetLineCap(context, kCGLineCapSquare);//设置顶点样式,（20,50）和（300,100）是顶点
    CGContextSetLineJoin(context, kCGLineJoinMiter);//设置连接点样式，(20,100)是连接点
    
    /*
     设置线段的样式
     虚线开始的位置
     lengths：虚线长度间隔（例如下面的定义说明第一条线段长度8，然后间隔3重新绘制8点的长度线段，当然这个数组可以定义更多元素）
     count：虚线数组元素个数
     */
    //    CGFloat lengths[2] = {10,5};
    //    CGContextSetLineDash(context, 0, lengths, 2);
    /*
     设置阴影
     context：上下文
     offset：偏移量
     blur：模糊度
     color：阴影颜色
     */
    CGColorRef color = [UIColor blueColor].CGColor;
    CGContextSetShadowWithColor(context, CGSizeMake(10, 5), 0.03, color);
    
    //5.绘制图像到指定图形上下文
    /*CGPathDrawingMode是填充方式,枚举类型
     kCGPathFill:只有填充（非零缠绕数填充），不绘制边框
     kCGPathEOFill:奇偶规则填充（多条路径交叉时，奇数交叉填充，偶交叉不填充）
     kCGPathStroke:只有边框
     kCGPathFillStroke：既有边框又有填充
     kCGPathEOFillStroke：奇偶填充并绘制边框
     */
    CGContextDrawPath(context, kCGPathStroke);//最后一个参数是填充类型
    
    //6.释放对象
    CGPathRelease(path);
}
-(void)drawLine2{
    //1.获得图形上下文
    CGContextRef context=UIGraphicsGetCurrentContext();
    
    //2.绘制路径（相当于前面创建路径并添加路径到图形上下文两步操作）
    CGContextMoveToPoint(context, 20, 50);
    CGContextAddLineToPoint(context, 20, 100);
    CGContextAddLineToPoint(context, 300, 100);
    //封闭路径:a.创建一条起点和终点的线,不推荐
    //CGPathAddLineToPoint(path, nil, 20, 50);
    //封闭路径:b.直接调用路径封闭方法
    CGContextClosePath(context);
    
    //3.设置图形上下文属性
    [[UIColor redColor]setStroke];//设置红色边框
    [[UIColor greenColor]setFill];//设置绿色填充
    //[[UIColor blueColor]set];//同时设置填充和边框色
    
    //4.绘制路径
    CGContextDrawPath(context, kCGPathFillStroke);

}

/**
 绘制矩形

 @param context 图形上下文
 */
-(void)drawRectWithContext:(CGContextRef )context{
    //添加举行对象
    CGRect rect = CGRectMake(10, 30, 100, 40);
    CGContextAddRect(context, rect);
    [[UIColor blueColor] set];
    CGContextDrawPath(context, kCGPathStroke);
}

/**
 绘制矩形

 @param context 利用UIKit的相关api进行绘制
 */
-(void)drawRectByUIKitWith:(CGContextRef )context{
    CGRect rect= CGRectMake(20, 150, 280.0, 50.0);
    CGRect rect2=CGRectMake(20, 250, 280.0, 50.0);
    //设置属性
    [[UIColor yellowColor]set];
    //绘制矩形,相当于创建对象、添加对象到上下文、绘制三个步骤
    UIRectFill(rect);//绘制矩形（只有填充）
    
    [[UIColor redColor]setStroke];
    UIRectFrame(rect2);//绘制矩形(只有边框)

}

/**
 绘制椭圆形

 @param context 上下文
 */
-(void)drawEllipse:(CGContextRef )context{
    CGRect rect = CGRectMake(50, 50, 280, 200);
    CGContextAddEllipseInRect(context, rect);
    //设置属性
    [[UIColor purpleColor] set];
    CGContextDrawPath(context, kCGPathFill);
}
/**
 弧形绘制

 @param context 上下文
 */
-(void)drawArc:(CGContextRef)context{
    /*添加弧形对象
     x：中心点x坐标
     y：中心点y坐标
     radius：半径
     startAngle：起始弧度
     endAngle：终止弧度
     closewise：是否逆时针绘制，0则顺时针绘制
     */
    
    CGContextAddArc(context, 100, 100, 100, 0.0, M_PI*2, 0);
    CGContextSetLineWidth(context, 5);
    [[UIColor redColor] set];
    
    CGContextDrawPath(context, kCGPathStroke);
    
}

/**
 绘制贝塞尔曲线

 @param context 上下文
 */
-(void)drawCurve:(CGContextRef )context{
    //绘制曲线
    CGContextMoveToPoint(context, 20, 100);
    /*
     绘制二次贝塞尔曲线
     c：图形上下文
     cpx：控制点x坐标
     cpy：控制点y坐标
     x：结束点x坐标
     y：结束点y坐标
     */
    CGContextAddQuadCurveToPoint(context, 160, 0, 300, 100);

    
    CGContextMoveToPoint(context, 20, 500);
    /*绘制三次贝塞尔曲线
     c:图形上下文
     cp1x:第一个控制点x坐标
     cp1y:第一个控制点y坐标
     cp2x:第二个控制点x坐标
     cp2y:第二个控制点y坐标
     x:结束点x坐标
     y:结束点y坐标
     */
    CGContextAddCurveToPoint(context, 80, 300, 240, 500, 300, 300);
    
    //设置图形上下文属性
    [[UIColor yellowColor]setFill];
    [[UIColor redColor]setStroke];
    
    //绘制路径
    CGContextDrawPath(context, kCGPathFillStroke);

    
}

/**
 绘制文字到指定区域

 @param context 上下文
 */
-(void)drawText:(CGContextRef )context{
    //绘制到指定的区域内容
    NSString *str=@"Star Walk is the most beautiful stargazing app you’ve ever seen on a mobile device. It will become your go-to interactive astro guide to the night sky, following your every movement in real-time and allowing you to explore over 200, 000 celestial bodies with extensive information about stars and constellations that you find.";
    CGRect rect= CGRectMake(20, 50, 280, 300);
    UIFont *font=[UIFont systemFontOfSize:18];//设置字体
    UIColor *color=[UIColor redColor];//字体颜色
    NSMutableParagraphStyle *style=[[NSMutableParagraphStyle alloc]init];//段落样式
    NSTextAlignment align=NSTextAlignmentLeft;//对齐方式
    style.alignment=align;
    [str drawInRect:rect withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:color,NSParagraphStyleAttributeName:style}];
}

/**
 图片绘制

 @param context 上下文
 */
-(void)drawImage:(CGContextRef )context{
    UIImage *test = [UIImage imageNamed:@"test"];
    //从某个点开始绘制
//    [test drawAtPoint:CGPointMake(100, 100)];
    //绘制到指定的矩形中，注意如果大小不合适会会进行拉伸
    [test drawInRect:CGRectMake(10, 10, 300, 290)];
    //平铺绘制
//    [test drawAsPatternInRect:CGRectMake(0, 0, 320, 568)];
}
/**
 //绘制渐变色填充

 @param context Quartz 2D的渐变方式分为两种：
 线性渐变线：渐变色以直线方式从开始位置逐渐向结束位置渐变
 径向渐变：以中心点为圆心从起始渐变色向四周辐射，直到终止渐变色
 */
-(void)drawLineGradient:(CGContextRef )context{
    //绘制渐变色的时候要指定颜色空间.这里指定使用的是rgb
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    /*
     指定渐变色
     space:颜色空间
     components：颜色数组，注意由于指定了RGB的颜色空间，
     那么四个数组元素表示一个颜色（red、green、blue、alpha），如果有三个颜色则这个数组有4*3个元素
     locations：颜色所在位置（范围0～1），这个数组的个数不小于components中存放颜色的个数
     count：渐变个数，等于locations个数
     */
    CGFloat compoents[12] = {
        248.0/255.0,86.0/255.0,86.0/255.0,1,
        249.0/255.0,127.0/255.0,127.0/255.0,1,
        1.0,1.0,1.0,1.0
    };
    CGFloat locations[3] = {0,0.6,1.0};
    
    CGGradientRef gradient= CGGradientCreateWithColorComponents(colorSpace, compoents, locations, 3);
    
    /*绘制线性渐变
     context:图形上下文
     gradient:渐变色
     startPoint:起始位置
     endPoint:终止位置
     options:绘制方式,kCGGradientDrawsBeforeStartLocation 开始位置之前就进行绘制，到结束位置之后不再绘制，
     kCGGradientDrawsAfterEndLocation开始位置之前不进行绘制，到结束点之后继续填充
     */
    CGContextDrawLinearGradient(context, gradient, CGPointZero, CGPointMake(320, 300), kCGGradientDrawsAfterEndLocation);
    //释放颜色空间
    CGColorSpaceRelease(colorSpace);
}
-(void)drawRadialGradient:(CGContextRef )context{
    //使用rgb颜色空间
    CGColorSpaceRef colorSpace=CGColorSpaceCreateDeviceRGB();
    
    /*指定渐变色
     space:颜色空间
     components:颜色数组,注意由于指定了RGB颜色空间，那么四个数组元素表示一个颜色（red、green、blue、alpha），
     如果有三个颜色则这个数组有4*3个元素
     locations:颜色所在位置（范围0~1），这个数组的个数不小于components中存放颜色的个数
     count:渐变个数，等于locations的个数
     */
    CGFloat compoents[12]={
        248.0/255.0,86.0/255.0,86.0/255.0,1,
        249.0/255.0,127.0/255.0,127.0/255.0,1,
        1.0,1.0,1.0,1.0
    };
    CGFloat locations[3]={0,0.5,1.0};
    CGGradientRef gradient= CGGradientCreateWithColorComponents(colorSpace, compoents, locations, 3);
    
    /*绘制径向渐变
     context:图形上下文
     gradient:渐变色
     startCenter:起始点位置
     startRadius:起始半径（通常为0，否则在此半径范围内容无任何填充）
     endCenter:终点位置（通常和起始点相同，否则会有偏移）
     endRadius:终点半径（也就是渐变的扩散长度）
     options:绘制方式,kCGGradientDrawsBeforeStartLocation 开始位置之前就进行绘制，但是到结束位置之后不再绘制，
     kCGGradientDrawsAfterEndLocation开始位置之前不进行绘制，但到结束点之后继续填充
     */
    CGContextDrawRadialGradient(context, gradient, CGPointMake(160, 284),0, CGPointMake(165, 289), 150, kCGGradientDrawsAfterEndLocation);
    //释放颜色空间
    CGColorSpaceRelease(colorSpace);
    
}

/**
 渐变填充

 @param context 上面我们只是绘制渐变到图形上下文，实际开发中有时候我们还需要填充对应的渐变色，例如现在绘制了一个矩形，如何填充成渐变色呢？在此可以利用渐变裁切来完成（当然利用层CALayer更加方便但这不在今天的话题讨论范围内），特别说明一下区域裁切并不仅仅适用于渐变填充，对于其他图形绘制仍然适用，并且注意裁切只能限于矩形裁切。
 */
-(void)drawRectWithLinearGradientFill:(CGContextRef )context{
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    //裁切处一块矩形用于显示，注意必须先裁切再调用渐变
    CGContextClipToRect(context, CGRectMake(20, 50, 280, 300));
    //裁切还可以使用UIKit中对应的方法
//    UIRectClip(CGRectMake(20, 50, 280, 300));
    CGFloat compoents[12] = {
        248.0/255.0,86.0/255.0,86.0/255.0,1,
        249.0/255.0,127.0/255.0,127.0/255.0,1,
        1.0,1.0,1.0,1.0
    };
    
    CGFloat location[3] = {0.0,0.6,1.0};
    
    CGGradientRef gradient = CGGradientCreateWithColorComponents(space, compoents, location, 3);
    CGContextDrawLinearGradient(context, gradient, CGPointMake(20, 50), CGPointMake(300, 300), kCGGradientDrawsBeforeStartLocation);
    
    CGColorSpaceRelease(space);

    
}
@end
