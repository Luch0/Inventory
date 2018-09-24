//
//  Item.m
//  Inventory
//
//  Created by Luis Calle on 8/31/18.
//  Copyright © 2018 Lucho. All rights reserved.
//

#import "Item.h"

@implementation Item

- (instancetype)init {
    self = [super init];
    if (self) {
        _name = @"Item No Name";
    }
    return self;
}

- (instancetype) initWithName:(NSString *)name withValueInDollars:(NSNumber*)dollars withSerialNumber:(NSString *)serialNumber {
    self = [super init];
    if (self) {
        _name = name;
        _valueInDollars = dollars;
        _serialNumber = serialNumber;
        _dateCreated = [[NSDate alloc] init];
        _itemKey = [[[NSUUID alloc] init] UUIDString];
    }
    return self;
}

- (instancetype)initRandom:(BOOL)random {
    self = [super init];
    if (self) {
        if (random) {
            NSArray *adjectives = [NSArray arrayWithObjects: @"Fluffy", @"Rusty", @"Shiny", nil];
            NSArray *nouns = [NSArray arrayWithObjects: @"Bear", @"Spork", @"Mac", nil];
            
            NSString *randomAdjective = adjectives[arc4random() % adjectives.count];
            NSString *randomNoun = adjectives[arc4random() % nouns.count];
            NSString *randomName = [NSString stringWithFormat:@"%@ %@", randomAdjective, randomNoun];
            NSNumber *randomValue = [[NSNumber alloc] initWithInt:arc4random() % 100];
            NSString *randomSerialNumber = [[[[[NSUUID alloc] init] UUIDString]componentsSeparatedByString:@"-"] firstObject];
            
            _name = randomName;
            _valueInDollars = randomValue;
            _serialNumber = randomSerialNumber;
            _itemKey = [[[NSUUID alloc] init] UUIDString];
        } else {
            _name = @"";
            _valueInDollars = 0;
            _serialNumber = nil;
            _itemKey = nil;
        }
        _dateCreated = [[NSDate alloc] init];
    }
    return self;
}

#pragma mark NSCoding Protocol Methods
- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeObject:_valueInDollars forKey:@"valueInDollars"];
    [aCoder encodeObject:_serialNumber forKey:@"serialNumber"];
    [aCoder encodeObject:_dateCreated forKey:@"dateCreated"];
    [aCoder encodeObject:_itemKey forKey:@"itemKey"];
}

- (instancetype)initWithCoder:(nonnull NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _name = [aDecoder decodeObjectForKey:@"name"];
        _valueInDollars = [aDecoder decodeObjectForKey:@"valueInDollars"];
        _serialNumber = [aDecoder decodeObjectForKey:@"serialNumber"];
        _dateCreated = [aDecoder decodeObjectForKey:@"dateCreated"];
        _itemKey = [aDecoder decodeObjectForKey:@"itemKey"];
    }
    return self;
}

@end
