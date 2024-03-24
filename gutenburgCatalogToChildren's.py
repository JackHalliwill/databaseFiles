import csv

def read_csv_to_dict(file_path):
    data = []
    with open(file_path, 'r', newline='', encoding='utf-8') as csvfile:
        reader = csv.DictReader(csvfile)
        for row in reader:
            data.append(row)
    return data

def filter_rows_by_bookshelf(data, keyword):
    filtered_data = [row for row in data if (keyword.lower() in row.get("Bookshelves", "").lower() or keyword.lower() in row.get("Subjects", "").lower())]
    return filtered_data

if __name__ == "__main__":
    file_path = "./databaseFiles/pg_catalog.csv"
    csv_data = read_csv_to_dict(file_path)
    
    # Define keyword
    keyword = "child"
    
    # Filter rows by the specified keyword in the "Bookshelves" column
    filtered_data = filter_rows_by_bookshelf(csv_data, keyword)
    
    print(len(filtered_data))
