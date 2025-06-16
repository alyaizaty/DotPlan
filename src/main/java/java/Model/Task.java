/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import Model.User;

public class Task {

    private int id;
    private String name;
    private int userId;
    private String startDate;
    private String endDate;
    private String priority;
    private String category;
    private String description;
    private boolean done;
    private boolean starred;

    public Task(int id, String name, String startDate, String endDate,
            String priority, String category, String description,
            boolean done, boolean starred, int userId) {
        this.id = id;
        this.name = name;
        this.startDate = startDate;
        this.endDate = endDate;
        this.priority = priority;
        this.category = category;
        this.description = description;
        this.done = done;
        this.starred = starred;
        this.userId = userId;
    }

    // Constructor for adding new task
    public Task(String name, String startDate, String endDate, String priority,
            String category, String description, int userId, boolean starred) {
        this.name = name;
        this.startDate = startDate;
        this.endDate = endDate;
        this.priority = priority;
        this.category = category;
        this.description = description;
        this.done = false;
        this.userId = userId;
        this.starred = starred;
    }

    // Constructor for updating task (with userId)
    public Task(int id, String name, String startDate, String endDate,
            String priority, String category, String description, boolean done, int userId) {
        this.id = id;
        this.name = name;
        this.startDate = startDate;
        this.endDate = endDate;
        this.priority = priority;
        this.category = category;
        this.description = description;
        this.done = done;
        this.userId = userId;

    }

    // Constructor without userId (optional, for backward compatibility)
    public Task(int id, String name, String startDate, String endDate, String priority, String category, String description, boolean done) {
        this.id = id;
        this.name = name;
        this.startDate = startDate;
        this.endDate = endDate;
        this.priority = priority;
        this.category = category;
        this.description = description;
        this.done = done;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    public String getPriority() {
        return priority;
    }

    public void setPriority(String priority) {
        this.priority = priority;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public boolean isDone() {
        return done;
    }

    public void setDone(boolean done) {
        this.done = done;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public boolean isStarred() {
        return starred;
    }

    public void setStarred(boolean starred) {
        this.starred = starred;
    }

}
