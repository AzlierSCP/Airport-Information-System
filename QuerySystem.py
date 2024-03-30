# Import the necessary libraries
import mysql.connector

# Connect to the database
conn = mysql.connector.connect(host='---', user='---', password='~---', database='---')
c = conn.cursor()

# Define the menu options
while True:
    print("\nMenu Options:")
    print("1. Insert a new technician into the database.")
    print("2. Delete an existing airplane from the database.")
    print("3. Update the expertise of an existing technician.")
    print("4. List the details of the technician whose salary is greater than the average of the salary of all technicians.")
    print("5. List all the model numbers that a given technician has the expertise, along with their capacity and weight information.")
    print("6. List the total number of technicians who are experts in each model.")
    print("7. List the details (test number, test name, maximum score, etc.) of the FAA tests for a given airplane, sorted by the maximum scores.")
    print("8. List the most recent annual medical examination and his/her union membership number for each traffic controller.")
    print("9. List the total number of tests done by each technician for a given airplane.")
    print("10. List the name of the technician, the registration number of the airplane, and the FAA number of those tests done between September 2005 and December 2005, sorted by the FAA numbers.")
    print("0. Exit")

    # Get the user's input
    choice = int(input("Enter your choice: "))

    # Execute the corresponding menu option
    if choice == 1:
        # Insert a new technician into the database
        ssn = input("Enter the technician's ssn: ")
        name = input("Enter the technician's name: ")
        address = input("Enter the technician's address: ")
        phone = input("Enter the technician's phone: ")
        salary = float(input("Enter the technician's salary: "))
        model_no = int(input("Enter the work for model_no: "))
        expertise = input("Enter the technician's expertise: ")
        union_membership_no = int(input("Enter the union_membership_no: "))
        c.execute("INSERT INTO employee VALUES (?, ?, ?, ?, ?, ?, ?)", [ssn, name, address, phone, salary, 'technician', union_membership_no])
        c.execute("INSERT INTO expertise VALUES (?, ?, ?)", [ssn, model_no, expertise])
        conn.commit()
        print("Technician added successfully.")

    elif choice == 2:
        # Delete an existing airplane from the database
        registration_number = input("Enter the registration number of the airplane you want to delete: ")
        c.execute("DELETE FROM airplane WHERE registration_no='"+registration_number+"'")
        conn.commit()
        print("Airplane deleted successfully.")

    elif choice == 3:
        # Update the expertise of an existing technician
        ssn = input("Enter the ssn of the technician: ")
        expertise = input("Enter the new expertise of the technician: ")
        c.execute("UPDATE expertise SET expertise='"+expertise+"' WHERE technician_ssn='"+ssn+"'")
        conn.commit()
        print("Expertise updated successfully.")

    elif choice == 4:
        # List the details of the technician whose salary is greater than the average of the salary of all technicians
        c.execute("SELECT * FROM employee WHERE  type='technician' and salary >(SELECT AVG(salary) FROM employee WHERE  type='technician')")
        rows = c.fetchall()
        for row in rows:
            print(row)

    elif choice == 5:
        # List all the model numbers that a given technician has the expertise, along with their capacity and weight information
        ssn = input("Enter the name of the ssn: ")
        c.execute("SELECT model_no, capacity, weight FROM model WHERE model_no IN (SELECT model_no FROM expertise WHERE technician_ssn='"+ssn+"')")
        rows = c.fetchall()
        for row in rows:
            print(row)

    elif choice == 6:
        # List the total number of technicians who are experts in each model
        c.execute("SELECT model_no, COUNT(*) FROM expertise GROUP BY model_no")
        rows = c.fetchall()
        for row in rows:
            print(row)



    elif choice == 7:
        # List the details (test number, test name, maximum score, etc.) of the FAA tests for a given airplane, sorted by the maximum scores
        registration_number = input("Enter the registration number of the airplane: ")
        c.execute(
            "SELECT t.test_no, t.`name`, a.maxscore FROM (SELECT d.test_no, MAX(d.score) AS maxscore FROM test_details d WHERE d.registration_no = '" + registration_number + "' GROUP BY d.test_no) a LEFT JOIN test t ON t.test_no = a.test_no ORDER BY a.maxscore")
        rows = c.fetchall()
        for row in rows:
            print(row)

    elif choice == 8:
        # List the most recent annual medical examination and his/her union membership number for each traffic controller
        c.execute(
            "SELECT c.*,e.union_membership_no FROM `controller` c LEFT JOIN employee e on c.ssn = e.ssn")
        rows = c.fetchall()
        for row in rows:
            print(row)

    elif choice == 9:
        # List the total number of tests done by each technician for a given airplane
        registration_number = input("Enter the registration number of the airplane: ")
        c.execute(
            "SELECT d.technician_ssn, count(d.date) FROM test_details d where d.registration_no='"+registration_number+"' GROUP BY d.technician_ssn")
        rows = c.fetchall()
        for row in rows:
            print(row)

    elif choice == 10:
        # List the name of the technician, the registration number of the airplane, and the FAA number of those tests done between September 2005 and December 2005, sorted by the FAA numbers
        c.execute(
            "SELECT e.`name`, t.registration_no, t.test_no FROM test_details t LEFT JOIN employee e on t.technician_ssn = e.ssn WHERE t.date BETWEEN '2005-09-01' AND '2005-12-31' ORDER BY t.test_no")
        rows = c.fetchall()
        for row in rows:
            print(row)

    elif choice == 0:
        # Exit the program
        conn.close()
        print("System Closed!")
        break

    else:
        print("Invalid choice. Please enter 0~10")



