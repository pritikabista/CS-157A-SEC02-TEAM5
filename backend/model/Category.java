package backend.model;

public class Category {

    private int categoryID;
    private String categoryName;

    public Category() {
        this.categoryID = 0;
        this.categoryName = "";
    }

    public Category(int categoryID, String categoryName) {
        this.categoryID = categoryID;
        this.categoryName = categoryName;
    }

    void setCategoryID(int categoryID) { this.categoryID = categoryID; }
    void setCategoryName(String categoryName) { this.categoryName = categoryName; }

    int getCategoryID() { return this.categoryID; }
    String getCategoryName() { return this.categoryName; }
}