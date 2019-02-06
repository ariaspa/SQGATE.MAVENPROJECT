package it.prodotto {

import flexunit.framework.TestCase;

public class TestApp extends TestCase {

    public function testGreeting():void {
        var name:String = "Lombardia Informatica";
        var expectedGreeting:String = "Hello, Lombardia Informatica";

        var result:String = App.greeting(name);
        assertEquals("Greeting is incorrect", expectedGreeting, result);
    }
    }
}

