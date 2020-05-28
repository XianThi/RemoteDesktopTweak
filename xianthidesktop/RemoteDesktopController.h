@interface RemoteDesktopController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
	@property (strong, nonatomic) UICollectionView *collectionView;
	@property (strong, nonatomic) NSString *host;
	@property(nonatomic, assign) int port;
@end