#import <Kiwi/Kiwi.h>
#import "AppInfo.h"

SPEC_BEGIN(AppInfoRspec)

describe(@"AppInfo", ^{
	context(@"instance", ^{
        
        it(@"should be unique", ^{
        	[[[AppInfo instance] should] equal:[AppInfo instance]];
        });
    });
    
    context(@"save data", ^{
        let(current_info, ^{ return @"gxw;123;456"; });
    	
        beforeEach(^{
        	[[AppInfo instance] store_password_info:current_info];
        });
        
        afterEach(^{
        	[[AppInfo instance] store_password_info:nil];
        });
        
        
        it(@"should be success", ^{
        	[[[[AppInfo instance] current_password_info] should] equal:current_info];
        });
    });
});

SPEC_END