#import <Kiwi/Kiwi.h>
#import "Grubby.h"
#import "appinfo.h"

SPEC_BEGIN(GrubbyRspec)

describe(@"Grubby", ^{
    id mainCtr = [MainViewController mock];
    Grubby *grubbyInstance = [Grubby instance];
    
    beforeEach(^{
        [Grubby stub:@selector(instance) andReturn:grubbyInstance];
    });
	context(@"instance", ^{
        it(@"should be unique", ^{
        	[[[Grubby instance] should] equal:grubbyInstance];
        });
    });
    
    context(@"fetch html from url", ^{
        
        it(@"mainCtr should be subclass of MainViewController", ^{
        	[[mainCtr should] beMemberOfClass:[MainViewController class]];
        });
        
        context(@"with invalid url", ^{
        	let(url, ^{ return @"htssdf?:"; });
            
            it(@"should be wrong", ^{
                [[[mainCtr should] receive] showErrorWithInvalidUrl];
                [[Grubby instance] stub:@selector(mainCtr) andReturn:mainCtr];
                [[Grubby instance] fetch_remote_html:url];
            });
        });
        
        context(@"with valid and nouseufl url", ^{
        	let(url, ^{ return @"http://www.baidu.com"; });
            
            it(@"should be wrong", ^{
                [[[mainCtr should] receive] showErrorWithInvalidUrl];
                [[Grubby instance] stub:@selector(mainCtr) andReturn:mainCtr];
                [[Grubby instance] fetch_remote_html:url];
            });
        });
        
        context(@"with valid and useful url", ^{
        	let(url, ^{ return @"http://127.0.0.1/password.html"; });
            beforeEach(^{ [[Grubby instance] fetch_remote_html:url]; });
            afterEach(^{ [[Grubby instance] resetDataSource]; });
            
            it(@"will have datasource", ^{
				[[[Grubby instance].dataSource shouldNot] beEmpty];
            });
            
            it(@"will have cache", ^{
            	[[[[AppInfo instance] current_password_info] shouldNot] beNil];
            });
        });
    });
    
    context(@"parse string", ^{
    	NSString *passInfo = @"url,username,password,extra,name,grouping,fav\nhttps://58.196.13.4,gxw,123asdfasdf456,,58.196.13.4,bStar,0\nhttps://accounts.google.com,alphaguoxiongwei＠gmail.com,123456,,google账户,个人,0\nhttp://mail.b-star.cn,xwguo@b-star.cn,IUgasdfasdf,,公司办公邮箱,bStar,0\nhttps://github.com,alphaguoxiongwei@gmail.com,tasdfasdftVGr8C,,github账户,个人,0\nhttp://tieba.baidu.com,littleluren,viRIZsdfa1Su2,,百度账户,个人,0";
        
        beforeEach(^{ [[Grubby instance] parse:passInfo]; });
        
        afterEach(^{ [[Grubby instance] resetDataSource]; });
        
        it(@"should datasource not empty", ^{
        	[[[Grubby instance].dataSource shouldNot] beEmpty];
        });
        
        it(@"should datasource have 2 keys", ^{
        	[[[[[Grubby instance].dataSource allKeys] should] have:2] items];
        });
        
        it(@"should datasource bStar have 2 items", ^{
        	[[[[[Grubby instance].dataSource objectForKey:@"bStar"] should] have:2] items];
        });
    });
});

SPEC_END