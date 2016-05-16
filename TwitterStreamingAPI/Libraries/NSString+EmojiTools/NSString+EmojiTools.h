#import <Foundation/Foundation.h>

@interface NSString (EmojiTools)

- (BOOL)isIncludingEmoji;
- (instancetype)stringByRemovingEmoji;
- (NSArray<NSString *>*)getEmojis;

@end
