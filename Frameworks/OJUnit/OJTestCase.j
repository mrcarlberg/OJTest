@import <Foundation/Foundation.j>

@import "OJTestResult.j"
@import "OJAssert.j"

AssertionFailedError = "AssertionFailedError";

/*!
    A single test case. This is an abstract superclass that each of your test cases (which are
    usually in their own separate files and of which each tests one and only one class) should
    subclass. Each of these test cases have the ability to run seperately.
   
    Example:
   
        @implementation OJMoqTest : OJTestCase
        
        ... // tests and other files
        
        @end
        
    In order to increase readability, there is a conventional way of writing tests. Each test
    should be prepended by the word "test" and non-tests should not be prepended by the word
    "test".
    
    Example:
    
        - (void)testThatOJMoqDoesInitialize {} // a test
        - (OJMoq)createStandardOJMoqInstance {return nil;} // a non-test
        
    Before each test, the message "setUp" will be passed to your test. By default, this does
    nothing but you can override the "setUp" method to do something for your test.
    
    After each test, the message "tearDown" will be passed to your test. By default, this
    does nothing but you can override the "tearDown" method to do something for your test.

    @brief A single test case.
 */
@implementation OJTestCase : CPObject
{
    SEL 		_selector		@accessors(property=selector);
}

/*!
   Runs the tests and returns the result.
 */
- (OJTestResult)run
{
    var result = [OJTestResult createResult];
    [self run:result];
    return result;
}

/*!
   Informs the OJTestResult to run the tests
   @param result The OJTestResult that will run the tests
 */
- (void)run:(OJTestResult)result
{
    [result run:self];
}

/*!
   Runs the setup, test and teardown for the 
   @param a parameter
 */
- (void)runBare
{
    [self setUp];
    try
    {
        [self runTest];
    }
    finally
    {
        [self tearDown];
    }
}

/*!
   If the selector is not null, 
   @param a parameter
 */
- (void)runTest
{
    [OJAssert assertNotNull:_selector];
    
    [self performSelector:_selector];
}

/*!
   SetUp method that is called before each run.
 */
- (void)setUp
{
}

/*!
   TearDown method that is called after each run.
 */
- (void)tearDown
{
}

/*!
   The number of test cases this represents.

    @returns 1
 */
- (int)countTestCases
{
    return 1;
}

- (CPString)description
{
    return "[" + [self className] + " " + _selector + "]";
}

@end

@import "OJTestCase+Assert.j"