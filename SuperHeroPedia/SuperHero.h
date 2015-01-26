//
//  SuperHero.h
//  SuperHeroPedia
//
//  Created by Gustavo Couto on 2015-01-26.
//  Copyright (c) 2015 Mobile Makers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SuperHero : NSObject

@property NSString * name;
@property NSString * textDescription;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
-(void)getImageWithCompletion:(void(^)(NSData * imageData))complete;

+(void)retrieveSuperHeroesWithCompletion:(void(^)(NSArray * heroes))complete;

@end
