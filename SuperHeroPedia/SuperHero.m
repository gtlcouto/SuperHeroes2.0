//
//  SuperHero.m
//  SuperHeroPedia
//
//  Created by Gustavo Couto on 2015-01-26.
//  Copyright (c) 2015 Mobile Makers. All rights reserved.
//

#import "SuperHero.h"
@interface SuperHero ()

@property NSURL * avatar_url;

@end

@implementation SuperHero

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self)
    {
        self.name = dictionary[@"name"];
        self.textDescription = dictionary[@"description"];
        self.avatar_url = [NSURL URLWithString:dictionary[@"avatar_url"]];

    }
    return self;
}

+(void)retrieveSuperHeroesWithCompletion:(void(^)(NSArray * heroes))complete
{

    NSURL *url = [NSURL URLWithString:@"https://s3.amazonaws.com/mobile-makers-lib/superheroes.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSArray * heroes;
        heroes = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&connectionError];
        NSMutableArray * tempHeroes = [NSMutableArray new];

        for (NSDictionary * d in heroes) {
            SuperHero * hero  = [[SuperHero alloc] initWithDictionary:d];
            [tempHeroes addObject:hero];
        }

        complete(tempHeroes);
    }];
}

-(void)getImageWithCompletion:(void(^)(NSData * imageData))complete
{
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:self.avatar_url] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        complete(data);
    }];


}

@end
