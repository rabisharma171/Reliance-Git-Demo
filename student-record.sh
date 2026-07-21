#!/bin/bash

FILE="students.txt"

# Create database file if it doesn't exist
[ ! -f "$FILE" ] && touch "$FILE"

# ---------------------- Add Student ----------------------
add_student() {
    clear
    echo "===== ADD STUDENT ====="

    read -p "Enter Student ID: " id

    if grep -q "^$id|" "$FILE"; then
        echo "Student ID already exists!"
        return
    fi

    read -p "Enter Name: " name
    read -p "Enter Age: " age
    read -p "Enter Course: " course
    read -p "Enter Address: " address

    echo "$id|$name|$age|$course|$address" >> "$FILE"

    echo "Student Added Successfully."
}

# ---------------------- View Students ----------------------
view_students() {

    clear
    echo "============= STUDENT LIST ============="

    if [ ! -s "$FILE" ]; then
        echo "No student records found."
        return
    fi

    printf "%-8s %-20s %-8s %-20s %-20s\n" \
    "ID" "NAME" "AGE" "COURSE" "ADDRESS"

    echo "--------------------------------------------------------------------------"

   sort -t"|" -k1,1"$FILE" | while IFS="|" read id name age course address
    do
        printf "%-8s %-20s %-8s %-20s %-20s\n" \
        "$id" "$name" "$age" "$course" "$address"
    done < "$FILE"
}

# ---------------------- Search Student ----------------------
search_student() {

    clear
    echo "===== SEARCH STUDENT ====="

    read -p "Enter Student ID: " id

    result=$(grep "^$id|" "$FILE")

    if [ -z "$result" ]; then
        echo "Student Not Found."
    else
        echo
        echo "$result" | awk -F"|" \
        '{printf "ID: %s\nName: %s\nAge: %s\nCourse: %s\nAddress: %s\n",$1,$2,$3,$4,$5}'
    fi
}

# ---------------------- Update Student ----------------------
update_student() {

    clear
    echo "===== UPDATE STUDENT ====="

    read -p "Enter Student ID: " id

    if ! grep -q "^$id|" "$FILE"; then
        echo "Student Not Found."
        return
    fi

    grep -v "^$id|" "$FILE" > temp.txt

    read -p "New Name: " name
    read -p "New Age: " age
    read -p "New Course: " course
    read -p "New Address: " address

    echo "$id|$name|$age|$course|$address" >> temp.txt

    mv temp.txt "$FILE"

    echo "Student Updated Successfully."
}

# ---------------------- Delete Student ----------------------
delete_student() {

    clear
    echo "===== DELETE STUDENT ====="

    read -p "Enter Student ID: " id

    if ! grep -q "^$id|" "$FILE"; then
        echo "Student Not Found."
        return
    fi

    grep -v "^$id|" "$FILE" > temp.txt

    mv temp.txt "$FILE"

    echo "Student Deleted Successfully."
}

# ---------------------- Count Students ----------------------
count_students() {

    clear
    echo "===== TOTAL STUDENTS ====="

    total=$(wc -l < "$FILE")

    echo "Total Students = $total"
}

# ---------------------- Main Menu ----------------------

while true
do
    clear

    echo "====================================="
    echo "     STUDENT MANAGEMENT SYSTEM"
    echo "====================================="
    echo "1. Add Student"
    echo "2. View Students"
    echo "3. Search Student"
    echo "4. Update Student"
    echo "5. Delete Student"
    echo "6. Count Students"
    echo "7. Exit"
    echo "====================================="

    read -p "Enter Choice: " choice

    case $choice in

        1)
            add_student
            ;;

        2)
            view_students
            ;;

        3)
            search_student
            ;;

        4)
            update_student
            ;;

        5)
            delete_student
            ;;

        6)
            count_students
            ;;

        7)
            echo "Thank You!"
            exit
            ;;

        *)
            echo "Invalid Choice!"
            ;;

    esac

    echo
    read -p "Press Enter to Continue..."
done
