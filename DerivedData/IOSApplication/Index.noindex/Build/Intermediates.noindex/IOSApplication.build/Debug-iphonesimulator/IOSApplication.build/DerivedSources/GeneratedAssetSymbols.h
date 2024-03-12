#import <Foundation/Foundation.h>

#if __has_attribute(swift_private)
#define AC_SWIFT_PRIVATE __attribute__((swift_private))
#else
#define AC_SWIFT_PRIVATE
#endif

/// The resource bundle ID.
static NSString * const ACBundleID AC_SWIFT_PRIVATE = @"RareConnect.IOSApplication";

/// The "Accent" asset catalog color resource.
static NSString * const ACColorNameAccent AC_SWIFT_PRIVATE = @"Accent";

/// The "Background" asset catalog color resource.
static NSString * const ACColorNameBackground AC_SWIFT_PRIVATE = @"Background";

/// The "Error" asset catalog color resource.
static NSString * const ACColorNameError AC_SWIFT_PRIVATE = @"Error";

/// The "Grey" asset catalog color resource.
static NSString * const ACColorNameGrey AC_SWIFT_PRIVATE = @"Grey";

/// The "Primary1" asset catalog color resource.
static NSString * const ACColorNamePrimary1 AC_SWIFT_PRIVATE = @"Primary1";

/// The "Success" asset catalog color resource.
static NSString * const ACColorNameSuccess AC_SWIFT_PRIVATE = @"Success";

/// The "TextPrimary" asset catalog color resource.
static NSString * const ACColorNameTextPrimary AC_SWIFT_PRIVATE = @"TextPrimary";

/// The "TextSecondary" asset catalog color resource.
static NSString * const ACColorNameTextSecondary AC_SWIFT_PRIVATE = @"TextSecondary";

/// The "dna_1" asset catalog image resource.
static NSString * const ACImageNameDna1 AC_SWIFT_PRIVATE = @"dna_1";

#undef AC_SWIFT_PRIVATE