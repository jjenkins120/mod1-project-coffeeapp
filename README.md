Module One Final Project
========================

Congratulations, you're at the end of module one! You've worked crazy hard to get here and have learned a ton.

For your final project, you'll be building a Command Line Application.

---

## Goals (Minimum Requirements)

You will be building a **Command Line CRUD App** that uses a database to persist information. The goal of which is to demonstrate all of the skills that you've learned in module one:

- Ruby
- Object Orientation
- Relationships (via ActiveRecord)
- Problem Solving (via creating a Command Line Interface (CLI))

Your **minimum requirements** for this project are to build a Command Line App that:

1. Contains at least three models with corresponding tables, including a join table.
2. Accesses a Sqlite3 database using ActiveRecord.
3. Has a CLI that allows users to interact with your database as defined by your _user stories_ (minimum of four; one for each CRUD action).
4. Uses good OO design patterns. You should have separate models for your runner and CLI interface.

---
Project Pitch 
========================
Owner(s): Kimberlyn Stoddard & Jeff Jenkins 
Mod and Cohort: Mod 1; 080320 Chicago

One sentence app description:
This app will allow users to order cafe drinks including a customizable option, create/delete accounts, view past orders, save/view favorite drinks

Domain model with attributes:

Users -< Order >- Drinks
Drinks -< Recipe_item >- Ingredients

User: username(str), password (str), signed in?(boolean)
Drink: name(str), price(int), is_menu_item?(boolean)
Order: user_id (int), drink_id(int), price(int), favorite?(boolean)
Recipe_item: drink_id(int), ingredient_id(int)
Ingredient: name(str)

User Stories:

User will be able to:
View their orders (read) 
Sign in/sign out (update)
Make an order (create)
Save as a favorite (update)
View drink options and ingredients (read)
Delete account (delete)
 
Stretch Goals (after MVP):
Make a drink (create)
Change an order (update)
order multiple drinks (create)
add graphics and sounds

***Prior to running, be sure to 
1. run bundle install
2. rake db:migrate
3. rake db:seed

View a demonstration of this app here: https://youtu.be/uclJCRjCvR8
