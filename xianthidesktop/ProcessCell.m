#import "ProcessCell.h"

@implementation ProcessCell
- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	self.textLabel = [[UILabel alloc] init];
	[self.textLabel setTextColor:[UIColor blackColor]];
    [self.textLabel setBackgroundColor:[UIColor whiteColor]];
    [self.textLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:18.0f]];
	[self.textLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView addSubview:self.textLabel];
	self.imageView = [[UIImageView alloc] init];
	[self.contentView addSubview:self.imageView];
	return self;
}
@end