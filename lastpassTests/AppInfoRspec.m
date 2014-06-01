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
    
    context(@"save valid value", ^{
        let(current_valid, ^{ return @"valid"; });
        
    	beforeEach(^{
        	[[AppInfo instance] store_valid:current_valid];
        });
        
        afterEach(^{
        	[[AppInfo instance] store_valid:nil];
        });
        
        it(@"should be success", ^{
        	[[[[AppInfo instance] current_valid] should] equal:current_valid];
        });
    });
    
    context(@"save pin value", ^{
        let(current_pin, ^{ return @"1234"; });
        
    	beforeEach(^{
        	[[AppInfo instance] store_pin:current_pin];
        });
        
        afterEach(^{
        	[[AppInfo instance] store_pin:nil];
        });
        
        it(@"should be success", ^{
        	[[[[AppInfo instance] current_pin] should] equal:current_pin];
        });
    });
});

SPEC_END