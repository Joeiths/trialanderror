import org.junit.jupiter.api.*;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.CsvSource;
import org.junit.jupiter.params.provider.ValueSource;
import org.w3c.dom.ls.LSOutput;

import java.util.Random;

import static java.lang.Math.random;
import static org.junit.jupiter.api.Assertions.*;

class MyClassTest {

    @BeforeAll
    static void beforeAll () {
        System.out.println("Starting tests");
    }

    @AfterAll
    static void afterAll () {
        System.out.println("Ending tests");
    }

    @BeforeEach
    void beforeEach (TestInfo info) {
        System.out.println("Current test : "+info.getDisplayName());
    }

    @AfterEach
    void afterEach (TestInfo info) {
        System.out.println("Test finished : "+info.getDisplayName());
    }

        @Test
    void length_test() {
        String lengthtest = "YOLO";
            assertEquals(4, lengthtest.length()); // kollar så lengthtest-strängen innehåller lika många tecken som expected variabeln är värd
    }

    @Test
    void max_min() {
        int actual = Math.max(7,Math.max(22,39)); // kan bara ange 2 argument, bygg vidare med math.max() för fler siffror
        int expected = 39;
        assertEquals(actual,expected);

        int actualMIN = Math.min(-33,3);
        int expectedMIN = -33;
        assertEquals(actualMIN,expectedMIN);
    }
    @Test
    void test_empty () {
        String test ="";
        boolean actual = test.isEmpty();
        assertTrue(actual);
        // kollar så test är tom, booleanen blir då true, innehåller 'test'strängen något ger den false,
        // assertFalse kollar så booleanen är falsk ist
    }

    @Test
    void check_contains() {
        String test = "Jag är bäst";
        int a = 3;
        //int b;
        assertTrue(test.contains("bäst"));
        assertFalse(test.contains("woo"));
        //assertNull(b);
        assertNotNull(a);
    }

    @ParameterizedTest
    @DisplayName("Negative method")
    @ValueSource(ints = {3,23,543,5423,52352})
    void negativeTest2(int expected) {
        MyClass mc1 = new MyClass();
        assertTrue((mc1.negative(expected))<0);
    }

    @ParameterizedTest (name ="{0} negative is :  {1}")
    @DisplayName("Negative method, the second go")
    @CsvSource(value = {"5, -5","23, -23", "543, -543", "5432, -5432", "52352, -52352"})
    void negativeTest2(int expected, int actual) {
        MyClass mc1 = new MyClass();
        assertEquals(expected,mc1.negative(actual));
    }

    @ParameterizedTest (name = "{0} contains more letters than {1}")
    @CsvSource(value = {"a, 0", "ab, 2", "abc, 1", "abcd, 2"})
    void checklonger (String letter, int numb) {
        assertTrue(letter.length()>= numb);
    }

    @ParameterizedTest
    @CsvSource(value = {"hej, HEJ", "bu, BU"})
    void uppercaseText ( String check, String correct) {
        assertEquals(check.toUpperCase(), correct);
    }


    @ParameterizedTest
    @ValueSource(ints = {3,10,99})
    void setNUmbers (int set) {
        int actual = set * 10000;
        System.out.println(actual);
        assertEquals(set * 10000, actual);
    }

    @Test
    void randomNumbers () {
        for (int i = 0; i<5; i++) {
            Random rand = new Random();
            int set = rand.nextInt(100) + 1;
            int actual = set * 10000;
            System.out.println(actual);
            assertEquals(set * 10000, actual);
        }
    }

}