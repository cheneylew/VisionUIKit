//
//  PAPlistStorage.m
//  haofang
//
//  Created by Steven.Lin on 11/18/14.
//  Copyright (c) 2014 平安好房. All rights reserved.
//

#import "NVPlistStorage.h"
#import "NVSerializedObjectProtocol.h"
#import "NVUtility.h"


@interface NVPlistStorage ()
@property (nonatomic, retain) NSMutableDictionary* dictionary;
- (void) setObject:(id)object forKey:(id)key;
- (id) objectForKey:(id)key;
- (NSString*) getFilePath;
@end


@implementation NVPlistStorage
@synthesize dictionary = _dictionary;
@synthesize fileName = _fileName;



- (id) initWithFileName:(NSString *)fileName {
    self = [super init];
    if (self) {
        
        _fileName = fileName;
        
        NSString* path = [self getFilePath];
        
        NSFileManager* fm = [NSFileManager defaultManager];
        if (![fm fileExistsAtPath:path]) {
            [fm createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
        path = [path stringByAppendingPathComponent:_fileName];
        
        if (![fm fileExistsAtPath:path]) {
            [fm createFileAtPath:path contents:nil attributes:nil];
            
            _dictionary = [[NSMutableDictionary alloc] init];
            [self save];
            
        } else {
            
            NSData* data = [[NSData alloc] initWithContentsOfFile:path];
            NSKeyedUnarchiver* unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
            NSDictionary* dictionary = [unarchiver decodeObjectForKey:@"0xB19"];
            _dictionary = [[NSMutableDictionary alloc] initWithDictionary:dictionary];
            [unarchiver finishDecoding];
        }
    }
    
    return self;
}

- (void) writeObject:(id)object {
    

}

- (void) writeObject:(id)object forKey:(NSString *)key {
    if ([object conformsToProtocol:@protocol(NVFundationDeserializedObjectProtocol)]) {
        
        if ([object respondsToSelector:@selector(dictionaryValue)]) {
            NSDictionary* dictionary = [object dictionaryValue];
            [self setObject:dictionary forKey:key];
            [self save];
            
        } else if ([object respondsToSelector:@selector(arrayValue)]) {
            NSArray* array = [object arrayValue];
            [self setObject:array forKey:key];
            [self save];
        }
    } else if ([object isKindOfClass:[NSArray class]]
               || [object isKindOfClass:[NSString class]]
               || [object isKindOfClass:[NSDictionary class]]) {
        [self setObject:object forKey:key];
        [self save];
    }

}

- (id) readObject {
    return nil;
}

- (id) readObjectForKey:(NSString *)key {
    id object = [self objectForKey:key];
    return object;
}

- (void)read
{
    // TODO: 去警告实现
}

- (void)write
{
    // TODO: 去警告实现
}

- (void) setObject:(id)object forKey:(id)key {
    
    if (key == nil || [key isKindOfClass:[NSNull class]]) {
        NSLog(@"key is error");
        return;
    }
    
    if (object == nil || [object isKindOfClass:[NSNull class]]) {
        NSLog(@"object is error");
        return;
    }
    
    NSData* dataSaved = [NSKeyedArchiver archivedDataWithRootObject:object];
    [_dictionary setObject:dataSaved forKey:key];
}

- (id) objectForKey:(id)key {
    if (key == nil || [key isKindOfClass:[NSNull class]]) {
        NSLog(@"key is error");
        return nil;
    }
    
    NSData* data = [_dictionary objectForKey:key];
    if ([data isKindOfClass:[NSData class]]) {
        
        id object = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        return object;
    }
    
    return nil;
}



- (void) save {
    
    NSString* path = [self getFilePath];
    
    NSFileManager* fm = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:path]) {
        [fm createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    path = [path stringByAppendingPathComponent:_fileName];
    if (![fm fileExistsAtPath:path]) {
        [fm createFileAtPath:path contents:nil attributes:nil];
    }
    
    NSLog(@"%@", path);
    
    NSMutableData* data = [[NSMutableData alloc] init];
#warning  storage data  0bytes  偶尔会崩溃
    NSKeyedArchiver* archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:_dictionary forKey:@"0xB19"];
    [archiver finishEncoding];
    
    [data writeToFile:path atomically:YES];

}


- (NSString*) getFilePath {
    NSString* path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* bundleName = [NVUtility appBundleId];
    path = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@/", bundleName]];
    
    return path;
}

@end
