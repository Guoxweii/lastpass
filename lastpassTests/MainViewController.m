#import <Kiwi/Kiwi.h>
#import "MainViewController.h"

SPEC_BEGIN(simpleStringRspec)

describe(@"MainViewController", ^{
	context(@"view", ^{
		MainViewController *mainCtr = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
        
        it(@"have url textfield", ^{
        	[[[mainCtr.view.subviews should] have:1] urlField];
        });
    });
});

SPEC_END