#line 1 "Tweak.xm"




































@interface MZRootViewController: UIViewController

@end



#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

@class MZRootViewController; 
static void (*_logos_orig$_ungrouped$MZRootViewController$viewDidLoad)(_LOGOS_SELF_TYPE_NORMAL MZRootViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$MZRootViewController$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL MZRootViewController* _LOGOS_SELF_CONST, SEL); 

#line 42 "Tweak.xm"


static void _logos_method$_ungrouped$MZRootViewController$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL MZRootViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	_logos_orig$_ungrouped$MZRootViewController$viewDidLoad(self, _cmd);

	    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"注入成功了，呜～喵！" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertaction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
 }];
    [alert addAction:alertaction];
    [self presentViewController:alert animated:YES completion:nil];	
    if (self) {
    	NSLog(@"self is not nil!%@, alert: %@", self, alert);
    }

    UIAlertView *alert1 = [[UIAlertView alloc] initWithTitle:@"豆豆专用破手机！" message:nil delegate:self cancelButtonTitle:@"臣妾领命" otherButtonTitles:nil];    
	[alert1 show];
}




#import <substrate.h>


void (*old__ZN8CPPClass7CPPFuncEPKc)(void *, const char *);


void new__ZN8CPPClass7CPPFuncEPKc(void *hiddenThis, const char *arg) {
	if (strcmp(arg, "This is a Cpp Function!") == 0) {
		old__ZN8CPPClass7CPPFuncEPKc(hiddenThis, "This is a hijacked Cpp Function!");
	}
	else {
		old__ZN8CPPClass7CPPFuncEPKc(hiddenThis, "This is a hijacked Short C Function!");
	}
}


void (*old_CFunc)(const char *);


void new_CFunc (const char *arg) {
	
	old_CFunc("This is a hijacked C Function!");
}


void (*old_ShortCFunction)(const char *);

void new_ShortCFunction(const char *arg) {
	old_ShortCFunction("This is a hijacked Short C Function!!!");
}

static __attribute__((constructor)) void _logosLocalCtor_98dce83d(int __unused argc, char __unused **argv, char __unused **envp)
{
	@autoreleasepool {
		NSLog(@"HookerTweak!!");
		
		MSImageRef image = MSGetImageByName("/Applications/ReverseTarget.app/ReverseTarget");
		
		void *__ZN8CPPClass7CPPFuncEPKc = MSFindSymbol(image, "__ZN8CPPClass7CPPFuncEPKc");
		if (__ZN8CPPClass7CPPFuncEPKc) {
			
			NSLog(@"Found CPP Function!");
			MSHookFunction((void *)__ZN8CPPClass7CPPFuncEPKc, (void *)&new__ZN8CPPClass7CPPFuncEPKc, (void **)&old__ZN8CPPClass7CPPFuncEPKc);	
		}
		void *_CFunc = MSFindSymbol(image, "_CFunc");
		void *_ShortCFunction = MSFindSymbol(image, "_ShortCFunction");
		if (_CFunc) {
			NSLog(@"Found C Function!");
			MSHookFunction((void *)_CFunc, (void *)&new_CFunc, (void **)&old_CFunc);
		}
		if (_ShortCFunction) { 
			NSLog(@"Found Short C Function!");
			MSHookFunction ((void *)_ShortCFunction, (void *)&new_ShortCFunction, (void **)&old_ShortCFunction);
		}
	}
}
static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$MZRootViewController = objc_getClass("MZRootViewController"); MSHookMessageEx(_logos_class$_ungrouped$MZRootViewController, @selector(viewDidLoad), (IMP)&_logos_method$_ungrouped$MZRootViewController$viewDidLoad, (IMP*)&_logos_orig$_ungrouped$MZRootViewController$viewDidLoad);} }
#line 119 "Tweak.xm"
