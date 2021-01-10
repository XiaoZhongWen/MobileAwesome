package com.example.borrowbook.model;

public class Food {
    private String name;
    private String price;
    private  int pic;
    private boolean hot;
    private boolean seaFood;
    private boolean sour;

    public Food(String name, String price, int pic, boolean hot, boolean seaFood, boolean sour) {
        this.name = name;
        this.price = price;
        this.pic = pic;
        this.hot = hot;
        this.seaFood = seaFood;
        this.sour = sour;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public int getPic() {
        return pic;
    }

    public void setPic(int pic) {
        this.pic = pic;
    }

    public boolean isHot() {
        return hot;
    }

    public void setHot(boolean hot) {
        this.hot = hot;
    }

    public boolean isSeaFood() {
        return seaFood;
    }

    public void setSeaFood(boolean seaFood) {
        this.seaFood = seaFood;
    }

    public boolean isSour() {
        return sour;
    }

    public void setSour(boolean sour) {
        this.sour = sour;
    }
}
