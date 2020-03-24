public class BigClass {
    private int number;
    private String text;

    public BigClass(int number, String text) {
        this.number = number;
        this.text = text;
    }

    public BigClass (int number) {
        this(number, null);
    }

    public BigClass(String text) {
        this(0, text);
    }

    public BigClass() {
        this(0, null);

    }

    public void setNumber(int number) {
            this.number = number;
    }

    public int getNumber () {
        return number;
    }

    public void setText (String text) {
        this.text = text;
    }

    public String getText () {
        return text;
    }

    public String textToUpperCase (String text) {
        return text.toUpperCase();
    }

    public String textToNullMethod () {
        this.text = null;
        return null;
    }

    public void sumOfNumber (int numberTwo) {
        if (numberTwo > 0) {
            this.number = this.number + numberTwo;
        }
    }

    @Override
    public String toString() {
        return  "number=" + number + ", text=" + text ;
    }
}
