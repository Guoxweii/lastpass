#import <Kiwi/Kiwi.h>
#import "SearchViewController.h"
#import "grubby.h"

SPEC_BEGIN(SearchViewControllerRspec)

describe(@"SearchViewController", ^{
    
    SearchViewController *searchCtr = [[SearchViewController alloc] initWithNibName:@"SearchViewController" bundle:nil];
	
    afterEach(^{ [[Grubby instance] resetDataSource]; });
    
    context(@"string judge equal", ^{
        let(mainString, ^{ return @"http://google.com.hk/account/login?jashdf=asdf"; });
        let(validSubString, ^{ return @"gOOgle"; });
        let(unvalidSubString, ^{ return @"baidu"; });

        it(@"should return yes is contained", ^{
			BOOL result = [searchCtr judgeString:mainString containSubstring:validSubString];
            [[theValue(result) should] beYes];
        });
        
        it(@"should return no is contained", ^{
			BOOL result = [searchCtr judgeString:mainString containSubstring:unvalidSubString];
            [[theValue(result) should] beNo];
        });
    });
    
    context(@"search from text", ^{
        let(passInfo, ^{
        	return @"url,username,password,extra,name,grouping,fav\nhttps://58.196.13.4,gxw,123asdfasdf456,,58.196.13.4,bStar,0\nhttps://accounts.google.com,alphaguoxiongwei＠gmail.com,123456,,google账户,个人,0\nhttp://mail.b-star.cn,xwguo@b-star.cn,IUgasdfasdf,,公司办公邮箱,bStar,0\nhttps://github.com,alphaguoxiongwei@gmail.com,tasdfasdftVGr8C,,github账户,个人,0\nhttp://tieba.baidu.com,littleluren,viRIZsdfa1Su2,,百度账户,个人,0";
        });
        
        beforeEach(^{
            [searchCtr viewDidLoad];
            [[Grubby instance] parse:passInfo];
        });
        
        context(@"with search:google", ^{
        	let(searchText, ^{ return @" gOOgle "; });
            beforeEach(^{ [searchCtr searchBar:nil textDidChange:@" GooGLE "]; });

            it(@"should return success value", ^{
                NSInteger number = [[searchCtr result] count];
                [[theValue(number) should] equal:theValue(1)];
            });
        });
    });
});

SPEC_END