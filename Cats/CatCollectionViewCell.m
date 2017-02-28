//
//  CatCollectionViewCell.m
//  Cats
//
//  Created by Sofia Knezevic on 2017-02-27.
//  Copyright © 2017 Sofia Knezevic. All rights reserved.
//

#import "CatCollectionViewCell.h"
#import "URLManager.h"

@interface CatCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *catImageView;
@property (weak, nonatomic) IBOutlet UILabel *catTitleLabel;
@property (nonatomic, strong) URLManager *urlManager;


@end

@implementation CatCollectionViewCell


- (void)awakeFromNib
{
    [super awakeFromNib];
    self.urlManager = [[URLManager alloc] init];
    [self configureCell];
}

-(void)configureCell
{
    self.catTitleLabel.text = self.catPhoto.title;
    
    NSURL *temporary = self.catPhoto.imageURL;
    [self.urlManager downloadCatPhotos:temporary completion:^(UIImage *image) {
        
        if ([self.catPhoto.imageURL isEqual:temporary]) {
            
            self.catImageView.image = image;
        }
        
        
    }];
}

@end
