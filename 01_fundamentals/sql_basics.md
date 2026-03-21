# 📊 SQL Fundamentals – Practice

## 📌 Overview
This file contains core SQL operations including database creation, data insertion, filtering, and basic querying.

---

## 🧩 1. Database & Table Creation

### 💻 SQL Query
```sql
CREATE DATABASE school;
USE school;

CREATE TABLE students (
id INT,
name VARCHAR(50),
age INT,
city VARCHAR(50),
marks FLOAT
);