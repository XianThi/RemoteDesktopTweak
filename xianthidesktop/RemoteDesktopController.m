#import <Foundation/Foundation.h>
#import "RemoteDesktopController.h"
#import "Communicator.h"
#import "ProcessCell.h"
#import "XiaRootViewController.h"
#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
static bool volumeHudEnabled = NO;
static bool connected = NO;
@implementation RemoteDesktopController{
	UIView *popupView;
	UICollectionView *_collectionView;
	NSMutableArray *items;
	Communicator *c;
}
-(void)loadView{
	[super loadView];
	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemUndo target:self action:@selector(backButtonTapped:)];
}
-(void)backButtonTapped:(id)sender {
	XiaRootViewController *xia = [[XiaRootViewController alloc] init];
	UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:xia];
	[self presentViewController:nc animated:NO completion:nil];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	popupView.hidden=YES;
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    _collectionView=[[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    [_collectionView setDataSource:self];
    [_collectionView setDelegate:self];
    [_collectionView setBackgroundColor:[UIColor whiteColor]];
    [_collectionView registerClass:[ProcessCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:_collectionView];
	items = [[NSMutableArray alloc] init];
	[items addObject:@"volume.png"];
	[items addObject:@"killapp.png"];
	[self setTitle:@"waiting for server..!"];
	[[NSNotificationCenter defaultCenter] addObserver:self	selector:@selector(socketConnectedInfo:) name:@"connected" object:nil];
	[self connect];
}

- (void) socketConnectedInfo:(NSNotification *) notification
{
    if ([[notification name] isEqualToString:@"connected"]){
		connected = YES;
		[self setTitle:@"Connected ! "];
	}
}

-(void) showSliderPopup{
    UISlider *slider=[[UISlider alloc]initWithFrame:CGRectMake(0, 0, 100,100)];
    CGAffineTransform trans=CGAffineTransformMakeRotation(M_PI_2);
    slider.transform=trans;
    slider.minimumValue=0;
    slider.maximumValue=100;
    slider.continuous=NO;
    [slider addTarget:self action:@selector(sliderChanhge:) forControlEvents:UIControlEventValueChanged];
	popupView=[[UIView alloc]initWithFrame:CGRectMake(30, 210, 110,110)];
    [popupView addSubview:slider];
    [self.view addSubview:popupView];
}
-(void)sliderChanhge:(UISlider *)sender{
	[c writeOut:[NSString stringWithFormat:@".volume:%d",(int)sender.value]];
}
-(void) showKillAppInput{
	UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Kill Apps with Process Name" message:@"write all for kill all. write process name for kill one." preferredStyle:UIAlertControllerStyleAlert];
	[alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {textField.placeholder = @"";}];
	UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {[alert dismissViewControllerAnimated:YES completion:nil];}];
	UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
		NSString *input = alert.textFields[0].text;
		[c writeOut:[NSString stringWithFormat:@".kill:%@",input]];
	}];
	[alert addAction:cancel];
	[alert addAction:ok];
	[self presentViewController:alert animated:YES completion:nil];
	
}


- (void) connect{
	c = [[Communicator alloc] init];
	c->host = self.host;
	c->port = self.port;
	[c setup];
	[c open];
}

- (UIImage *)imageWithImage:(UIImage *)image convertToSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *destImage = UIGraphicsGetImageFromCurrentImageContext();    
    UIGraphicsEndImageContext();
    return destImage;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [items count];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
	if(connected){
		if(indexPath.row==0){
			if(!volumeHudEnabled){
				[self showSliderPopup];
				volumeHudEnabled = YES;
			}else{
				[popupView.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
				volumeHudEnabled = NO;
			}
		}
		if(indexPath.row==1){
			[self showKillAppInput];
		}
	}else{
		UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"XianThiDesktop" message:@"You need to connect server. waiting connection.." preferredStyle:UIAlertControllerStyleAlert];
		UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {}];
		[alert addAction:ok];
		[self presentViewController:alert animated:YES completion:nil];
	}
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ProcessCell *cell=(ProcessCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
	UIImage *image = [UIImage imageNamed:[items objectAtIndex:indexPath.row]];
	image = [self imageWithImage:image convertToSize:CGSizeMake(100,100)];
	cell.imageView.image=image;
    //cell.textLabel.text = @"test";
	[cell.imageView layoutIfNeeded];
	[cell.imageView sizeToFit];
	return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize mElementSize;
    mElementSize=CGSizeMake(100, 100);
    return mElementSize;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 5.0;
}

- (UIEdgeInsets)collectionView: (UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
	return UIEdgeInsetsMake(30,30,10,30);
}

- (CGFloat)collectionView: (UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAt:(NSInteger)section
{
	return 20;
}
@end