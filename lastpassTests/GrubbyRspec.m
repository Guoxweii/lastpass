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
        	let(url, ^{ return @"http://192.168.37.104/password.html"; });
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
});

SPEC_END