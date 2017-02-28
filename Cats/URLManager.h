//
//  URLManager.h
//  Cats
//
//  Created by Sofia Knezevic on 2017-02-27.
//  Copyright © 2017 Sofia Knezevic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface URLManager : NSObject

- (void)getCatPhotos:(void (^)(NSArray *))completion;
- (void)downloadCatPhotos:(NSURL *)url completion:(void (^)(UIImage *))completion;

@end
