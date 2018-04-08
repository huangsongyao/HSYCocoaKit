//
//  HSYBaseCollectionViewController.h
//  Pods
//
//  Created by huangsongyao on 2017/3/31.
//
//

#import "HSYBaseRefleshViewController.h"

@interface HSYBaseCollectionViewController : HSYBaseRefleshViewController <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong, readonly) UICollectionView *collectionView;

@property (nonatomic, strong) NSValue *sectionInset;            //上下左右四边距
@property (nonatomic, strong) NSValue *itemSize;                //item--size
@property (nonatomic, strong) NSValue *headerReferenceSize;     //section--size
@property (nonatomic, strong) NSValue *footerReferenceSize;     //footer--size
@property (nonatomic, strong) NSNumber *lineSpacing;            //行间距
@property (nonatomic, strong) NSNumber *interitemSpacing;       //item间距

@property (nonatomic, strong) NSNumber *scrollEnabled;
@property (nonatomic, strong) NSNumber *scrollIndicator;
@property (nonatomic, strong) NSNumber *bounces;

//格式：@[@{@"类名" : @"重用标识",}, @{@"类名" : @"重用标识",}....]
@property (nonatomic, strong, readwrite) NSArray<NSDictionary *> *registerClasses;

@end
