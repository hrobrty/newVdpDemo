//工具类

#define MY_NAME         @"5000"
#define OUR_DOMAIN      @"120.76.225.49"
#define OUR_PORT        @"5060"
#define YOU_NAME        @"8000"

//#define SHOW_PHONE_LOG

#ifdef SHOW_PHONE_LOG
    #define PLog(...);    NSLog(__VA_ARGS__);
#else
    #define PLog(...);    // NSLog(__VA_ARGS__);
#endif


#define HAVE_X264

