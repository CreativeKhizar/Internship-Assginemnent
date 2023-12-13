LOGFILE="logfile.log"

R="\e[31m"
G="\e[32m"
N="\e[0m"

VALIDATE() {
    if [ $1 -eq 0 ]; then
        printf "%b%s SUCCESS...%b\n" "$G" "$2" "$N"
    else
        printf "%b%s FAILED...%b\n" "$R" "$2" "$N"
    fi
}

choice="y"
echo "Welcome to In-Memory File System"
echo "1: To create a Directory"
echo "2: To Change to a Required Directory"
echo "3: To List all files and subdirectories in the directory"
echo "4: To Search a pattern in specified file"
echo "5: To display the file content"
echo "6: To create a new empty file"
echo "7: To Enter Text into a file"
echo "8: To Move a file or directory to another location"
echo "9: To Copy a file or directory to another location"
echo "10: To Remove a file or directory"

while [ "$choice" = "y" ] || [ "$choice" == "Y" ]; do
    read -p "Enter your choice : " choice2

    case "$choice2" in
        "1" )
            echo "Creating a Directory" >> "$LOGFILE" 2>&1
            read -p "Enter the Directory name to Create : " d
            if [ -d "$d" ]; then
                echo "The Directory with Name $d Already Exists";
            else
                mkdir "$d" 
                VALIDATE $? "Creating a Directory $d"
            fi 
            ;;

        "2" )
            echo "Navigating to Another Directory" >> "$LOGFILE" 2>&1
            read -p "Enter a location to Change the Directory : " loc
            if [ -d "$loc" ]; then
                cd "$loc" 
                VALIDATE $? "Changing Location of Directory to $loc"
            else
                echo "The given Location $loc does not exist";
            fi
            ;;

        "3" )
            echo "Listing all files and sub directories in a file" >> "$LOGFILE" 2>&1
            read -p "Enter the Directory Name to list all files and Sub Directories : " d
            if [ -d "$d" ]; then
                ls "$d"
                VALIDATE $? "Listing all the files and subdirectories in $d"
            else
                echo "The Directory with Name $d does not exist";
            fi
            ;;

        "4" )
            echo "Searching Pattern in a file"  >> "$LOGFILE" 2>&1
            read -p "Enter the file name to search for Pattern : " file
            if [ -f "$file" ]; then
                read -p "Enter the word to search in the file : " word
                grep -w "$word" "$file"
                VALIDATE $? "Finding word $word in file $file" 
            else
                echo "$file file not found"
            fi
            ;;

        "5" )
            echo "Displaying Contents of the File" >> "$LOGFILE" 2>&1
            read -p "Enter the file Name to display its Content : " file
            if [ -f "$file" ]; then
                cat "$file"
                VALIDATE $? "Displaying Content of $file"
            else
                echo "The File named $file does not Exist" 
            fi
            ;;

        "6" )
            echo "Creating an Empty File" >> "$LOGFILE" 2>&1
            read -p "Enter a file Name to Create an Empty File : " file
            if [ -f "$file" ]; then
                echo "$file Already Exists"
            else
                touch "$file"
                VALIDATE $? "Creating an Empty File with Name $file"
            fi
            ;;

        "7" )
            echo "Enter Text into a File" >> "$LOGFILE" 2>&1
            read -p "Enter the file Name to Enter Text into it : " file
            if [ -f "$file" ]; then
                echo "Enter the Text : "
                read text
                echo "$text" > "$file"
                VALIDATE $? "Entering Text into $file"
            else
                echo "The File named $file does not Exist" 
            fi
            ;;

        "8" )
            echo "Moving a File Or Directory" >> "$LOGFILE" 2>&1
            read -p "Enter the Name of the file to move a file or Directory : " file
            if [ -e "$file" ]; then
                read -p "Enter the location to move the file or Directory: " loc
                if [ -d "$loc" ]; then
                    mv "$file" "$loc"
                    VALIDATE $? "Moving $file to $loc"
                else
                    echo "The location $loc does not exist"
                fi
            else
                echo "The file or Directory does not exist"
            fi
            ;;

        "9" )
                echo "Copy a File or Directory to Another Location" >> "$LOGFILE" 2>&1
                read -p "Enter the location to copy : " loc
                if [ -d $loc ]
                then
                    echo "Enter a file or Directory Name to copy it " $file
                    if [ -f $file]
                    then
                        cp $f $loc
                        VALIDATE $? "Copying a file named $file to $loc location"
                    elif [ -d $file ]
                    then
                        cp -r $file $loc
                        VALIDATE $? "Copying a Directory named $file to $loc location"
                    else
                        echo "$file file or Directory doesnot Exist"
                    fi
                else
                    echo "The location $loc doesnot exist"
                fi
            ;;

        "10" )
            echo "Removing a file " >> "$LOGFILE" 2>&1
            read -p "Enter the file or Directory Name to Delete it : " file
            if [ -f $file ]
            then
                rm $file
                VALIDATE $? "Deleting a file named $file"
            elif [ -d $file ]
            then
                rm -rf $file
                VALIDATE $? "Deleting a Directory named $file"
            else
                echo "$file file or Directory doesnot exist"
            fi
            ;;

        * )
            echo "Invalid choice, Please select a valid choice."
            ;;
    esac
    read -p "Do you want to continue? Press y for yes, else n : " choice
done
echo "Thankyou for Using our Program"