//
//  NVHyperlinkLabel.m
//  Navy
//
//  Created by Jelly on 7/12/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import "NVHyperlinkLabel.h"
#import "NSMutableAttributedString+Category.h"
#import "NSDictionary+Category.h"
#import "Macros.h"


@implementation NVHyperlinkLabel


- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
    }
    
    return self;
}

- (NSMutableArray*) array {
    if (_array == nil) {
        _array = [[NSMutableArray alloc] init];
    }
    return _array;
}

- (void) clear {
    [self.array removeAllObjects];
    self.attributedText = nil;
}

- (void) addPlainText:(NSString *)plainText {
    NSMutableAttributedString* attributeString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    [attributeString appendString:plainText withAttributes:ATTR_DICTIONARY(COLOR_HM_DARK_GRAY, 14.0f)];
    self.attributedText = attributeString;
}

- (void) addAttributedPlainText:(NSAttributedString *)attributedPlainText {
    NSMutableAttributedString* attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    [attributedString appendAttributedString:attributedPlainText];
    self.attributedText = attributedString;
}

- (void) addHyperlink:(NSString *)hyperlink withUrl:(NSString*)urlPath {
    
    NSAttributedString* attributed = [[NSAttributedString alloc] initWithString:hyperlink
                                                                     attributes:ATTR_DICTIONARY(COLOR_HM_BLUE, 14.0f)];
    [self addAttributedHyperlink:attributed withUrl:urlPath];
    
}

- (void) addAttributedHyperlink:(NSAttributedString *)attributedHyperlink withUrl:(NSString *)urlPath {
    NSMutableAttributedString* attributeString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    
    CGSize size = [attributeString boundingRectWithSize:CGSizeMake(APPLICATIONWIDTH, 100000.0f)
                                                options:NSStringDrawingUsesFontLeading
                                                context:nil].size;
    
    NSRange range;
    range.location = size.width;
    
    [attributeString appendAttributedString:attributedHyperlink];
    self.attributedText = attributeString;
    
    size = [attributeString boundingRectWithSize:CGSizeMake(APPLICATIONWIDTH, 100000.0f)
                                         options:NSStringDrawingUsesFontLeading
                                         context:nil].size;
    range.length = size.width - range.location;
    
    NSDictionary* dictionary = @{@"url": urlPath,
                                 @"range": [NSValue valueWithRange:range]};
    [self.array addObject:dictionary];
    
}

- (void)touchesEnded:(NSSet *)touches
           withEvent:(UIEvent *)event {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(hyperlinkLabel:touchUrl:)]) {
        CGPoint point = [[touches anyObject] locationInView:self];
        
        CGSize size = [self.attributedText  boundingRectWithSize:CGSizeMake(APPLICATIONWIDTH, 1000000.0f)
                                                         options:NSStringDrawingUsesFontLeading
                                                         context:nil].size;
        CGFloat delta = 0.0f;
        if (self.textAlignment == NSTextAlignmentRight) {
            delta = self.bounds.size.width - size.width;
        } else if (self.textAlignment == NSTextAlignmentCenter) {
            delta = (APPLICATIONWIDTH - size.width)/2;
        }
        
        [self.array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSDictionary* dictionary = (NSDictionary*)obj;
            NSRange range = [[dictionary nvObjectForKey:@"range"] rangeValue];
            
            if (point.x >= range.location + delta
                && point.x <= range.length + range.location + delta) {
                [self.delegate hyperlinkLabel:self touchUrl:[dictionary nvObjectForKey:@"url"]];
            }
        }];
    }
    
}


@end
