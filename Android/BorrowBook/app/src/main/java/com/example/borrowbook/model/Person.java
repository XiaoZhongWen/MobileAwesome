package com.example.borrowbook.model;

public class Person {

    private String name;
    private String sex;
    private Food food;

//    public Person(String name, String sex, Food food) {
//        this.name = name;
//        this.sex = sex;
//        this.food = food;
//    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public Food getFood() {
        return food;
    }

    public void setFood(Food food) {
        this.food = food;
    }
}
