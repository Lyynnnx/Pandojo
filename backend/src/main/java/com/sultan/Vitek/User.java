package com.sultan.Vitek;

public class User {
    private Object email;
    private Object password;

    // Constructors
    public User() {}

    public User(Object email, Object password) {
        this.email = email;
        this.password = password;
    }

    // Getters and Setters
    public Object getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Object getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}