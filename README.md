# Retails Chain ![MySQL](https://img.shields.io/badge/mysql-%2300f.svg?style=style=flat&logo=MySQL&logoColor=white) [![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)](https://github.com/NassarX/SRD-200174-Project/blob/main/LICENSE)

Welcome to retail chains RDBMS project! 

>A Relational Database Management System (RDBMS) build for retails chain stores as a part of **`Storing and Retrieving Data`**  course - [MDSAA-DS](www.novaims.unl.pt/MDSAA-DS) - Fall 2022

### A brief details of the Project

A chain store or retail chain is a retail outlet in which several locations share a brand, 
central management and standardized business practices.
In retail, dining, and many service categories, chain businesses have come to dominate the market in many parts of the
world. Almost all these chain businesses use sophisticated software and database systems to
improve efficiency and increase sales.   
This project aims to develop a database management system for such a chain business sys-
tem, particularly for this project a supermarket chain business, keeping record and transactions
of each store in the chain and handle changes due to supplies.

>For more details regarding the system please refer to presentation and project description of the system in Documentation folder.

## Getting started

### Setup Database

>To get started with this project, you will need to have MySQL installed on your computer. You can download the community edition of MySQL from the official website [mysql](https://www.mysql.com/).

Once MySQL is installed, you can test it by creating a new database using the MySQL command-line client. For example:

```sql
mysql -u root -p

CREATE DATABASE mydatabase;
USE mydatabase;
CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(255),
  password VARCHAR(255)
);
```

> To import and run the project, you can follow any of next options:
1. From MySQL Workbench import and execute `retail-chains-dump.sql` script which Contain 
   - Database schema
   - Triggers
   - Procedures 
   - Views 
   - Data

2. Using Command Line 
   ```shel
   mysql -uroot -p  < retail-chains-dump.sql
   ```

3. From MySQL Workbench import and execute theses scripts under src/ directory respectively :
   - `src/schema.sql`
   - `src/procedures.sql`
   - `src/views.sql`
   - `data/basic.sql`
   - `data/testing.sql`
4. Using Command Line
   ```bash
   mysql -uroot -p  < src/schema/schema.sql
   ```
   ```bash
   mysql -uroot -p  < src/schema/procedures.sql
   ```
   ```bash
   mysql -uroot -p  < src/schema/views.sql
   ```
   ```bash
   mysql -uroot -p  < src/data/basic.sql
   ```
   ```bash
   mysql -uroot -p  < src/data/testing.sql
   ```

### Using the Project
>To use the project, you can write code that accesses and manipulates the data stored in the database. This can be done using a programming language that supports MySQL connectivity, such as Python, Java, C#, etc.

Here is an example of how to connect to the database and execute a simple SELECT query using Python and the MySQL Connector library:

```python
import mysql.connector

# Connect to the database
cnx = mysql.connector.connect(user='root', password='password', database='retail_chains')
cursor = cnx.cursor()

# Execute a SELECT query
query = 'SELECT * FROM customers'
cursor.execute(query)

# Print the results
for (id, first_name, last_name) in cursor:
    print(f'{id}: {first_name}, {last_name}')

# Close the connection
cnx.close()
```


## Troubleshooting

If you encounter any issues while using the project, here are a few things you can try:

- Make sure that MySQL is properly installed and configured on your computer.
- Check the documentation for the MySQL connector that you are using to ensure that you are using the correct syntax and functions.
- Ensure that you have the necessary permissions to access the database.

## Contributing

We welcome contributions to this project! If you have an idea for a new feature or a bug fix, please submit a pull request. Before submitting a pull request, please make sure to:

- Test your changes thoroughly to ensure that they are working as intended.
- Follow the project's coding style and guidelines.
- Document your changes clearly in the commit message and any relevant documentation.

## License

This project is licensed under the MIT License. See the LICENSE file for details.

## Credits

This project makes use of the following open-source libraries:

- [MySQL](https://www.mysql.com)

- [MySQL Connector](https://dev.mysql.com/downloads/connector/)

- [ChatGPT](https://chat.openai.com/) For generating this README.md :)

We would like to thank the creators and maintainers of these libraries for their valuable contributions to the open-source community.