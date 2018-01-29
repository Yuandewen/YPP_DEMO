//
//  UserInfoModel.m
//  TESTBEBEST
//
//  Created by wandaios on 2018/1/5.
//  Copyright © 2018年 dcz. All rights reserved.
//

#import "UserInfoModel.h"
#import <objc/runtime.h>
#import "NSString+YP.h"

@implementation UserInfoModel
{
    NSMutableDictionary *mapping;
}
// 方法实现
Singleton_Instance_method_Impl(UserInfoModel)

/****************************************************************************************/
// 动态合成属性
@dynamic name;



/****************************************************************************************/
enum TypeEncodings {
    Char                = 'c',
    Bool                = 'B',
    Short               = 's',
    Int                 = 'i',
    Long                = 'l',
    LongLong            = 'q',
    UnsignedChar        = 'C',
    UnsignedShort       = 'S',
    UnsignedInt         = 'I',
    UnsignedLong        = 'L',
    UnsignedLongLong    = 'Q',
    Float               = 'f',
    Double              = 'd',
    Object              = '@'
};
- (NSString *)defaultsKeyForPropertyNamed:(char const *)propertyName
{
    NSString *key = [NSString stringWithFormat:@"%s", propertyName];
    return [self _transformKey:key];
}

- (NSString *)defaultsKeyForSelector:(SEL)selector
{
    return [mapping objectForKey:NSStringFromSelector(selector)];
}

static long long longLongGetter(UserInfoModel *self, SEL _cmd)
{
    NSString *key = [self defaultsKeyForSelector:_cmd];
    return [[[NSUserDefaults standardUserDefaults] objectForKey:key] longLongValue];
}

static void longLongSetter(UserInfoModel *self, SEL _cmd, long long value)
{
    NSString *key = [self defaultsKeyForSelector:_cmd];
    NSNumber *object = [NSNumber numberWithLongLong:value];
    [[NSUserDefaults standardUserDefaults] setObject:object forKey:key];
}

static bool boolGetter(UserInfoModel *self, SEL _cmd)
{
    NSString *key = [self defaultsKeyForSelector:_cmd];
    return [[NSUserDefaults standardUserDefaults] boolForKey:key];
}

static void boolSetter(UserInfoModel *self, SEL _cmd, bool value)
{
    NSString *key = [self defaultsKeyForSelector:_cmd];
    [[NSUserDefaults standardUserDefaults] setBool:value forKey:key];
}

static int integerGetter(UserInfoModel *self, SEL _cmd)
{
    NSString *key = [self defaultsKeyForSelector:_cmd];
    return (int)[[NSUserDefaults standardUserDefaults] integerForKey:key];
}

static void integerSetter(UserInfoModel *self, SEL _cmd, int value)
{
    NSString *key = [self defaultsKeyForSelector:_cmd];
    [[NSUserDefaults standardUserDefaults] setInteger:value forKey:key];
}

static float floatGetter(UserInfoModel *self, SEL _cmd)
{
    NSString *key = [self defaultsKeyForSelector:_cmd];
    return [[NSUserDefaults standardUserDefaults] floatForKey:key];
}

static void floatSetter(UserInfoModel *self, SEL _cmd, float value)
{
    NSString *key = [self defaultsKeyForSelector:_cmd];
    [[NSUserDefaults standardUserDefaults] setFloat:value forKey:key];
}

static double doubleGetter(UserInfoModel *self, SEL _cmd)
{
    NSString *key = [self defaultsKeyForSelector:_cmd];
    return [[NSUserDefaults standardUserDefaults] doubleForKey:key];
}

static void doubleSetter(UserInfoModel *self, SEL _cmd, double value)
{
    NSString *key = [self defaultsKeyForSelector:_cmd];
    [[NSUserDefaults standardUserDefaults] setDouble:value forKey:key];
}

