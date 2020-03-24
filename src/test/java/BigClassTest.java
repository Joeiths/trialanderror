import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class BigClassTest {

    @Test
    void classTest() {
        BigClass b1 = new BigClass();
        BigClass b2 = new BigClass();
          assertEquals(b1.getNumber(), b2.getNumber());
          assertEquals(b1.getText(), b2.getText());
    }

    @Test
    void checkNumber() {
        BigClass b1 = new BigClass(69);
        assertEquals(69, b1.getNumber());
    }

    @Test
    void checkTextAndNumber() {
        BigClass b1 = new BigClass("Hejsan");
        assertEquals("Hejsan", b1.getText());
    }

    @Test
    void doubleWhammy () {
        BigClass b1 = new BigClass(69, "Hejsan");
        assertEquals(69, b1.getNumber());
        assertEquals("Hejsan", b1.getText());
    }

    @Test
    void postiveNumber() {
        BigClass b1 = new BigClass();
        b1.setNumber(7);
        assertEquals(7, b1.getNumber());
    }

    @Test
    void negativeNumber() {
        BigClass b1 = new BigClass();
        b1.setNumber(-5);
        assertEquals(0, b1.getNumber());
    }

    @Test
    void testText () {
        BigClass b1 = new BigClass();
        b1.setText("Hej");
        assertEquals("Hej", b1.getText());
    }

    @Test
    void upperCase() {
        BigClass b1 = new BigClass();
        assertEquals("JAAA", b1.textToUpperCase("jaaa"));
    }

    @Test
    void textNullText() {
        BigClass b1 = new BigClass("hej");
        assertEquals(null, b1.textToNullMethod());
    }

    @Test
    void numberAgain() {
        BigClass b1 = new BigClass(6);
        b1.sumOfNumber(6);
        assertEquals(12, b1.getNumber());
    }

    @Test
    void stringTextTest() {
        BigClass b1 = new BigClass(69, "hej");
        assertEquals("number=69, text=hej", b1.toString());
    }

}
