//
//  ViewController.m
//  SuperHeroPedia
//
//  Created by Dave Krawczyk on 9/6/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "ViewController.h"
#import "SuperHero.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *heroes;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];

    [SuperHero retrieveSuperHeroesWithCompletion:^(NSArray *heroes) {
        self.heroes = heroes;
    }];
 

}

-(void)setHeroes:(NSArray *)heroes
{
    _heroes = heroes;
    [self.tableView reloadData];
}

#pragma mark - Tableview Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.heroes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"superHeroCell"];
    
    SuperHero * hero = [self.heroes objectAtIndex:indexPath.row];
    cell.textLabel.text = hero.name;
    cell.detailTextLabel.text = hero.textDescription;
    cell.detailTextLabel.numberOfLines = 2;
    [hero getImageWithCompletion:^(NSData *imageData) {
        cell.imageView.image = [UIImage imageWithData:imageData];
        [cell layoutSubviews];
    }];

    return cell;
}




@end
