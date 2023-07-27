// @ Run Tests Laravel 
    // php artisan test
    // vendor/bin/phpunit // dose not work in work interment

    // To create a new test case, use the make:test Artisan command. By default, tests will be placed in the tests/Feature directory:
        // php artisan make:test UserTest
    // If you would like to create a test within the tests/Unit directory
        // php artisan make:test UserTest --unit

// @ Notes
    // * Arrange-act-assert

    // Unit test, Test behavior not implementation

    // Test what you set, unit tests and component integration tests specificity

    // Testing, an insurance that key features and functionality are working on every change that is implemented into the system

    // * [Tweet “Testing, at its core, is really about reducing risk.”]
    // ? https://usersnap.com/blog/software-testing-basics/
    // prioritizing what areas of the software are likely to have the biggest impact (i.e. risk), and then deciding on a set of tests to run which verify the desired functionality in that area.
    // How will things be tested?
    // What is our strategy for testing?
    // What kind of testing are we going to do?
    // What features are we going to test?
    // What is the schedule?
    // * As a software developer, you should be more concerned with quality than anyone else.
        // You can not have the mindset that QA will find the bugs in your code.
        // Instead, you should absolutely make it your responsibility to find and fix the bugs before your code goes into testing.
        // You won’t catch everything, but if you can even catch 10% of the bugs that would otherwise make it to QA, you’ll be saving quite a bit of time, don’t you think?
    // Programmers should not test their own code. Actually they should, but so should somebody else :) 
        // Just like you should have somebody proofread your paper before handing it in, They notice things you don't.

    // Given-When-Then
    // or
    // expect then Actual

    // * Given-When-Then 
        // Me WhenGiven-WhenAction-ThenResult
        // When "given" this environment - "When" this action occurs - "Then" We expect this result
    // Test
    // public void shouldDeliverCargoToDestination() {
    //     // given
    //     Driver driver = new Driver("Teddy");
    //     Cargo cargo = new Cargo();
    //     Position destinationPosition = new Position("52.229676", "21.012228");
    //     Truck truck = new Truck();
    //     truck.setDriver(driver);
    //     truck.load(cargo);
    //     truck.setDestination(destinationPosition);
    
    //     // when
    //     truck.driveToDestination();
    
    //     // then
    //     assertEquals(destinationPosition, truck.getCurrentPosition());
    // }

    // * Make it fail. Make it work. Make it right. Make it fast.
    // Getting software to work is only half of the job.
    // Customers value two things about software. The way it makes a machine behave; and the ease with which it can be changed. Compromise either of those two values and the software will diminish in real value to the customer.
    // ? https://blog.cleancoder.com/uncle-bob/2014/12/17/TheCyclesOfTDD.html