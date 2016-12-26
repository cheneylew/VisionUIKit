# XMAdScrollView
无线轮播器，支持重用，旋转，数据模型可自定义


使用方法

pod 'XMAdScrollView'

手动配置

XMAdScrollView.h XMAdScrollView.m 拖到项目中即可



    //1.创建view
    XMAdScrollView * view = [[XMAdScrollView alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, 200)];
    //2.添加到父view上去
    [self.view addSubview:view];

    ItemModel * model1 = [[ItemModel alloc] init];
    model1.itemImgURL = @"http://h.hiphotos.bdimg.com/album/w%3D2048/sign=69b2037aca1349547e1eef6462769358/d000baa1cd11728b707d37d9c9fcc3cec2fd2cfc.jpg";

    ItemModel * model2 = [[ItemModel alloc] init];
    model2.itemImgURL = @"http://img.pconline.com.cn/images/upload/upc/tx/photoblog/1402/20/c1/31413055_1392883861493_mthumb.jpg";

    ItemModel * model3 = [[ItemModel alloc] init];
    model3.itemImgURL = @"http://pic15.nipic.com/20110621/2678842_143658366148_2.jpg";

    //3.设置数据数据，数据模型可自定义
    view.itemDataArray = @[model1,model2,model3];
