#import "DeviceCell.h"

@implementation DeviceCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		self.ipLabel = [[UILabel alloc] init];
        [self.ipLabel setTextColor:[UIColor blackColor]];
        [self.ipLabel setBackgroundColor:[UIColor whiteColor]];
        [self.ipLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:18.0f]];
        [self.ipLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentView addSubview:self.ipLabel];
		self.macAddressLabel = [[UILabel alloc] init];
        [self.macAddressLabel setTextColor:[UIColor blackColor]];
        [self.macAddressLabel setBackgroundColor:[UIColor whiteColor]];
        [self.macAddressLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:18.0f]];
        [self.macAddressLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentView addSubview:self.macAddressLabel];
		self.brandLabel = [[UILabel alloc] init];
        [self.brandLabel setTextColor:[UIColor blackColor]];
        [self.brandLabel setBackgroundColor:[UIColor whiteColor]];
        [self.brandLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:18.0f]];
        [self.brandLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentView addSubview:self.brandLabel];
    }
    return self;
}
@end