static id objectGetter(UserInfoModel *self, SEL _cmd)
{
    NSString *key = [self defaultsKeyForSelector:_cmd];
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

static void objectSetter(UserInfoModel *self, SEL _cmd, id object)
{
    NSString *key = [self defaultsKeyForSelector:_cmd];
    if (object) {
        if([object isNull])
            object=nil;
        [[NSUserDefaults standardUserDefaults] setObject:object forKey:key];
    } else {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    }
}

#pragma mark - Begin

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wundeclared-selector"
#pragma GCC diagnostic ignored "-Warc-performSelector-leaks"

- (id)init
{
    self = [super init];
    if (self) {
        SEL setupDefaultSEL = NSSelectorFromString([NSString stringWithFormat:@"%@pDefaults", @"setu"]);
        if ([self respondsToSelector:setupDefaultSEL]) {
            NSDictionary *defaults = [self performSelector:setupDefaultSEL];
            NSMutableDictionary *mutableDefaults = [NSMutableDictionary dictionaryWithCapacity:[defaults count]];
            for (NSString *key in defaults) {
                id value = [defaults objectForKey:key];
                NSString *transformedKey = [self _transformKey:key];
                [mutableDefaults setObject:value forKey:transformedKey];
            }
            [[NSUserDefaults standardUserDefaults] registerDefaults:mutableDefaults];
        }
        
        [self generateAccessorMethods];
    }
    
    return self;
}

- (NSString *)_transformKey:(NSString *)key
{
    if ([self respondsToSelector:@selector(transformKey:)]) {
        return [self performSelector:@selector(transformKey:) withObject:key];
    }
    
    return key;
}

#pragma GCC diagnostic pop

- (void)generateAccessorMethods
{
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    mapping = [NSMutableDictionary dictionary];
    
    for (int i = 0; i < count; ++i) {
        objc_property_t property = properties[i];
        const char *name = property_getName(property);
        const char *attributes = property_getAttributes(property);
        
        char *getter = strstr(attributes, ",G");
        if (getter) {
            getter = strdup(getter + 2);
            getter = strsep(&getter, ",");
        } else {
            getter = strdup(name);
        }
        SEL getterSel = sel_registerName(getter);
        free(getter);
        
        char *setter = strstr(attributes, ",S");
        if (setter) {
            setter = strdup(setter + 2);
            setter = strsep(&setter, ",");
        } else {
            asprintf(&setter, "set%c%s:", toupper(name[0]), name + 1);
        }
        SEL setterSel = sel_registerName(setter);
        free(setter);
        
        NSString *key = [self defaultsKeyForPropertyNamed:name];
        [mapping setValue:key forKey:NSStringFromSelector(getterSel)];
        [mapping setValue:key forKey:NSStringFromSelector(setterSel)];
        
        IMP getterImp = NULL;
        IMP setterImp = NULL;
        char type = attributes[1];
        switch (type) {
            case Short:
            case Long:
            case LongLong:
            case UnsignedChar:
            case UnsignedShort:
            case UnsignedInt:
            case UnsignedLong:
            case UnsignedLongLong:
                getterImp = (IMP)longLongGetter;
                setterImp = (IMP)longLongSetter;
                break;
                
            case Bool:
            case Char:
                getterImp = (IMP)boolGetter;
                setterImp = (IMP)boolSetter;
                break;
                
            case Int:
                getterImp = (IMP)integerGetter;
                setterImp = (IMP)integerSetter;
                break;
                
            case Float:
                getterImp = (IMP)floatGetter;
                setterImp = (IMP)floatSetter;
                break;
                
            case Double:
                getterImp = (IMP)doubleGetter;
                setterImp = (IMP)doubleSetter;
                break;
                
            case Object:
                getterImp = (IMP)objectGetter;
                setterImp = (IMP)objectSetter;
                break;
                
            default:
                free(properties);
                [NSException raise:NSInternalInconsistencyException format:@"Unsupported type of property \"%s\" in class %@", name, self];
                break;
        }
        
        char types[5];
        
        snprintf(types, 4, "%c@:", type);
        class_addMethod([self class], getterSel, getterImp, types);
        
        snprintf(types, 5, "v@:%c", type);
        class_addMethod([self class], setterSel, setterImp, types);
    }
    
    free(properties);
}
@end
