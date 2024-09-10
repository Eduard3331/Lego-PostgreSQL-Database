# Lego-PostgreSQL-Database

This is a demonstration of data being imported in SQL and accessed through DBeaver, Python and Tableau.

## 🔡Importing Data
The Lego data imported can be found here: https://www.kaggle.com/datasets/rtatman/lego-database

colors.csv:

![image](https://github.com/user-attachments/assets/9bedc1c3-7831-4d71-b0a3-d596906e0751)


After importing the raw data into a schema named 'staging' I created a new one 'analysis' where I first check what are the ideal data types for each collumn:

![image](https://github.com/user-attachments/assets/5d9ad673-8fb8-43d1-acf6-d0c553a03d89)

I then create the new tables with the optimized data types and import the old data into them:

![image](https://github.com/user-attachments/assets/cfc50ac5-6109-43ca-8699-3d4074e54fd3)
![image](https://github.com/user-attachments/assets/cbe8029b-dfc1-4172-b5e6-a5f688dab526)


Setting up Primary and Foreign Keys:

![image](https://github.com/user-attachments/assets/e77ff9bd-243d-4faa-9601-3429197b9d2b)
![image](https://github.com/user-attachments/assets/49ec232e-7f75-426f-bb95-d3c77dd2cdcf)

The 'analysis' Schema is now ready to be visualized in an ERD diagram. This is the ERD from Postgres:

![image](https://github.com/user-attachments/assets/a9c3e75f-4ed5-47be-bb34-a9df3c8ee53e)


## 🦫DBeaver
This is the cleaner ERD diagram generated in DBeaver by connecting to the Postgres server:

![lego - analysis](https://github.com/user-attachments/assets/5870084b-4aeb-4c2e-aafc-c75e4ced1bce)


## 🐍Python
This is the implementation in Python, although for the sake of simplicity I hardcoded the username and password when normally they would be accessed through more secure means such as accessing them through another file.
![image](https://github.com/user-attachments/assets/54a8e2e3-e72b-4953-bee5-8e30e0a1d57b)

## 🖼️Creating a View and using Tableau Public
The view I create serves the purpose of accessing all the Lego pieces that have and haven't (are Unique) been used more than once. The SQL query looks as follows:

![image](https://github.com/user-attachments/assets/440c82a8-7253-427b-a49b-22b9731fc061)
![image](https://github.com/user-attachments/assets/fc957483-95f3-4e82-af4e-1bf9600e1b38)

We can access this data in the free version of Tableau by saving these results to a file which will be used in Tableau Public:

![Dashboard 1](https://github.com/user-attachments/assets/6b4f844b-e94e-4cbe-a4b7-bd0d1cf34b31)
