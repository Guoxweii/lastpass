#import <Kiwi/Kiwi.h>
#import "Grubby.h"

SPEC_BEGIN(GrubbyRspec)

describe(@"Grubby", ^{
	context(@"instance", ^{
    
        it(@"should be unique", ^{
        	[[[Grubby instance] should] equal:[Grubby instance]];
        });
    });
    
    context(@"fetch html from url", ^{
        let(mainCtr, ^{ return [MainViewController mock]; });
        
    
        it(@"mainCtr should be subclass of MainViewController", ^{
        	[[mainCtr should] beMemberOfClass:[MainViewController class]];
        });
        
        context(@"with invalid url", ^{
        	let(url, ^{ return @"htssdf://123"; });
			beforeEach(^{
                [mainCtr stub:@selector(showErrorWithInvalidUrl)];
                
                [[Grubby instance] setMainCtr:mainCtr];
                [[Grubby instance] fetch_remote_html:url];
            });
            
            it(@"should be wrong", ^{
                [[[mainCtr should] receive] showErrorWithInvalidUrl];
            });
        });
        
        context(@"with valid url", ^{
        	
        });
    });
});

SPEC_END