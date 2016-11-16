# -*- coding: utf-8 -*-

import os,re

print "常用命令："
print "添加私有仓库：  pod repo add CNSpecs https://coding.net/wtlucky/WTSpecs.git"
print "创建类库工程：  pod lib create xxlib"
print "移除私有仓库：  pod repo remove CNSpecs"
print "推送工程到仓库：pod repo push CNSpecs PodTestLibrary.podspec"

SPECNAME="CNSpecs"
print "\n正在推送当前仓库："+SPECNAME
if __name__ == '__main__':
    output = os.popen('git tag')
    text=output.read()
    arr=text.split('\n')
    arr.pop(len(arr)-1)
    #版本号排序
    arr.sort(key=lambda x:tuple(int(v) for v in x.split(".")))
    arr.reverse()
    print "版本号排序后:"
    print arr
    length=len(arr)
    tag=arr[0]
    print tag
    if len(tag) >= 0:
        #生成新版本号
        versionArray=tag.split('.')
        v1=versionArray[0]
        v2=versionArray[1]
        v3=versionArray[2]
        if v3=='100':
            if v2=='100':
                versionArray[0]=(str)((int)(versionArray[0])+1)
                versionArray[1]='0'
                versionArray[2]='0'
            else:
                versionArray[1]=(str)((int)(versionArray[1])+1)
                versionArray[2]='0'
        else:
            versionArray[2]=(str)((int)(versionArray[2])+1)
        new_version=versionArray[0]+'.'+versionArray[1]+'.'+versionArray[2]
        print "1.新版本号："+new_version
        #查找podspec文件
        op1=os.popen('ls *.podspec')
        fileName=op1.read()
        fileName=fileName.replace('\n','')
        #校验pods描述文件是否正确
        print "2.校验pod文件中"
        op2=os.popen('pod lib lint --sources=https://github.com/cheneylew/cocoapods-specs.git,https://github.com/CocoaPods/Specs.git --allow-warnings')
        text1=op2.read()
        print text1
        if 'passed validation' in text1:
            print "校验通过"
            #读取仓库文件
            f=open(fileName,'r')
            content=f.read()
            version_re=re.compile('= \'\d+\.\d+\.\d+')
            new_content=version_re.sub('= \''+new_version,content)
            f.close()
            #写入版本号
            file_object = open(fileName, 'w')
            file_object.write(new_content)
            file_object.close()
            #推送本地文件到远程
            print "3.推送本地文件到远程"
            os.system('git add *')
            os.system('git commit -m "更新组件'+new_version+'"')
            os.system("git push origin master")
            #打tag
            print "4.打tag"
            os.system('git tag -m "" '+new_version)
            os.system('git push --tags')
            #更新仓库
            print "5.更新"+SPECNAME+"仓库"
            os.system('pod repo push '+SPECNAME+' '+fileName+' --allow-warnings')
            os.system('pod repo update')
            print "完毕。。。"
        else:
            print "校验失败，检查pods文件"
