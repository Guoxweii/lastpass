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
    });
});

SPEC_END