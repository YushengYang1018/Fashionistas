//
//  GalleryCollectionViewController.m
//  Fashionistas
//
//  Created by YangYusheng on 12/8/15.
//  Copyright © 2015 sm. All rights reserved.
//

#import "GalleryCollectionViewController.h"
#import "GalleryCollectionViewCell.h"
#import <KYElegantPhotoGallery/KYPhotoGallery.h>
#import "UIImageView+WebCache.h"
#import "GalleryCollectionViewCell.h"

@interface GalleryCollectionViewController ()

@property (strong,nonatomic)NSMutableArray *fashionImageURLArray;//ImageName
@property (strong,nonatomic)NSMutableArray *clientImageURLArray;//ImageName
@property (strong,nonatomic)NSMutableArray *fashionImageViewArray;
@property (strong,nonatomic)NSMutableArray *clientImageViewArray;

@end

NSString *baseClientImageURL = @"http://www.fashionistassalon.com/images/gallery_clients/";
NSString *baseSalonImageURL = @"http://www.fashionistassalon.com/images/gallery_salon/";

@implementation GalleryCollectionViewController

static NSString * const reuseIdentifier = @"GalleryCollectionViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerNib:[UINib nibWithNibName:@"GalleryCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    //drawer gesture
    UITapGestureRecognizer * doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
    [doubleTap setNumberOfTapsRequired:2];
    [self.view addGestureRecognizer:doubleTap];
    
    UITapGestureRecognizer * twoFingerDoubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(twoFingerDoubleTap:)];
    [twoFingerDoubleTap setNumberOfTapsRequired:2];
    [twoFingerDoubleTap setNumberOfTouchesRequired:2];
    [self.view addGestureRecognizer:twoFingerDoubleTap];
    
    //navigationbar
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    self.fashionImageViewArray;
    self.clientImageViewArray;
    [self setupLeftMenuButton];
    
    self.navigationItem.title = @"Gallery";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return [self.fashionImageURLArray count];
    } else {
        return [self.clientImageURLArray count];
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GalleryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    NSInteger section = indexPath.section;
    if (section == 0) {
        [cell.imageView sd_setImageWithURL:self.fashionImageURLArray[indexPath.row] placeholderImage:nil options:SDWebImageLowPriority];
        
    } else {
        [cell.imageView sd_setImageWithURL:self.clientImageURLArray[indexPath.row] placeholderImage:nil options:SDWebImageLowPriority];
    }
    //NSLog(@"load process-->%ld.%ld",(long)indexPath.section, (long)indexPath.row);
    
    return cell;
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 10, 0, 10);
}
#pragma mark <UICollectionViewDelegate>


/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/


// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    GalleryCollectionViewCell *cell = (GalleryCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    //KYPhotoGallery *photoGallery = nil;
    if (indexPath.section == 0) {
        KYPhotoGallery *photoGallery = [[KYPhotoGallery alloc]initWithTappedImageView:cell.imageView andImageUrls:self.fashionImageURLArray andInitialIndex:indexPath.row+1];
        photoGallery.imageViewArray = self.fashionImageViewArray;
        [photoGallery finishAsynDownload:^{
            [self presentViewController:photoGallery animated:NO completion:nil];
            
        }];
    } else {
        KYPhotoGallery *photoGallery = [[KYPhotoGallery alloc]initWithTappedImageView:cell.imageView andImageUrls:self.clientImageURLArray andInitialIndex:indexPath.row+1];
        photoGallery.imageViewArray = self.clientImageViewArray;
        [photoGallery finishAsynDownload:^{
            [self presentViewController:photoGallery animated:NO completion:nil];

        }];
    }
    
    return YES;
}


#pragma mark - lazy init

- (NSMutableArray *)fashionImageURLArray
{
    if (!_fashionImageURLArray) {
        _fashionImageURLArray = [[NSMutableArray alloc]initWithCapacity:20];
        for (int i = 1; i <= 20; i++) {
            NSString *imageName = [NSString stringWithFormat:@"salon_%d.jpg",i];
            [_fashionImageURLArray addObject:[baseSalonImageURL stringByAppendingString:imageName]];
        }
    }
    return _fashionImageURLArray;
}

- (NSMutableArray *)clientImageURLArray
{
    if (!_clientImageURLArray) {
        _clientImageURLArray = [[NSMutableArray alloc]initWithCapacity:30];
        for (int i = 1; i <= 30; i++) {
            NSString *imageName = [NSString stringWithFormat:@"clients_%d.jpg",i];
            [_clientImageURLArray addObject:[baseClientImageURL stringByAppendingString:imageName]];
        }
    }
    
    return _clientImageURLArray;
}

- (NSMutableArray *)fashionImageViewArray
{
    if (!_fashionImageViewArray) {
        _fashionImageViewArray = [[NSMutableArray alloc]initWithCapacity:20];
        for (int i= 0; i < 20; i++) {
            UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectZero];
            
            img.frame = CGRectMake(0, 0, 60, 60);
            
            img.clipsToBounds = YES;
            //img.userInteractionEnabled = YES;
            img.contentMode = UIViewContentModeScaleAspectFill;
            
            
            [img sd_setImageWithURL:self.fashionImageURLArray[i] placeholderImage:nil options:SDWebImageLowPriority];
            
            [_fashionImageViewArray addObject:img];
        }
        
    }
    return _fashionImageViewArray;
}

- (NSMutableArray *)clientImageViewArray
{
    if (!_clientImageViewArray) {
        _clientImageViewArray = [[NSMutableArray alloc]initWithCapacity:30];
        for (int i= 0; i < 30; i++) {
            UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectZero];
            
            img.frame = CGRectMake(0, 0, 60, 60);
            
            img.clipsToBounds = YES;
            //img.userInteractionEnabled = YES;
            img.contentMode = UIViewContentModeScaleAspectFill;
            
            
            [img sd_setImageWithURL:self.clientImageURLArray[i] placeholderImage:nil options:SDWebImageLowPriority];
            
            [_clientImageViewArray addObject:img];
        }
    }
    return _clientImageViewArray;
}

#pragma mark - drawer
-(void)setupLeftMenuButton{
    MMDrawerBarButtonItem * leftDrawerButton = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(leftDrawerButtonPress:)];
    [leftDrawerButton setTintColor:[UIColor whiteColor]];
    [self.navigationItem setLeftBarButtonItem:leftDrawerButton animated:YES];
}

#pragma mark - Button Handlers
-(void)leftDrawerButtonPress:(id)sender{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

-(void)doubleTap:(UITapGestureRecognizer*)gesture{
    [self.mm_drawerController bouncePreviewForDrawerSide:MMDrawerSideLeft completion:nil];
}

-(void)twoFingerDoubleTap:(UITapGestureRecognizer*)gesture{
    [self.mm_drawerController bouncePreviewForDrawerSide:MMDrawerSideRight completion:nil];
}

@end





















