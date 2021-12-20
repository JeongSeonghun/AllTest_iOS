//
//  TestStaticLibView.m
//  AllTest_StaticLibObc
//  
//  Created by jsh on 2021/10/01
//  custom header comment

#import "TestStaticLibView.h"

@interface TestStaticLibView()

//@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@end

@implementation TestStaticLibView

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    
    if (self) {
        [self commonInit];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self commonInit];
    }
    
    return self;
}

- (void)commonInit {
    NSLog(@"static lib view common init");
//    self.contentView = [[self getBundle:@"AllTest_StaticLibBundle"] loadNibNamed:@"TestStaticLibView" owner:self options:nil];
    NSBundle *bundle = [self getBundle:@"AllTest_StaticLibBundle"];
    if (bundle == nil) {
        NSLog(@"lib view bundle nil");
        return;
    }
    NSLog(@"lib view bundle ready");
    UIView* contentView = [[bundle loadNibNamed:@"TestStaticLibView" owner:self options:nil]firstObject];
    
    if (contentView == nil) {
        NSLog(@"contentView nil");
        return;
    }
    NSLog(@"contentView ready");
    
    [self addSubview:contentView];
    NSLog(@"contentView add");
    contentView.frame = self.bounds;
    contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    NSLog(@"contentView frame set");
}

- (NSBundle*)getBundle: (NSString*)bundleName {
    NSString* path = [[NSBundle mainBundle] pathForResource:bundleName ofType:@"bundle"];
    NSLog(@"chekc bundle path %@", path);
    return [NSBundle bundleWithPath: path];
}

@end
