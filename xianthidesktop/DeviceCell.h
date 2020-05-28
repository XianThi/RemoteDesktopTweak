//
//  DeviceCell.h
//  MMLanScan
//
//  Created by Michalis Mavris on 12/08/16.
//  Copyright © 2016 Miksoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeviceCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *ipLabel;
@property (strong, nonatomic) IBOutlet UILabel *macAddressLabel;
@property (strong, nonatomic) IBOutlet UILabel *brandLabel;
@property (strong, nonatomic) IBOutlet UILabel *hostnameLabel;

@end