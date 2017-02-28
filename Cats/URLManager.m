//
//  URLManager.m
//  Cats
//
//  Created by Sofia Knezevic on 2017-02-27.
//  Copyright © 2017 Sofia Knezevic. All rights reserved.
//

#import "URLManager.h"
#import "CatPhoto.h"

@implementation URLManager

- (void)getCatPhotos:(void (^)(NSArray *))completion
{
    
    NSURL *catURL = [NSURL URLWithString:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&format=json&nojsoncallback=1&api_key=1a1388d1bf4d856d701b92933e438676&tags=cat"];
    
    NSURLRequest *requestURL = [NSURLRequest requestWithURL:catURL];
    
    NSURLSessionConfiguration *configure = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *configureSession = [NSURLSession sessionWithConfiguration:configure];
    
    NSURLSessionDataTask *dataTask = [configureSession
                                      dataTaskWithRequest:requestURL
                                      completionHandler:^
                                      (NSData * _Nullable data,
                                       NSURLResponse * _Nullable response,
                                       NSError * _Nullable error) {
                                          
                                          if (error) {
                                              
                                              NSLog(@"error: %@", error.localizedDescription);
                                              return;
                                              
                                          }
                                          
                                          NSError *jsonError = nil;
                                          
                                          NSDictionary *getThatJSON = [NSJSONSerialization
                                                                       JSONObjectWithData:data
                                                                       options:0
                                                                       error:&jsonError];
                                          
                                          if (jsonError) {
                                              
                                              NSLog(@"error: %@", jsonError.localizedDescription);
                                              return;
                                              
                                          }
                                          
                                          NSArray *pictures = getThatJSON[@"photos"][@"photo"];
                                       
                                          NSArray *photosArray = [CatPhoto makePhotoArray:pictures];
                                          
                                          [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                              completion(photosArray);
                                          }];
                                          
                                          
                                      }];
    
    
    [dataTask resume];
    
    
}

- (void)downloadCatPhotos:(NSURL *)url completion:(void (^)(UIImage *))completion
{
    
    
    NSURLSessionConfiguration *configure = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *configureSession = [NSURLSession sessionWithConfiguration:configure];
    
    
    NSURLSessionDownloadTask *downloadCatPhotos = [configureSession
                                                downloadTaskWithURL:url
                                                completionHandler:^(NSURL * _Nullable location,
                                                                    NSURLResponse * _Nullable response,
                                                                    NSError * _Nullable error) {
                                                    
                                                    
                                                    if (error) {
                                                        
                                                        NSLog(@"%@", error.localizedDescription);
                                                        return;
                                                        
                                                    }
                                                    
                                                    NSData *pictureData = [NSData dataWithContentsOfURL:url];
                                                    UIImage *picture = [UIImage imageWithData:pictureData];
                                                    
                                                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                                        
                                                        completion(picture);
                                                        
                                                    }];
                                                    
                                                }];
    
    [downloadCatPhotos resume];
    
    
}


@end
